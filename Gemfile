source 'https://rubygems.org'

ruby '3.3.1'

# Core gems
gem 'rails', '~> 7.1.3'
gem 'pg'
gem 'puma'  # recommended over webrick

# Asset Pipeline
gem 'sprockets-rails'
gem 'importmap-rails'  # For modern JavaScript handling
gem 'turbo-rails'      # Replaces turbolinks
gem 'stimulus-rails'   # For JavaScript components
gem 'sassc-rails'      # replaces sass-rails
gem 'bootstrap', '~> 5.3'  # replaces bootstrap-sass

# Features from your existing app
gem 'friendly_id'
gem 'chartkick'
gem 'groupdate'
gem 'bcrypt'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-rails_csrf_protection'  # security requirement
gem 'simple_form'

# Utilities
gem 'jbuilder'
gem 'font-awesome-rails'
gem 'aasm'
gem 'virtus'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'  # replaces factory_girl_rails
  gem 'faker'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
end

group :development do
  gem 'web-console'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'rails-erd'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'launchy'
end
