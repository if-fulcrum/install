# Fulcrum installer

## Install Fulcrum Hinge on Mac or Ubuntu with example Hinge Config or manually entering
Run from terminal:
```bash
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT)"
```

## Install Fulcrum Hinge on Mac or Ubuntu with specific Hinge Config, replacing repo hinge config URL
```bash
echo "https://github.com/if-fulcrum/hinge-config.git" > /tmp/HINGECONFIGREPO &&
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT)"
```

### Previously there were issues with time not being synchronized on Mac, run this if needed:
```bash
sudo ntpdate -u time.apple.com || sudo sntp -sS time.apple.com
```

### At this time Windows is not supported for Fulcrum, when it is this will be the install
