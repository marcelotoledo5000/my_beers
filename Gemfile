# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'bcrypt', '~> 3.1'
gem 'bootsnap', '~> 1.4'
gem 'cancancan', '~> 3.1'
gem 'dotenv-rails', '~> 2.7'
gem 'kaminari', '~> 1.2'
gem 'pg', '~> 1.2'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0'

group :development, :test do
  gem 'codecov', require: false
  gem 'database_cleaner', '~> 1.8'
  gem 'factory_bot_rails', '~> 5.1'
  gem 'faker', '~> 2.11'
  gem 'pry-byebug', '~> 3.8'
  gem 'rspec-rails', '~> 4.0'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubycritic', '~> 4.3'
  gem 'shoulda-matchers', '~> 4.3'
  gem 'simplecov'
end

group :development do
  gem 'brakeman', '~> 4.7'
  gem 'listen', '~> 3.2'
  gem 'spring', '~> 2.1'
  gem 'spring-watcher-listen', '~> 2.0'
end
