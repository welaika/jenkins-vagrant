#!/bin/bash
VM=`cat .vagrant/machines/default/virtualbox/id`
VBoxManage snapshot $VM restore clean
vagrant up --no-provision
vagrant ssh <<RAW
git clone -b master git@code.welaika.com:gommoni.git
cd gommoni
bash .jenkins.build.sh
RAW
vagrant halt

