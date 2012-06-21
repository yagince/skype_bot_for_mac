# -*- coding: utf-8 -*-
require 'net/http'
require_relative "base_notifier"

class JenkinsNotifier < BaseNotifier

  def rss_body
    Net::HTTP.start(@url){|http|
      req=Net::HTTP::Get.new(jenkins_config.rss_category)
      req.basic_auth(jenkins_config.user,jenkins_config.pass) if jenkins_config.basic_auth
      http.request(req).body
    }
  end

  def title
    "jenkins"
  end

  def message(item)
<<-EOM
==Jenkins ビルド結果==
#{item.published}
#{item.title}
==========================
EOM
  end

  def notified_list_name
    "jenkins.notified_list.txt"
  end

  def url
    @config.jenkins.rss_host
  end

  private
  def jenkins_config
    @config.jenkins
  end

end
