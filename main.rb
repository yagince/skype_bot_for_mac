require "rubygems"
require "bundler/setup"
require "yaml"

require_relative "github_notifier"
require_relative "jenkins_notifier"
require_relative "settings"

def config
  @config ||= Settings.new
end

GithubNotifier.new(config).notify_all
JenkinsNotifier.new(config).notify_all
