#!/bin/sh
#TODO Check if GOPATH and sencha paths already exist
#TODO Silent Sencha Cmd Install
#TODO Do git stuff first

export GOVER=1.6.1
export OS=linux
export ARCH=amd64
export GITVER=2.8.1
export CMDVER=6.1.2
export GOPATH=$HOME/go
export NOVAHOME=$GOPATH/src/github.com/Novetta
export GIT_NAME="Cole Kennedy"
export GIT_EMAIL="nkennedy@novetta.com"

NOVA_REPOS="VideoEnterprise
pwcop
namegen
SSE
KLE
goldap
GoSearchService
gmf
perseus
aide
gokerb
gocql
kerbproxy
asn1"
# fbncjs
# Geoserver
# ITK
# cesium-drawhelper
# ExecutiveDashboard
# tirs
# WebChimeraPlayer

GOLANG_REPOS="github.com/nsf/gocode
github.com/rogpeppe/godef
github.com/golang/lint/golint
github.com/lukehoban/go-outline
sourcegraph.com/sqs/goreturns
golang.org/x/tools/cmd/gorename
github.com/tpng/gopkgs
github.com/newhook/go-symbols
golang.org/x/tools/cmd/guru
golang.org/x/net/ipv4
golang.org/x/net/internal/iana
golang.org/x/net
golang.org/x/net/websocket
golang.org/x/crypto/md4
github.com/fatih/set
github.com/go-martini/martini
github.com/codegangsta/inject
github.com/martini-contrib/encoder
github.com/martini-contrib/gzip
github.com/gocql/gocql
github.com/golang/snappy
github.com/hailocab/go-hostpool
golang.org/x/net/context
github.com/codegangsta/inject
github.com/go-martini/martini
github.com/martini-contrib/encoder
github.com/martini-contrib/gzip
github.com/gocql/gocql/internal/lru
github.com/gocql/gocql/internal/murmur
github.com/gocql/gocql/internal/streams
github.com/golang/snappy
github.com/hailocab/go-hostpool
golang.org/x/net/context
gopkg.in/inf.v0
github.com/gocql/gocql
gopkg.in/yaml.v2
github.com/Novetta/common/aide/websocket
github.com/the42/cartconvert/cartconvert
github.com/Novetta/common/mgrs
github.com/TomiHiltunen/geohash-golang
golang.org/x/image/bmp
golang.org/x/image/tiff/lzw
golang.org/x/image/tiff
github.com/disintegration/imaging
github.com/grafov/m3u8
github.com/nfnt/resize
github.com/oliamb/cutter
"

NPM_REPOS="jshint
eslint
js-beautify"

RPMS="
zsh
curl-devel
expat-devel
gettext-devel
openssl-devel
zlib-devel
gcc
perl-ExtUtils-MakeMaker
git
xclip
ack
tmux
zeromq
zeromq-devel
autoconf
automake
cmake
freetype-devel
gcc-c++
git
libtool
make
mercurial
nasm
yasm
pkgconfig
zlib-devel
"

#########################################################################
#########################################################################

sudo yum -y install epel-release
sudo yum -y install epel-release.noarch
sudo yum -y update
sudo yum -y upgrade

for rpm in $RPMS
do
    echo "Installing package $rpm"
    sudo yum install -y $rpm

done
echo "done!"
cd ~

echo "Installing zsh"
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s /bin/zsh

echo "Installing golang"
cd $HOME/Downloads
wget "https://storage.googleapis.com/golang/go$GOVER.$OS-$ARCH.tar.gz"
sudo tar -C /usr/local -xzf go$GOVER.$OS-$ARCH.tar.gz
echo "export GOPATH=$GOPATH" | tee -a $HOME/.env
source $HOME/.env
cd $HOME

echo "Installing Git ver $GITVER"
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

#--Nova Repos--#

mkdir -p $NOVAHOME
for repo in $NOVA_REPOS
do
    echo "Installing repo $repo"
    cd $NOVAHOME
    git clone --verbose git@github.com:Novetta/$repo
    cd $NOVAHOME/${repo}
    git fetch
    git pull
    git submodule update --init --recursive
done
echo "done!"
cd ~    

#--Go Repos--#
for gorepo in $GOLANG_REPOS
do
    echo "Installing repo $gorepo"
    go get -u -v $gorepo
done
echo "done!"
cd ~

#-----Get master of faith/set-----##
# Go get grabs out of date version #
cd $GOPATH/src/github.com/fatih
git checkout master
git fetch
git pull
#---------------------------------##

for npmrepo in $NPM_REPOS
do
    echo "Installing NPM module $npmrepo"
    sudo npm install -g $npmrepo
done
echo "done"

#--Lucene--#
echo "Copy Lucene from common"
sudo cp $NOVAHOME/common/lucene/cassandra-lucene-index-plugin* /usr/share/cassandra/lib/
sudo chown cassandra:cassandra /usr/share/cassandra/lib/cassandra-lucene-index-plugin*
sudo systemctl enable cassandra

#---Sencha---#
echo "Login and Download Chrome UNTIL DOWNLOAD IS COMPLETED!!!!"
google-chrome https://support.sencha.com/#download
cd $HOME/Downloads
unzip ext*.zip
extdir=`ls -d */ | grep ext`
echo "Copying Files to $NOVAHOME/ext......."
cp -p -r $HOME/Downloads/$extdir $NOVAHOME/ext

echo "Installing Sencha CMD"
cd $HOME/Downloads
wget http://cdn.sencha.com/cmd/6.1.2/no-jre/SenchaCmd-$CMDVER-linux-amd64.sh.zip
unzip SenchaCmd-$CMDVER-linux-amd64.sh.zip
chmod +x SenchaCmd-$CMDVER*
./SenchaCmd-$CMDVER*
echo "export PATH=$PATH:/home/cole/bin/Sencha/Cmd" | tee -a $HOME/.env
source $HOME/.env
cd $HOME

echo "Done!  Please Restart! and setup your individual packages repos.  Do not forget to create the ext symlink"
