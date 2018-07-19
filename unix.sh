#!/bin/bash

# curl -fsSL https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh | bash

# for bootstrap we at least want
if (which git > /dev/null); then
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
else
  echo "[fulcrum/install] ERROR: You must have git installed to continue, please install and try again"
  exit 1
fi

