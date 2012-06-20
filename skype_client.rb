require "rb-skypemac"
require_relative "base_client"

include SkypeMac

class SkypeClient < BaseClient
  def send_message(message)
    Skype.send_(command: "CHATMESSAGE #{@config['chat_id']} #{message}")
  end
end
