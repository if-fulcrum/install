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
echo /tmp/HINGECONFIGREPO > /tmo/HINGECONFIGREPO &&
export FSCRIPT=https://raw.githubusercontent.com/if-fulcrum/install/master/unix.sh &&
bash -c "$(curl -fsSL $FSCRIPT || wget -q -O - $FSCRIPT)"
```
