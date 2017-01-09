# require 'dotenv'
# Dotenv.load
#
# require 'http' # https://github.com/httprb/http
# require 'telegram/bot'
#
# # Example interface to facilitate sending messages to the Dialog API.
# module Dialog
#   # @param message [Telegram::Bot::Types::Message, Hash]
#   def track(message)
#     # Outbound
#     payload = if message.is_a?(Hash)
#       {
#         message: {
#           platform: 'telegram',
#           to: message['result']['chat']['id'],
#           sent_at: message['result']['date'],
#           distinct_id: message['result']['message_id'],
#           properties: {
#             text: message['result']['text']
#           }
#         }
#       }
#
#     # Inbound message
#     else
#       {
#         message: {
#           platform: 'telegram',
#           from: message.from.id,
#           sent_at: message.date,
#           distinct_id: message.message_id,
#           properties: {
#             text: message.text
#           }
#         }
#       }
#     end
#
#     HTTP.post("https://api.dialoganalytics.com/v1/messages?token=#{ENV['DIALOG_TOKEN']}", json: payload)
#   end
#   module_function :track
# end
#
#
#
# # # 1. messages table with a type column [kik, messenger, telegram] and a message_type [text, etc]
# # # 2. kik_messages, messenger_messages, telegram_messages tables with a type column [text, etc]
# #
# #
# # # Inbound
# # args = {
# #   from: user.id,
# #   to: self.id,
# #   platform: :telegram,
# #   sent_at: date,
# #   distinct_id: message.id,
# #   conversation_id: chat.id,
# #   type: [...]
# # }
# # track(args)
# #
# # # Outbound
# # args = {
# #   from: self.id,
# #   to: user.id,
# #   platform: :telegram,
# #   sent_at: date,
# #   distinct_id: message.id,
# #   conversation_id: chat.id,
# #   type: [...],
# #   properties: {
# #     text: "..."
# #   }
# # }
# # track(args)
# #
# # Text
# # - text
# #
# # Document
# # - file_size
# # - mime_type
# #
# # Video
# # - file_size
# # - duration
# #
# # Image
# # - file_size
# #
# #
# # class Message
# #   id:
# #   type: kik, messenger, telegram
# #   from:
# #   to:
# #   sent_at:
# #   text:
# #   distinct_id: message.id
# #   conversation_id:
# # end
# #
# #
# # Dialog::Message.track(message)
# #
# # require 'ostruct'
# #
# # class Dialog
# #
# #   # @param hash [Hash]
# #   # @return OpenStruct
# #   def convert(hash)
# #     Json.parse(hash.to_json, object_class: OpenStruct)
# #   end
# #
# #   # @param message [Telegram::Bot::Types::Message]
# #   def self.track(interaction)
# #     # Outbound interaction
# #     if interaction['ok']
# #       {
# #         message: {
# #           text: interaction['result']['text'],
# #           from: interaction['result']['from']['id'],
# #           date: interaction['result']['date'],
# #           properties: {
# #             platform: 'telegram',
# #             platform_message_id: interaction['result']['message_id']
# #           }
# #         }
# #       }
# #
# #     # Inbound interaction
# #     else
# #       if interaction.text.present?
# #         Message.track(interaction)
# #       elsif interaction.document.present?
# #         Document.track(interaction)
# #       elsif interaction.photo.present?
# #         Photo.track(interaction)
# #       elsif interaction.voice.present?
# #         Voice.track(interaction)
# #       elsif interaction.sticker.present?
# #         Sticker.track(interaction)
# #       end
# #     end
# #
# #   end
# #
# #
# #   class Message
# #     def self.track(interaction)
# #       {
# #         message: {
# #           text: interaction.text,
# #           from: interaction.from.id,
# #           date: interaction.date,
# #           properties: {
# #             platform: 'telegram',
# #             platform_message_id: interaction.message_id
# #           }
# #         }
# #       }
# #     end
# #   end
# #
# #   class Document
# #     def self.track(interaction)
# #       {
# #         document: {
# #           file_name: interaction.document.file_name,
# #           file_size: interaction.document.file_size,
# #           mime_type: interaction.document.mime_type,
# #           from: interaction.from.id,
# #           date: interaction.date,
# #           properties: {
# #             platform: 'telegram',
# #             platform_message_id: interaction.message_id
# #           }
# #         }
# #       }
# #     end
# #   end
# #
# #   class Photo
# #     def self.track(interaction)
# #       {
# #         photo: {
# #           from: interaction.from.id,
# #           date: interaction.date,
# #           properties: {
# #             platform: 'telegram',
# #             platform_message_id: interaction.message_id
# #           }
# #         }
# #       }
# #     end
# #   end
# #
# #   class Voice
# #     def self.track(interaction)
# #       {
# #         voice: {
# #           from: interaction.from.id,
# #           date: interaction.date,
# #           properties: {
# #             platform: 'telegram',
# #             platform_message_id: interaction.message_id
# #           }
# #         }
# #       }
# #     end
# #   end
# #
# #   class Sticker
# #     def self.track(interaction)
# #       {
# #         sticker: {
# #           from: interaction.from.id,
# #           date: interaction.date,
# #           properties: {
# #             platform: 'telegram',
# #             platform_message_id: interaction.message_id
# #           }
# #         }
# #       }
# #     end
# #   end
# # end
