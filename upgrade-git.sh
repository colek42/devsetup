#!/bin/sh

#this script upgrades git
export GITSRC=$HOME/git
sudo echo "Got Sudo!"
cd $GITSRC

git pull
make configure
./configure --prefix=/usr
make all
sudo make install
