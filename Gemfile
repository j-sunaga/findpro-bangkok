# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Core
gem 'rails', '~> 5.2.4'

# Middleware
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'unicorn'

# View/Front
gem 'coffee-rails', '~> 4.2'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# pagenation
gem 'kaminari', '~> 0.17.0'

# Image
gem 'carrierwave', '~> 2.0'
gem "mini_magick"

# Backend
gem 'bootsnap', '>= 1.1.0', require: false
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'

gem 'devise'

gem 'whenever', :require => false

gem 'faker'

# admin
gem 'rails_admin', '~> 2.0'
gem 'cancancan'

gem 'ransack'

#env
gem 'dotenv-rails'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'letter_opener_web'
  # Debug
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  # Rspec
  gem 'spring'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'factory_bot_rails'
  gem 'launchy'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  gem 'brakeman' #脆弱性チェック
end

group :test do
  gem 'capybara', '~> 2.13'
  gem 'webdrivers'
end

gem 'tzinfo-data'
