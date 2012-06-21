require "open-uri"
require_relative "base_notifier"

class GithubNotifier < BaseNotifier

  def rss_body
    open(@url)
  end

  def title
    "Github"
  end

  def message(item)
<<-EOM
==Github Activity Notify==
#{item.title}
#{item.link}
detail:
#{strip_tags(CGI.unescapeHTML(item.content)).gsub(/\s*\n/, "").gsub(/\s+/, " ")}
==========================
EOM
  end

  def notified_list_name
    "github.notified_list.txt"
  end

  def url
    @config.github.atom_url
  end

end
