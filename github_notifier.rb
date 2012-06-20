require "action_view"
require "awesome_print"
require "simple-rss"
require "open-uri"
require "yaml"
require_relative "skype_client"

class GithubNotifier
  include ActionView::Helpers::SanitizeHelper

  def initialize(config)
    @atom_url = config['atom_url']
    @chat_id = config['chat_id']
    @client = SkypeClient.new(config)

    Dir.chdir(File.dirname(__FILE__))

    unless File.exist?("notified_list.txt")
      File.open("notified_list.txt", "w") {|file| puts "Create notified_list.txt"}
    end

    File.open("notified_list.txt", "r") { |notified_list|
      @notified_items = notified_list.readlines.map{|l| l.chomp}.reduce({}) do |table, item_id|
        table[item_id] = true
        table
      end
    }
  end

  def get_items
    SimpleRSS.parse(open(@atom_url)).items.select {|item| !@notified_items[item.id]}
  end

  def notify(item)
    message = <<-EOM
==Github Activity Notify==
#{item.title}
#{item.link}
detail:
#{strip_tags(CGI.unescapeHTML(item.content)).gsub(/\s*\n/, "").gsub(/\s+/, " ")}
==========================
EOM

    @client.send_message(message)
    puts "send message following:\n#{message}"
    log_item(item)
  end

  def log_item(item)
    unless @notified_items[item.id]
      @notified_items[item.id] = true
      File.open("notified_list.txt", "a") {|file| file.write(item.id + "\n")}
    end
  end
end
