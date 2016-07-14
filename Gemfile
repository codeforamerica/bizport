source 'https://rubygems.org'
ruby "2.3.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
gem 'rails_12factor'
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer'

gem 'foundation-rails', '~> 6.2.0'
gem 'sass-rails'
gem 'autoprefixer-rails'
gem 'haml-rails', '~> 0.9'

gem 'jquery-rails'

gem 'puma'

gem 'devise'
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin'

gem 'sitemap_generator'

gem 'comfortable_mexican_sofa'

gem 'newrelic_rpm'
gem 'bugsnag'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  gem 'capistrano', '3.4.0'
  gem 'capistrano-rbenv', '2.0.4'
  gem 'capistrano-rails', '1.1.6'
  gem 'capistrano3-puma', git: 'https://github.com/seuros/capistrano-puma', branch: 'master'
  gem 'http_logger'
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'codeclimate-test-reporter', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
