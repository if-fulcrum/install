#!/bin/bash

# usage: wget -q -O - https://raw.githubusercontent.com/if-fulcrum/install/master/ubuntu.sh | bash

# checkout sites repo
HINGESITESURLDEFAULT=https://github.com/if-fulcrum/hinge-sites.git

read -p "Fulcrum Hinge sites repo URL (default: $HINGESITESURLDEFAULT): " HINGESITESURL

if [ "$HINGESITESURL" = "" ]; then
  HINGESITESURL=$HINGESITESURLDEFAULT
fi

# install docker if needed
if (which docker > /dev/null); then
  echo "docker exists"
else
  echo "installing docker"
  wget -q -O - https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt update
  sudo apt install -y docker-ce
fi

# install docker-compose if needed
if (which docker-compose > /dev/null); then
  echo "docker-compose exists"
else
  echo "installing docker-compose"
  sudo wget -q -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m`
  sudo chmod +x /usr/local/bin/docker-compose
fi

# install aws cli if needed/wanted
if (which aws > /dev/null); then
  echo "aws exists"
else
  echo "installing aws"
  sudo apt install -y awscli
  aws configure
fi

# install certutil if needed
if (which certutil > /dev/null); then
  echo "certutil exists"
else
  echo "installing certutil"
  sudo apt install -y libnss3-tools
fi

# checkout fulcrum repo TODO: merge
git clone https://github.com/if-fulcrum/fulcrum.git ~/fulcrum
echo "!!! CHECKING OUT BRANCH hinge-ubuntu THIS NEEDS TO CHANGE ONCE MERGED !!!" && cd ~/fulcrum && git checkout hinge-ubuntu

git clone $HINGESITESURL ~/fulcrum/etc/fulcrum/sites

# bring up fulcrum
~/fulcrum/bin/fulcrum up
