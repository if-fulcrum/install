# Fulcrum installer

## Options
```
* -c <HINGE_CONFIG_REPO_URL>   Specify Hinge Config repo     default: https://github.com/if-fulcrum/hinge-config.git
* -r <HINGE_CONFIG_BRANCH>     Speficy Hinge Config branch   default: master
* -b <FULCRUM_BRANCH>          Specify Fulcrum branch        default: master
```

## Install Fulcrum Hinge on Mac or Ubuntu
### With example config
Run from terminal:
```bash
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT)"
```

### With specific Hinge Config repo URL
```bash
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT) -c https://github.com/if-fulcrum/hinge-config.git"
```

### With specific Hinge Config repo URL and branch
```bash
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT) -c https://github.com/if-fulcrum/hinge-config.git -r master"
```

### With specific Fulcrum branch
```bash
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT) -b master"
```

## Misc Notes
### Previously there were issues with time not being synchronized on Mac, run this if needed:
```bash
sudo ntpdate -u time.apple.com || sudo sntp -sS time.apple.com
```

### At this time Windows is not supported for Fulcrum
