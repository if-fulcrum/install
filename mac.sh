#!/bin/bash

# see if sudo is needed, get it first now so the focus is not lost to Docker.app
if ! $(sudo -n cat /dev/null > /dev/null 2>&1); then
  echo -e "You will need to provide your Mac password in order to setup Fulcrum Hinge."
  sudo cat /dev/null
fi

# install brew if needed
if ! $(which -s brew); then
  echo "Cannot find the brew command, installing homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install Docker if needed
if ! $(open -a Docker); then
  brew cask install docker
  open -a Docker
fi

# clone or update fulcrum
cd
if [ ! -d fulcrum ]; then
  git clone https://github.com/if-fulcrum/fulcrum.git
  cd fulcrum
else
  cd fulcrum
  git pull
fi

./bin/fulcrum up
