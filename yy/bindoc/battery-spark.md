Go to `yy/bin`

## Install spark
```sh
curl -O https://raw.githubusercontent.com/holman/spark/master/spark
chmod u+x spark
```

## Install Goles/Battery
```sh
curl -O https://raw.githubusercontent.com/goles/battery/master/battery
chmod u+x battery
```

## tmux

- Be sure to make tmux display utf-8 characters by running it with the `-u` flag

  `tmux -u`

- Add the following line to your `~/.tmux.conf` file

  `set -g status-right "#(/usr/bin/battery -t)"`

- reload the tmux config by running `tmux source-file ~/.tmux.conf`.

###### 