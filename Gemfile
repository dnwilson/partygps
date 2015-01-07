#ruby=2.1.3@pgps
source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~>3.2.0'
gem 'bootstrap_form'
gem 'simple_form'
gem 'carrierwave'
gem 'country_select'
gem 'devise'
gem 'cancancan'
gem 'font-awesome-rails'
gem "jquery-fileupload-rails"
gem 'jquery-colorbox-rails'
gem 'mini_magick'
gem 'rails_admin'
gem 'thin'
gem 'bourbon'
gem 'twitter'
gem 'json'
gem 'airbrake'
gem 'koala'
gem 'omniauth'
gem 'omniauth-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem "geocoder"
gem 'slim-rails'
gem "browser"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

group :development, :test do
   gem 'forgery'
   gem 'factory_girl_rails'
   gem 'spring-commands-rspec'
   gem 'rspec-rails'
   gem 'guard-rspec'
   gem 'pry-nav'
   gem 'rb-fsevent' if `uname` =~ /Darwin/
end

group :development do
   gem 'better_errors'
   gem 'binding_of_caller'
   # gem 'meta_request'
   # gem 'rack-mini-profiler'
   gem 'bullet'
   gem 'rails_layout'
   gem 'pry-rails'
end

group :test do
   gem 'capybara', '~> 2.1'
   gem 'webmock'
   gem 'vcr'
   # gem 'growl'
end

group :production do
  gem "rails_12factor"
  gem "unicorn"
  gem "newrelic_rpm"
  gem "dalli"
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

