#!/bin/sh
#TODO Check if GOPATH and sencha paths already exist
#TODO Silent Sencha Cmd Install
#TODO Do git stuff first

##Vars for golang install
export GOVER=1.6.1
export OS=linux
export ARCH=amd64
export GITVER=2.8.1
export CMDVER=6.1.2
export GOPATH=$HOME/go
export NOVAHOME=$GOPATH/src/github.com/Novetta
export GIT_NAME="Cole Kennedy"
export GIT_EMAIL="nkennedy@novetta.com"

sudo yum -y install epel-release
sudo yum -y install epel-release.noarch
sudo yum -y update
sudo yum -y upgrade
sudo systemctl stop firewalld
sudo systemctl disable firewalld

sudo touch /etc/profile.d/env.sh
echo "source /home/cole/.env" | sudo tee -a /etc/profile.d/env.sh

echo "Installing zsh"
sudo yum -y install zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s /bin/zsh

echo "Installing golang"
cd $HOME/Downloads
wget "https://storage.googleapis.com/golang/go$GOVER.$OS-$ARCH.tar.gz"
sudo tar -C /usr/local -xzf go$GOVER.$OS-$ARCH.tar.gz
echo "export GOPATH=$GOPATH" | tee -a $HOME/.env
source $HOME/.env
cd $HOME

echo "Installing latest Git"
sudo yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel
sudo yum install -y gcc perl-ExtUtils-MakeMaker git

git clone git://git.kernel.org/pub/scm/git/git.git
cd git
make configure
./configure --prefix=/usr
make all
sudo make install
cd $HOME

echo "Installing SCM Breeze"
git clone git://github.com/ndbroadbent/scm_breeze.git $HOME/.scm_breeze
$HOME/.scm_breeze/install.sh

echo "Installing Google Chrome"
cd $HOME/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum install -y google-chrome-stable_current_x86_64.rpm
cd $HOME

echo "Installing VSCode"
cd $HOME/Downloads
wget https://az764295.vo.msecnd.net/stable/fa6d0f03813dfb9df4589c30121e9fcffa8a8ec8/vscode-x86_64.rpm
sudo yum install -y vscode-x86_64.rpm
cd $HOME

echo "Installing Cassandra"
sudo touch /etc/yum.repos.d/datastax.repo
echo "[datastax]" | sudo tee -a /etc/yum.repos.d/datastax.repo
echo "name = DataStax Repo for Apache Cassandra" | sudo tee -a /etc/yum.repos.d/datastax.repo
echo "baseurl = http://rpm.datastax.com/community" | sudo tee -a /etc/yum.repos.d/datastax.repo
echo "enabled = 1" | sudo tee -a /etc/yum.repos.d/datastax.repo
echo "gpgcheck = 0" | sudo tee -a /etc/yum.repos.d/datastax.repo
sudo yum install -y dsc22
sudo yum install -y cassandra22-tools ## Installs optional utilities.

mkdir -p $HOME/go/src/github.com

echo "SSH Key Generation/GitHub Setup"
ssh-keygen -t rsa -b 4096 -C "colek42@gmail.com" -f $HOME/.ssh/id_rsa -N ''
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_rsa

sudo yum install -y install xclip
xclip -sel clip <  $HOME/.ssh/id_rsa.pub

echo "public key in clipboard add to github, close chrome when key is added"
google-chrome https://github.com/settings/keys


echo "Adding github Token, close chrome after token is copied to clipboard"
google-chrome https://github.com/settings/tokens/new

echo "Paste github Token"
read GITHUB_TOKEN
echo "You entered: $GITHUB_TOKEN"

git config --global url."https://${GITHUB_TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"
git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL
git config --global init.templatedir '~/.git-templates'

