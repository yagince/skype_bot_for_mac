require "rubygems"
require "bundler/setup"
require "yaml"

require_relative "github_notifier"

def config
  @config ||= YAML.load_file("config/settings.yml")
end

notifier = GithubNotifier.new(config)
notifier.get_items.each do |item|
  notifier.notify item
end
