# url-checker

[![Join the chat at https://gitter.im/url-checker/Lobby](https://badges.gitter.im/url-checker/Lobby.svg)](https://gitter.im/url-checker/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![GetBadges Game](https://justi-url-checker.getbadges.io/shield/company/justi-url-checker)](https://justi-url-checker.getbadges.io/?ref=shield-game)
[![Build Status](https://travis-ci.org/justi/url-checker.svg?branch=master)](https://travis-ci.org/justi/url-checker)

Check provided url(s) for valid status codes and/or redirects

gem install httparty mail

You should set the following ENVs in you `.bashrc` file:

```
export URL_CHECKER_MAILER_HOST='smtp.gmail.com'
export URL_CHECKER_MAILER_PORT='587'
export URL_CHECKER_MAILER_USERNAME='YOUR_USERNAME'
export URL_CHECKER_MAILER_PASSWORD='YOUR_PASSWORD'
export URL_CHECKER_MAILER_ADMIN='admin@yourdomain.com'
```

For tests, run:
ruby run.rb example.rb

GMAIL config
- enable gmail "for less secure apps"
https://www.google.com/settings/security/lesssecureapps
- chcek you gmail for authorizing new incoming request, set it "as you"
- if still not working (Net::SMTPAuthenticationError), probably you try to connect from unknown location
In Incognito, login to your gmail and go to https://accounts.google.com/DisplayUnlockCaptcha, then try to send email again
