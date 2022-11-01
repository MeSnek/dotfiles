ACTIVE_DEVICE=$(pacmd list-sinks | grep "active port: <analog" | sed -e 's/^[ \t]*//')
if [ "$ACTIVE_DEVICE" = "active port: <analog-output-lineout>" ]
then
	pacmd set-sink-port 1 analog-output-headphones
else
	pacmd set-sink-port 1 analog-output-lineout
fi
