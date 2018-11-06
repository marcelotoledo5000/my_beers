source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'cancancan', '~> 2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'

group :development, :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
  gem 'faker', '~> 1.9', '>= 1.9.1'
  gem 'pry-byebug', '~> 3.6'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.8', '>= 3.8.1'
  gem 'rubocop'
  gem 'rubycritic', require: false
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'simplecov'
end

group :development do
  gem 'brakeman'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
