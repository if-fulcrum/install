#!/bin/bash

: '
# Run the following command to install:

echo "https://github.com/if-fulcrum/hinge-config.git" > /tmp/HINGECONFIGREPO &&
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT)"

# Note: you can use a custom config by changing the repo URL
# '

function main() {
  # get the prerequisites
  getPrerequisites

  # clone fulcrum if needed
  if [ ! -d ~/fulcrum ]; then
    git -C ~/ clone https://github.com/if-fulcrum/fulcrum.git
  fi

  # pull no matter what
  cd ~/fulcrum
  git pull

  # run doctor to get us into place
  ~/fulcrum/bin/doctor

  # bring up fulcrum
  ~/fulcrum/bin/fulcrum up
}

function getPrerequisites() {
  UNAMEA=$(uname -a)

  # macOS: need Brew, will include git via Xcode
  # `which git` bad since it could pop macOS Xcode Command Line Tools dialog box
  if [[ "$UNAMEA" == *"Darwin"* ]]; then
    if ! (which brew > /dev/null); then
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
  # Linux: need git
  elif [[ "$UNAMEA" == *"Linux"* ]]; then
    if [ -e /etc/os-release ]; then
      source /etc/os-release
      OS_DISTRO=$(echo $ID|tr '[:upper:]' '[:lower:]'|tr ' ' '-')

      if [[ "$OS_DISTRO" == "debian" || "$OS_DISTRO" == "ubuntu" ]]; then
        if ! (which git > /dev/null); then
          sudo apt install -y git
        fi
      else
        echo "ERROR: Linux distro $OS_DISTRO not supported"
        exit 1
      fi
    else
      echo "ERROR: Can not identify Linux distro"
      exit 1
    fi
  else
    echo "ERROR: OS $UNAMEA not supported"
    exit 1
  fi

  # make ssh key if needed
  if [ ! -d ~/.ssh ]; then
    ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
  fi
}

main
