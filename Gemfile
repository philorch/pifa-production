source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem 'rest-client'
gem 'pg', "~> 0.12.2"                   # For storing things in a database
gem 'bcrypt-ruby', '~> 3.0.0'           # To use ActiveModel has_secure_password
gem 'exceptional', "~> 2.0.32"          # For Error Tracking
gem 'jquery-rails', "~> 2.0.0"          # For ease-of-inclusion
gem 'ie_iframe_cookies', "~> 0.1.2"     # For IE iFrame cookie compatibility
gem "fog", "~> 1.3.1"					          # For storing uploaded files on S3
gem 'rmagick'							              # For processing images
gem 'carrierwave'			                  # For uploading images
gem 'devise', "~> 2.0.0"                # For creating and managing user and user states
gem "mail"								              # For sending email
gem "chronic", "~> 0.8.0"				        # For parsing date strings
gem 'sunspot_rails'                     # Client for handling solr indexing
gem 'progress_bar'
gem 'delayed_job_active_record'
gem 'simple-rss'
gem 'htmlentities'
gem 'ckeditor_rails'
gem 'capistrano'
gem 'sunspot_solr'                      # Indexer for local dev search / backup server
gem 'heroku'
gem 'taps'


group :production do
  gem 'unicorn'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'        # Compile SASS
  gem 'coffee-rails', '~> 3.2.1'        # Compile CoffeeScript, eww..
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'foreman'                         # Run server as it will run live
  gem 'taps'
  gem 'nifty-generators'                # For making prettier scaffolds
  gem 'sqlite3'
end
