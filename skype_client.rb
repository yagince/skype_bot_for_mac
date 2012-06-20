require "rb-skypemac"
require_relative "base_client"

include SkypeMac

class SkypeClient < BaseClient
  def send_message(message)
    send_command "CHATMESSAGE #{@config['chat_id']} #{message}"
  end

  def chat_ids
    send_command("SEARCH RECENTCHATS").sub("CHATS ","").split(/,/)
  end

  def room_name(chat_id)
    name_ary = send_command("GET CHAT #{chat_id} FRIENDLYNAME").scan(/.*FRIENDLYNAME\s(.+)$/)
    name_ary.empty? ? "" : name_ary[0][0]
  end

  private
  def send_command(command)
    Skype.send_(command: command)
  end
end
