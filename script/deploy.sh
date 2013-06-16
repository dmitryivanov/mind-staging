# deploy commands

git push boa-production master

heroku run rake db:migrate --app boa-production

heroku run rake rds:migrate --app boa-production

heroku restart