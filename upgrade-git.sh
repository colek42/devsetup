#!/bin/sh

#this script upgrades git

sudo echo "Got Sudo!"
export GITSRC="${HOME}/git"
export PREFIX="/usr/local"

CURRVER=`git --version`

sudo yum groupinstall "Development Tools"
sudo yum install gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel



#Git is not already cloned
if [ ! -d "${GITSRC}/.git" ]; then
  echo "Cant Find Git Repo"
  sudo rm -rf $GITSRC
  cd $HOME
  git clone git://git.kernel.org/pub/scm/git/git.git $GITSRC
  cd $GITSRC
elif [ -d "${GITSRC}/.git" ]; then
  cd $GITSRC
  echo "Have Git"
else
  echo "This Should MNot Happen"
  exit
fi

git pull
make configure
./configure --prefix=$PREFIX
sudo make install

NEWVER=`git --version`

echo "Done GIT Upgraded from ${CURRVER} to ${NEWVER}"


