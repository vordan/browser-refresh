#!/bin/bash

#-----------------------------------------------
# Requirements:
#	apt install xdotool
#	apt install xterm
#	apt install xsel
#-----------------------------------------------
# xterm -iconic -e /home/vanco/disk.mk/bin/refresh-chrome.sh
#

titles="10.10 192.168 FSSC";		# Window titles to search for
browsers="Chrom chrom firefox";	# Browsers to refresh

for browser in $browsers; do
	focused_window_id=$(xdotool getwindowfocus)                             # remember current window
	pids=$(xdotool search --onlyvisible --class "$browser")
	
	for pid in $pids; do
		xdotool windowfocus $pid key "ctrl+l";
		xdotool windowfocus $pid key "ctrl+c";
		paste_buffer=`xsel --clipboard --output`;
	
		#name=$(xdotool getwindowname $pid)
	
		#echo "window: "$pid" "$name" "$paste_buffer;

		for title in $titles; do
			if [[ $paste_buffer == *"$title"* ]]; then
				xdotool windowfocus $pid key "F5"
			fi
		done
	done
	xdotool windowactivate --sync $focused_window_id                        # switch window, sync to "wait"
done

# Firefox
#echo reload | nc localhost 32002;
exit 0;
