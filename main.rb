require "rubygems"
require "bundler/setup"
require "yaml"

require_relative "github_notifier"
require_relative "jenkins_notifier"
require_relative "settings"

def config
  @config ||= Settings.new
end

GithubNotifier.new(config).notify_all if config.github.enable
JenkinsNotifier.new(config).notify_all if config.jenkins.enable
