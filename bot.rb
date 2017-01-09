require 'dotenv'
Dotenv.load

require 'active_support/core_ext/hash'

require 'pry'

# Example interface to facilitate sending messages to the Dialog API.
require 'dialog-api'
require 'telegram/bot'

class DialogTelegram
  def initialize(client)
    @client = client
  end

  # @param message [Telegram::Bot::Types::Message]
  def incoming(message)
    payload = {
      message: {
        distinct_id: message.message_id,
        sent_at: message.date,
        properties: {
          text: message.text
        },
      },
      creator: {
        type: 'interlocutor',
        distinct_id: message.from.id,
        first_name: message.from.first_name,
        last_name: message.from.last_name,
        username: message.from.username
      },
      conversation: {
        distinct_id: message.chat.id
      }
    }.deep_merge(dialog_attributes(message))

    @client.track(payload)
  end

  # @param message [Hash]
  def outgoing(message)
    payload = {
      message: {
        distinct_id: message['result']['message_id'],
        sent_at: message['result']['date'],
        properties: {
          text: message['result']['text']
        },
      },
      creator: {
        distinct_id: @client.bot_id,
        type: 'bot'
      },
      conversation: {
        distinct_id: message['result']['chat']['id']
      }
    }.deep_merge(dialog_attributes(message))

    @client.track(payload)
  end

  private

  # @param message []
  def dialog_attributes(message)
    {
      message: {
        platform: 'telegram',
        provider: 'dialog-ruby',
        mtype: 'text'
      }
    }
  end
end

# Create a Dialog API client
client = Dialog.new({
  api_token: ENV.fetch('DIALOG_API_TOKEN'),
  bot_id: ENV.fetch('DIALOG_BOT_ID'),
  on_error: Proc.new do |status, message, detail|
    p [status, message, detail]
  end,
  debug: true
})

# Create a Dialog tracking helper
dialog = DialogTelegram.new(client)

Telegram::Bot::Client.run(ENV.fetch('TELEGRAM_TOKEN')) do |bot|
  bot.listen do |message|
    case message.text
    when 'text'
      dialog.incoming(message)

      bot.api.send_message(chat_id: message.chat.id, text: "Hello world!").tap do |response|
        dialog.outgoing(response)
      end
    when 'photo'
      dialog.incoming(message)

      bot.api.send_photo(chat_id: message.chat.id, photo: "https://dialoganalytics.com/images/og-image.png").tap do |response|
        dialog.outgoing(response)
      end

    end
  end
end
