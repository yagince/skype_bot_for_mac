require_relative 'base_client'
require_relative 'skype_client'
require_relative 'growlnotify_client'

class MultiClient < BaseClient
  def initialize(config)
    super(config)
    @clients = [SkypeClient.new(config), GrowlnotifyClient.new(config)]
  end

  def send_message(message, title="")
    @clients.each{ |client| client.send_message(message, title) }
  end
end
