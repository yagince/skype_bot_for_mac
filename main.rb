require "rubygems"
require "bundler/setup"
require "yaml"

require_relative "github_notifier"
require_relative "jenkins_notifier"

def config
  @config ||= YAML.load_file("config/settings.yml")
end

GithubNotifier.new(config).notify_all
JenkinsNotifier.new(config).notify_all