echo "Install i3"
sudo touch /etc/yum.repos.d/admiralnemo-i3wm-el7-epel-7.repo
echo "[admiralnemo-i3wm-el7]" | sudo tee -a /etc/yum.repos.d/admiralnemo-i3wm-el7-epel-7.repo
echo "name=Copr repo for i3wm-el7 owned by admiralnemo" | sudo tee -a /etc/yum.repos.d/admiralnemo-i3wm-el7-epel-7.repo
echo "baseurl=https://copr-be.cloud.fedoraproject.org/results/admiralnemo/i3wm-el7/epel-7-x86_64/" | sudo tee -a /etc/yum.repos.d/admiralnemo-i3wm-el7-epel-7.repo
echo "skip_if_unavailable=True" | sudo tee -a /etc/yum.repos.d/admiralnemo-i3wm-el7-epel-7.repo
echo "gpgcheck=1" | sudo tee -a /etc/yum.repos.d/admiralnemo-i3wm-el7-epel-7.repo
echo "gpgkey=https://copr-be.cloud.fedoraproject.org/results/admiralnemo/i3wm-el7/pubkey.gpg" | sudo tee -a /etc/yum.repos.d/admiralnemo-i3wm-el7-epel-7.repo
echo "enabled=1" | sudo tee -a /etc/yum.repos.d/admiralnemo-i3wm-el7-epel-7.repo
echo "enabled_metadata=1" | sudo tee -a /etc/yum.repos.d/admiralnemo-i3wm-el7-epel-7.repo

sudo yum update
sudo yum install -y dejavu-sans-fonts dejavu-sans-mono-fonts dejavu-serif-fonts i3 i3status lilyterm

#Novetta Files
sudo yum install -y autoconf automake cmake freetype-devel gcc gcc-c++ git libtool make mercurial nasm pkgconfig zlib-devel yasm nasm
curl --silent --location https://rpm.nodesource.com/setup_5.x | sudo bash -
sudo yum -y install nodejs

mkdir -p $NOVAHOME
cd $NOVAHOME
git clone git@github.com:Novetta/VideoEnterprise --recursive
git clone git@github.com:Novetta/pwcop --recursive
git clone git@github.com:Novetta/fbncjs --recursive
git clone git@github.com:Novetta/common --recursive
git clone git@github.com:Novetta/namegen --recursive
git clone git@github.com:Novetta/SSE --recursive
git clone git@github.com:Novetta/Geoserver --recursive
git clone git@github.com:Novetta/KLE --recursive
git clone git@github.com:Novetta/ITK --recursive
git clone git@github.com:Novetta/cesium-drawhelper --recursive
git clone git@github.com:Novetta/ExecutiveDashboard --recursive
git clone git@github.com:Novetta/tirs --recursive
git clone git@github.com:Novetta/goldap --recursive
git clone git@github.com:Novetta/GoSearchService --recursive
git clone git@github.com:Novetta/gmf --recursive
git clone git@github.com:Novetta/WebChimeraPlayer --recursive
git clone git@github.com:Novetta/perseus --recursive
git clone git@github.com:Novetta/aide --recursive
git clone git@github.com:Novetta/gokerb --recursive
git clone git@github.com:Novetta/gocql --recursive
git clone git@github.com:Novetta/asn1 --recursive
git clone git@github.com:Colek42/ext --recursive

go get -u -v github.com/nsf/gocode
go get -u -v github.com/rogpeppe/godef
go get -u -v github.com/golang/lint/golint
go get -u -v github.com/lukehoban/go-outline
go get -u -v sourcegraph.com/sqs/goreturns
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v github.com/tpng/gopkgs
go get -u -v github.com/newhook/go-symbols
go get -u -v golang.org/x/tools/cmd/guru

sudo npm install -g jshint
sudo npm install -g eslint
sudo npm install -g js-beautify

cd $HOME

##Copy Lucene from common
sudo cp $NOVAHOME/common/lucene/cassandra-lucene-index-plugin* /usr/share/cassandra/lib/
sudo chown cassandra:cassandra /usr/share/cassandra/lib/cassandra-lucene-index-plugin*
sudo systemctl enable cassandra

echo "Installing Sencha"
cd $HOME/Downloads
wget http://cdn.sencha.com/cmd/6.1.2/no-jre/SenchaCmd-$CMDVER-linux-amd64.sh.zip
unzip SenchaCmd-$CMDVER-linux-amd64.sh.zip
chmod +x SenchaCmd-$CMDVER*
./SenchaCmd-$CMDVER*
echo "export PATH=$PATH:/home/cole/bin/Sencha/Cmd" | tee -a $HOME/.env
source $HOME/.env
cd $HOME

sudo yum install -y ack tmux

echo "Done!  Please Restart!"
