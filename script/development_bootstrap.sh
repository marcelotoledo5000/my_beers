#!/bin/bash

echo "Installing bundler"
gem install bundler

echo "Installing gems"
bundle install

echo "Creating databases"
bundle exec rails db:setup db:migrate db:reset
bundle exec rails db:test:prepare
