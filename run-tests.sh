#!/bin/bash
vagrant up --no-provision
vagrant ssh <<RAW
git clone -b padrino git://github.com/downthemall/website.git
cd website
rbenv shell 2.0.0-p0
bundle install
sudo -u postgres createdb downthemall_test
cp .travis_db_credentials.rb config/db_credentials.rb
PADRINO_ENV=test bundle exec padrino rake ar:migrate
bundle exec rake spec
RAW
vagrant halt
VM=`cat .vagrant/machines/default/virtualbox/id`
VBoxManage snapshot $VM restore clean

