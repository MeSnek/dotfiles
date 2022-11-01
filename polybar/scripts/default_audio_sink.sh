sink=$(pacmd list-sinks | grep index | tee /dev/stdout | grep -m1 -A1 "* index" | tail -1 | cut -c12-)

if [ $sink = 0 ]; then echo "Speakers"; elif [ $sink = 1 ]; then echo "Headphones"; fi
