get 'https://getbadges.io', response_code: 200
get 'https://getbadges.io?ref=producthunt', response_code: 200
get 'https://getbadges.io/login', response_code: 200
get 'https://getbadges.io/register', response_code: 200
get 'https://getbadges.io/register/', response_code: 200
get 'https://getbadges.io/register', response_code: 301, redirect_url: 'https://getbadges.io/register/'

get 'https://getbadges.io/', response_code: 301, redirect_url: 'https://getbadges.io'
get 'http://getbadg.es', response_code: 301, redirect_url: 'https://getbadges.io'
get 'http://getbadges.io', response_code: 301, redirect_url: 'https://getbadges.io'

get 'http://www.getbadges.io', response_code: 301, redirect_url: 'https://getbadges.io'
get 'https://www.getbadges.io', response_code: 301, redirect_url: 'https://getbadges.io'
get 'https://getbadges.getbadges.io', response_code: 301, redirect_url: 'https://getbadges.io/login'

post 'https://getbadges.io', body: {content: 3}, response_code: 200

get 'https://justi-url-checker.getbadges.io', response_code: 301, redirect_url: 'https://justi-url-checker.getbadges.io/activity'
get 'https://justi-url-checker.getbadges.io/activity', response_code: 200
get 'https://justi-url-checker.getbadges.io/leaderboard', response_code: 200
get 'https://justi-url-checker.getbadges.io/player/1', response_code: 200
get 'https://justi-url-checker.getbadges.io/monster/1235', response_code: 200

get 'https://justi-url-checker.getbadges.io/images/59-level-up.png', content_type: 'image/png'
get 'https://justi-url-checker.getbadges.io/?ref=shield-game', response_code: 301, redirect_url: 'https://justi-url-checker.getbadges.io/activity'
get 'https://justi-url-checker.getbadges.io/shield/company/justi-url-checker', response_code: 301, content_type: 'image/svg+xml;charset=utf-8'