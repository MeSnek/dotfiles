new_sink=$(pacmd list-sinks | grep index | tee /dev/stdout | grep -m1 -A1 "* index" | tail -1 | cut -c12-)
new_sink_name=$(pactl list sinks | grep -A10 "Sink #$new_sink" | grep Description | cut -c15-)

echo "Setting default sink to: $new_sink: $new_sink_name";
pacmd set-default-sink $new_sink
pacmd list-sink-inputs | grep index | while read line; do
  echo "Moving input $(echo $line | cut -f2 -d' ') to sink $new_sink"
  pacmd move-sink-input `echo $line | cut -f2 -d' '` $new_sink
done

notif_msg=''
sep=''
all_sinks=$(pactl list short sinks)
while read line; do
  sink_num=$(echo $line | cut -d ' ' -f 1)
  sink_name=$(pactl list sinks | grep -A10 "Sink #$sink_num" | grep Description | cut -c15-)
  if [[ "$(echo $line | cut -d ' ' -f 1)" == "$new_sink" ]]; then
    notif_msg="$notif_msg$sep<b>*$(echo $sink_name | tr a-z A-Z)</b>"
  else
    notif_msg="$notif_msg$sep  $sink_name"
  fi

  if [[ "$sep" == "" ]]; then
    sep='\n'
  fi
done <<< "$all_sinks"

notify-send --icon=audio-speakers --expire-time=3000 "Audio Output" "$notif_msg"
