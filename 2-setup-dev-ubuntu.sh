#!/bin/sh

sudo apt-get update
sudo apt-get -y upgrade

echo "Installing zsh"
sudo apt-get -y install zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s /usr/bin/zsh

echo "Installing golang"
sudo add-apt-repository -y ppa:ubuntu-lxc/lxd-stable
sudo apt-get -y update
sudo apt-get -y install golang

echo "Installing latest Git"
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update
sudo apt-get -y install git

echo "Installing SCM Breeze"
git clone git://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
~/.scm_breeze/install.sh

echo "Installing VIM"
sudo apt-get -y install vim

echo "Installing Google Chrome"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get -y install google-chrome-stable

echo "Installing umake"
sudo add-apt-repository -y ppa:ubuntu-desktop/ubuntu-make
sudo apt-get update
sudo apt-get install -y ubuntu-make

echo "Installing VSCode"
umake ide visual-studio-code $HOME/.local/share/umake/ide/visual-studio-code --accept-license

echo "Installing Python"
sudo add-apt-repository -y ppa:fkrull/deadsnakes
sudo apt-get update
sudo apt-get -y install python2.7-dev python3.5-dev
sudo apt-get -y install build-essential libxml2-dev libxslt-dev

echo "Installing Oracle Java"
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update

echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get install -y oracle-java8-installer

mkdir -p $HOME/go/src/github.com

echo "SSH Key Generation/GitHub Setup"
ssh-keygen -t rsa -b 4096 -C "colek42@gmail.com" -f $HOME/.ssh/id_rsa -N ''
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

sudo apt-get -y install xclip
xclip -sel clip <  ~/.ssh/id_rsa.pub

echo "public key in clipboard add to github, close chrome when key is added"
google-chrome https://github.com/settings/keys


echo "Adding github Token, close chrome after token is copied to clipboard"
google-chrome https://github.com/settings/tokens/new

echo "Paste github Token"
read GITHUB_TOKEN
echo "You entered: $GITHUB_TOKEN"

git config --global url."https://${GITHUB_TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"
git config --global user.name "Cole Kennedy"
git config --global user.email colek42@gmail.com

echo "copy dot files"

echo "Done!"
