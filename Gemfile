source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'bcrypt', '~> 3.1', '>= 3.1.12'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'cancancan', '~> 2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'

group :development, :test do
  gem 'database_cleaner', '~> 1.7'
  gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
  gem 'faker', '~> 1.9', '>= 1.9.1'
  gem 'pry-byebug', '~> 3.6'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.8', '>= 3.8.1'
  gem 'rubocop'
  gem 'rubycritic', require: false
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'simplecov', '~> 0.16.1'
end

group :development do
  gem 'brakeman', '~> 4.3', '>= 4.3.1'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring', '~> 2.0', '>= 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0', '>= 2.0.1'
end
