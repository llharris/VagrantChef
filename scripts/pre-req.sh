#!/usr/bin/env bash

VAGRANT_USER="vagrant"
VAGRANT_PUB_KEY="https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub"

. /etc/os-release

case ${ID} in
ubuntu)
  echo "OS is Ubuntu, will use apt to update packages..."
  apt-get update && apt-get dist-upgrade -y
  ;;
centos)
  echo "OS is CentOS, will use yum to update packages..."
  yum update --exclude=kernel* && yum distribution-synchronization -y
  yum install -y wget
  ;;
*)
  ;;
esac

echo `wget $VAGRANT_PUB_KEY`
key=`echo $VAGRANT_PUB_KEY | sed 's_.*/__' `
cat $key >> /home/$VAGRANT_USER/.ssh/authorized_keys
rm $key
