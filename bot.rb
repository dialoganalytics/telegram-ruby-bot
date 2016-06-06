require 'dotenv'
Dotenv.load

# Example interface to facilitate sending messages to the Dialog API.
require_relative './dialog'
require 'telegram/bot'

Telegram::Bot::Client.run(ENV.fetch('TELEGRAM_TOKEN')) do |bot|
  bot.listen do |message|
    case message.text
    when '/test'
      Dialog.track(message)

      text = "Welcome to test"
      response = bot.api.send_message(chat_id: message.chat.id, text: text)
      Dialog.track(response)
    end
  end
end
