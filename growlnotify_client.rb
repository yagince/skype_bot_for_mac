require_relative 'base_client'

class GrowlnotifyClient < BaseClient
  def send_message(message, title="")
    %x(/usr/local/bin/growlnotify -t #{title} -m "#{message.gsub(/\n/, ' ')}")
  end
end
