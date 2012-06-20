SkypeBot for Mac
================

github,jenkinsからの通知を拾ってSkypeに投げるbotです。  
cron等で実行してください。

```ruby
ruby main.rb
```

config/settings.yml
-------------------

```yaml
# github
github_atom_url: "https://github.com/organizations/hogehoge/hogehoge.private.atom?token=xxxxxxx"

#jenkins
jenkins_rss_host: "jenkins.xxx.com"
jenkins:
  rss_category: "/rssAll"
  user: 'someone' # basic認証のユーザー
  pass: 'password' # basic認証のパスワード

#skype
chat_id: "#xxxxxxxxx/$xxx;xxxxx"
```

* github_atom_url : githubのcommitsやpublic activityのRSSのURL
* jenkins_rss_host : jenkinsのホスト名
* jenkins
    * rss_category : /rssAllとか/rssFailedとか  
    * user : jenkinsのユーザー  
    * password : jenkinsのパスワード
* chat_id  
SkypeClient#chat_ids  
SkypeClient#room_name  
でchat_idを調べて下さい  
