heroku pgbackups:capture --expire --app pifa-production
curl -o latest.dump `heroku pgbackups:url --app pifa-production`
sudo -u postgres pg_restore --verbose --clean --no-acl --no-owner -d pifa-2013_production -U postgres latest.dump 
rm latest.dump