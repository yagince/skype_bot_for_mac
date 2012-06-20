# -*- coding: utf-8 -*-
require_relative "base_notifier"

class JenkinsNotifier < BaseNotifier

  def message(item)
<<-EOM
==Jenkins ビルド結果==
#{item.title}
#{item.link}
detail:
#{strip_tags(CGI.unescapeHTML(item.content)).gsub(/\s*\n/, "").gsub(/\s+/, " ")}
==========================
EOM
  end

  def notified_list_name
    "jenkins.notified_list.txt"
  end

  def url_key
    'jenkins_rss_url'
  end

end
