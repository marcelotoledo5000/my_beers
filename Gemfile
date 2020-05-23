# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'bcrypt', '~> 3.1'
gem 'bootsnap', '~> 1.4'
gem 'cancancan', '~> 3.0'
gem 'kaminari', '~> 1.1'
gem 'pg', '~> 1.2'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0'

group :development, :test do
  gem 'database_cleaner', '~> 1.7'
  gem 'factory_bot_rails', '~> 5.1'
  gem 'faker', '~> 2.10'
  gem 'pry-byebug', '~> 3.7'
  gem 'rspec-rails', '~> 4.0.0.beta3'
  gem 'rubocop', '~> 0.78.0'
  gem 'rubocop-performance', '~> 1.5'
  gem 'rubocop-rails', '~> 2.4'
  gem 'rubocop-rspec', '~> 1.37'
  gem 'rubycritic', '~> 4.3'
  gem 'shoulda-matchers', '~> 4.1'
  gem 'simplecov', '~> 0.17.1'
end

group :development do
  gem 'brakeman', '~> 4.7'
  gem 'listen', '~> 3.2'
  gem 'spring', '~> 2.1'
  gem 'spring-watcher-listen', '~> 2.0'
end
