require "action_view"
require "awesome_print"
require "simple-rss"
require "open-uri"
require "yaml"
require_relative "skype_client"

class BaseNotifier
  include ActionView::Helpers::SanitizeHelper

  def initialize(config)
    @config = config
    @url = url
    @chat_id = config.chat_id
    @client = SkypeClient.new(config)

    Dir.chdir(File.dirname(__FILE__))
    %x(touch #{notified_list_name}) unless File.exist?(notified_list_name)

    File.open(notified_list_name, "r") { |notified_list|
      @notified_items = notified_list.readlines.map{|l| l.chomp}.reduce({}) do |table, item_id|
        table[item_id] = true
        table
      end
    }
  end

  def get_items
    SimpleRSS.parse(rss_body).items.select {|item| !@notified_items[item.id]}
  end

  def notify(item)
    message = message(item)
    @client.send_message(message)
    puts "send message following:\n#{message}"
    log_item(item)
  end

  def log_item(item)
    unless @notified_items[item.id]
      @notified_items[item.id] = true
      File.open(notified_list_name, "a") {|file| file.write(item.id + "\n")}
    end
  end

  def notify_all
    get_items.each{ |item| notify item }
  end
end
