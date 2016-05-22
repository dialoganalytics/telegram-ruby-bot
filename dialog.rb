require 'dotenv'
Dotenv.load

require 'http' # https://github.com/httprb/http
require 'telegram/bot'

module Dialog
  # @param message [Telegram::Bot::Types::Message, Hash]
  def track(message)
    # Outbound
    payload = if message.is_a?(Hash)
      {
        message: {
          platform: 'telegram',
          to: message['result']['chat']['id'],
          sent_at: message['result']['date'],
          distinct_id: message['result']['message_id'],
          properties: {
            text: message['result']['text']
          }
        }
      }

    # Inbound message
    else
      {
        message: {
          platform: 'telegram',
          from: message.from.id,
          sent_at: message.date,
          distinct_id: message.message_id,
          properties: {
            text: message.text
          }
        }
      }
    end

    HTTP.post("https://api.dialoganalytics.com/v1/messages?token=#{ENV['DIALOG_TOKEN']}", json: payload)
  end
  module_function :track
end

