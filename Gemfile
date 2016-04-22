source 'https://rubygems.org'
ruby "2.3.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.beta3'
gem 'rails_12factor'
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer'

gem 'foundation-rails', '~> 6.2.0'
gem 'sass-rails'
gem 'autoprefixer-rails'
gem 'haml-rails', '~> 0.9'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use Puma as the app server
gem 'puma'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'newrelic_rpm'

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
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
