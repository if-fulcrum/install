# Fulcrum Hinge tips

## Make sure time is syncronized:
```bash
sudo ntpdate -u time.apple.com
```

## Install:
```bash
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT)"
```

## Install w specific hinge config provided on command line:
```bash
export HINGESOURCE=https://raw.githubusercontent.com/Homebrew/install/master/install &&
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT)"
```
