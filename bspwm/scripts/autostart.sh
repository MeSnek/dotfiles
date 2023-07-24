
# Set keyboard loadout
xmodmap .config/.Xmodmap

# Bar
~/.config/polybar/launch.sh &
sleep 1
pkill polybar
/home/sneku/.config/polybar/launch.sh &

