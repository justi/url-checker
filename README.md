# url-checker

[![GetBadges Game](https://justi-url-checker.getbadges.io/shield/company/justi-url-checker)](https://justi-url-checker.getbadges.io/?ref=shield-game)
[![Build Status](https://travis-ci.org/justi/url-checker.svg?branch=master)](https://travis-ci.org/justi/url-checker)

Check provided url(s) for valid status codes and/or redirects

gem install httparty mail

Config for gmail - turn on "for less secure apps"
https://www.google.com/settings/security/lesssecureapps

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
