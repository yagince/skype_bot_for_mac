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
github:
  enable: true
  atom_url: "https://github.com/organizations/hogehoge/hogehoge.private.atom?token=xxxxxxx"

#jenkins
jenkins:
  enable: true
  rss_host: "jenkins.xxx.com"
  rss_category: "/rssAll"
  basic_auth: true
  user: 'someone'
  pass: 'password'

#skype
skype:
  enable: false
  chat_id: "#xxxxxxxxx/$xxx;xxxxx"

#growlnotify mac only
growlnotify:
  enable: false
```

* github
    * enable : githubのチェックON/OFF true->ON false->OFF
    * url : githubのcommitsやpublic activityのRSSのURL
* jenkins
    * enable : jenkinsのチェックON/OFF true->ON false->OFF
    * rss_host : jenkinsのホスト名
    * rss_category : /rssAllとか/rssFailedとか  
    * user : jenkinsのユーザー  
    * password : jenkinsのパスワード
* skype
    * enable : skype通知のOnOFF
    * chat_id  
    SkypeClient#chat_ids  
    SkypeClient#room_name  
    でchat_idを調べて下さい  
* growlnotify
    * enable : growlへの通知OnOFF