# -*- coding: utf-8 -*-
require 'net/http'
require_relative "base_notifier"

class JenkinsNotifier < BaseNotifier

  def rss_body
    Net::HTTP.start(@atom_url){|http|
      req=Net::HTTP::Get.new(@config['jenkins']['rss_category'])
      req.basic_auth(@config['jenkins']['user'],@config['jenkins']['pass'])
      http.request(req).body
    }
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

  def url_key
    'jenkins_rss_host'
  end

end
