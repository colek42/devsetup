export GOVER=1.7
export OS=linux
export ARCH=amd64


echo "Installing golang"
cd $HOME/Downloads
wget "https://storage.googleapis.com/golang/go$GOVER.$OS-$ARCH.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go$GOVER.$OS-$ARCH.tar.gz
cd $HOME
