#!/bin/bash

: '
# Run this to install:

export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT) -b master -r master -c https://github.com/if-fulcrum/hinge-config.git"

# See help for options
# '

# general help, mainly for DevOps folks
function help() {
  echo "USAGE: $0"
  echo "-h                         Show this help"
  echo "-b <FULCRUM_BRANCH>        Specify Fulcrum branch"
  echo "-c <HINGE_CONFIG_REPO_URL> Specify Hinge Config repo"
  echo "-r <HINGE_CONFIG_BRANCH>   Speficy Hinge Config branch"
}

# abstracted out function to grab parameters
function getOptions() {
  while [ -n "$1" ]; do
    case "$1" in
      -h) help; exit ;;
      -b) FULCRUM_BRANCH="$2"; shift ;;
      -c) HINGE_CONFIG_REPO_URL="$2"; shift ;;
      -r) HINGE_CONFIG_BRANCH="$2"; shift ;;
      *) echo "Option $1 not recognized"; exit 1 ;;
    esac
    shift
  done
}

function main() {
  # default to master and open hinge config
  FULCRUM_BRANCH=master
  HINGE_CONFIG_REPO_URL=https://github.com/if-fulcrum/hinge-config.git
  HINGE_CONFIG_BRANCH=master
  getOptions $@

  echo "Starting install of Fulcrum Hinge"
  echo "* Fulcrum branch:      $FULCRUM_BRANCH"
  echo "* Hinge Config:        $HINGE_CONFIG_REPO_URL"
  echo "* Hinge Config branch: $HINGE_CONFIG_BRANCH"
  echo ""

  # save repo/branch to be picked up by main script
  echo $HINGE_CONFIG_REPO_URL > /tmp/HINGECONFIGREPO
  echo $HINGE_CONFIG_BRANCH   > /tmp/HINGECONFIGBRANCH

  # get the prerequisites
  getPrerequisites

  # clone fulcrum if needed
  if [ ! -d $HOME/fulcrum ]; then
    git -C $HOME/ clone -b $FULCRUM_BRANCH https://github.com/if-fulcrum/fulcrum.git
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

  # TODO: if we have the install source then we could add to the PATH

  echo
  echo "To add Fulcrum commands to your path, depending on your shell and setup, run one of the following:"
  echo ""
  echo "Ash/Bash:"
  echo 'echo "export PATH=$HOME/fulcrum/bin:$PATH" >>~/.profile'
  echo 'echo "export PATH=$HOME/fulcrum/bin:$PATH" >>~/.bash_profile'
  echo 'echo "export PATH=$HOME/fulcrum/bin:$PATH" >>~/.bashrc'
  echo ""
  echo "Zsh:"
  echo 'echo "export PATH=$HOME/fulcrum/bin:$PATH" >>~/.zshrc'
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
