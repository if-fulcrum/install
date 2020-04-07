# Fulcrum installer

## Install Fulcrum Hinge on Mac or Ubuntu with example Hinge Config or manually entering
Run from terminal:
```bash
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT)"
```

## Install Fulcrum Hinge on Mac or Ubuntu giving the Hinge Config URL
```bash
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT) -c https://github.com/if-fulcrum/hinge-config.git"
```

## Install Fulcrum Hinge on Mac or Ubuntu giving the Hinge Config URL and branch
```bash
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT) -c https://github.com/if-fulcrum/hinge-config.git -r master"
```

## Install Fulcrum Hinge on Mac or Ubuntu giving the Hinge Config URL and branch and Fulcrum branch
```bash
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT) -b master -r master -c https://github.com/if-fulcrum/hinge-config.git"
```

### Previously there were issues with time not being synchronized on Mac, run this if needed:
```bash
sudo ntpdate -u time.apple.com || sudo sntp -sS time.apple.com
```

### At this time Windows is not supported for Fulcrum, when it is this will be the install
