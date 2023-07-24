#!/usr/bin/sh

dir="$HOME/.config/polybar"

launch_bar() {
  killall polybar
  sleep 0.1
  polybar -q -r primary-top -c "$dir/config.ini" &
}

launch_bar
