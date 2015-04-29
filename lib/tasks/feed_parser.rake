require 'feed_parser'

desc "This task is called by the Heroku cron add-on"
task :feed_parser => :environment do
  Tessitura::FeedParser.sync_feed
end