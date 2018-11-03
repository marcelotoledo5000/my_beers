#!/bin/bash

echo "Installing bundler"
gem install bundler

echo "Installing gems"
bundle install

echo "Creating databases"
bundle exec rails db:reset db:setup db:migrate
bundle exec rails db:test:prepare
