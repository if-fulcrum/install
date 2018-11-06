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
  if [ ! -d $HOME/fulcrum ]; then
    git -C $HOME/ clone https://github.com/if-fulcrum/fulcrum.git
  fi

  # pull no matter what
  cd $HOME/fulcrum
  git pull

  # run doctor to get us into place
  $HOME/fulcrum/bin/doctor

  # bring up fulcrum
  $HOME/fulcrum/bin/fulcrum up

  # put fulcrum on the path for this session, suggest for permanent
  echo "Fulcrum Hinge has been installed"
  echo "Temporarily adding $HOME/fulcrum/bin to \$PATH for this terminal session"
  export PATH=$HOME/fulcrum/bin:$PATH
  echo 
  echo "To make this permanent, depending on your shell and setup, run one of the following:"
  echo ""
  echo "Ash/Bash:"
  echo "export PATH=\$HOME/fulcrum/bin:\$PATH >>~/.profile"
  echo "export PATH=\$HOME/fulcrum/bin:\$PATH >>~/.bash_profile"
  echo "export PATH=\$HOME/fulcrum/bin:\$PATH >>~/.bashrc"
  echo ""
  echo "Zsh:"
  echo "export PATH=\$HOME/fulcrum/bin:\$PATH >>~/.zshrc"
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
  if [ ! -d $HOME/.ssh ]; then
    ssh-keygen -t rsa -P "" -f $HOME/.ssh/id_rsa
  fi
}

main
