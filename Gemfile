source 'https://rubygems.org'
ruby '2.5.0'

gem 'rails', '4.2.11.1'
gem 'pg', '~> 0.21'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer'

gem 'foundation-rails', '~> 6.2.0'
gem 'sass-rails'
gem 'autoprefixer-rails'
gem 'haml-rails', '~> 0.9'

gem 'jquery-rails'
gem 'react-rails'

gem 'puma'

gem 'devise', '~> 4.4.3'
gem 'aws-sdk'

gem 'activeadmin'

gem 'sitemap_generator'

gem 'comfortable_mexican_sofa', git: 'https://github.com/rossettistone/comfortable-mexican-sofa', branch: 'markdown-fix-1.12.10'

gem 'http'

gem 'newrelic_rpm'
gem 'bugsnag'

# For charts in /admin
gem 'chartkick', '~> 1.5.0'
gem 'groupdate', '~> 2.5.3'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development do
  gem 'http_logger'
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'capybara', '~> 2.7.1'
  gem 'capybara-webkit'
  gem 'simplecov'
  gem 'codeclimate-test-reporter', '~> 1.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
