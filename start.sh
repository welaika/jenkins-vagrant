#!/bin/bash
vagrant up
vagrant halt
VM=`cat .vagrant/machines/default/virtualbox/id`
VBoxManage snapshot $VM take clean

