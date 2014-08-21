#!/bin/bash

# enable rvm
source /etc/profile.d/rvm.sh

# install and switch ruby
#rvm install 2.0
#rvm use 2.0

# clone code
mkdir /app
cp -R /code/* /app/
cd /app

# remove duplication RAILS_ENV=test in other command
export RAILS_ENV=test

bundle install --without production development --path=/bundle
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rspec
