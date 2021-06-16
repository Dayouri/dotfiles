# Linux tips n tricks

## System Optimization:

### Change swapinnes to 10:
Create `/etc/sysctl.d/99-swappiness.conf` and add
```bash
vm.swappiness = 10
```

### Change swapinnes to 10:
Create `/etc/sysctl.d/99-vfs_cache_pressure.conf`  and add
```bash
vm.vfs_cache_pressure = 50
```

## Touchpad

Assuming `xf86-input-synaptics` is already installed, copy `/usr/share/X11/xorg.conf.d/70-synaptics.conf` to `/etc/X11/xorg.conf.d/` and edit it.

The following example file configures some common options, including vertical, horizontal and circular scrolling as well as tap-to-click:

```bash
Section "InputClass"
    Identifier "touchpad"
    Driver "synaptics"
    MatchIsTouchpad "on"
        Option "TapButton1" "1"
        Option "TapButton2" "3"
        Option "TapButton3" "2"
        Option "VertEdgeScroll" "on"
        Option "VertTwoFingerScroll" "on"
        Option "HorizEdgeScroll" "on"
        Option "HorizTwoFingerScroll" "on"
        Option "CircularScrolling" "on"
        Option "CircScrollTrigger" "2"
        Option "EmulateTwoFingerMinZ" "40"
        Option "EmulateTwoFingerMinW" "8"
        Option "CoastingSpeed" "0"
        Option "FingerLow" "30"
        Option "FingerHigh" "50"
        Option "MaxTapTime" "125"
        ...
EndSection
```

> Note: If a section as the identifier `Identifier "touchpad catchall"`, modify this one.

More info on https://wiki.archlinux.org/title/Touchpad_Synaptics#Configuration.

## Auto HDMI

Install `autorandr` (https://github.com/phillipberndt/autorandr for doc or install), then:

Save your current display configuration and setup with:

```bash
autorandr --save mobile
```

Connect an additional display, configure your setup and save it:

```bash
autorandr --save docked
```

Now autorandr can detect which hardware setup is active:

```bash
$ autorandr
  mobile
  docked (detected)
```

## Change Grub config (like timeout for example)

Edit `/etc/default/grub` then run:

```bash
sudo update-grub
```

## System info:

### Check if hardware acceleration is enabled:

```bash
   glxinfo | grep 'direct rendering'
```

### Display linux kernel

```bash
   uname -r
```

## Swap Caps Lock and Escape keys

Add `Option "XkbOptions" "caps:swapescape"` to  `/etc/X11/xorg.conf.d/00-keyboard.conf` in the `"InputClass"` section :

```bash
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "fr"
        Option "XkbModel" "pc105"
        Option "XkbVariant" "azerty"
        Option "XkbOptions" "caps:swapescape"
EndSection
```

Although the recommended way is to use the `localectl` command:

```bash
localectl --no-convert set-x11-keymap fr pc104 azerty caps:swapescape
```

Just check  `/etc/X11/xorg.conf.d/00-keyboard.conf` beforehand to be sure not to change the model.







