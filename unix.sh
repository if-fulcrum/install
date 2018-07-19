#!/bin/bash

# export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
# (curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT) 2> /dev/null | bash

# get the prerequisites
getPrerequisites

# clone fulcrum if needed
if [ ! -d ~/fulcrum ]; then
  git -C ~/ clone https://github.com/if-fulcrum/fulcrum.git
fi

# pull no matter what
cd ~/fulcrum
git pull

# bring up fulcrum, doctor should get us into place
~/fulcrum/bin/fulcrum2 up
# ~/fulcrum/bin/doctor2

function getPrerequisites() {
  if ! (which git > /dev/null); then
    UNAMEA=$(uname -a)

    if [[ "$UNAMEA" == *"Darwin"* ]]; then
      if ! (which brew > /dev/null); then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      else

      brew install git
    elif [[ "$UNAMEA" == *"Linux"* ]]; then
      if [ -e /etc/os-release ]; then
        source /etc/os-release
        FULCRUM_OS_DISTRO=$(echo $ID|tr '[:upper:]' '[:lower:]'|tr ' ' '-')

        if [[ "$FULCRUM_OS_DISTRO" == "debian" || "$FULCRUM_OS_DISTRO" == "ubuntu" ]]; then
          sudo apt install -y git
        else
          echo "ERROR: Linux distro $FULCRUM_OS_DISTRO not supported"
          exit 1
        fi
      else
        echo "ERROR: Cann not identify Linux distro"
        exit 1
      fi
    else
      echo "ERROR: OS $UNAMEA not supported"
      exit 1
    fi
  fi
}