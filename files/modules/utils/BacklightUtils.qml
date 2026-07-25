pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	property int brightness: 0
	
	Process { 
		id: brightnessProc
		command: ["sh", "-c", "
			bpath=$(ls /sys/class/backlight/*/brightness | head -1)
			max=$(cat ${bpath%/*}/max_brightness)
			echo $(cat $bpath) $max
			udevadm monitor --subsystem-match=backlight -u 2>/dev/null | while read line; do
    				echo $(cat $bpath) $max
			done
			"]
		stdout: SplitParser { 
			onRead: data => { var parts = data.split(" ");brightness = Math.round(parseInt(parts[0]) / parseInt(parts[1]) * 100)}
		}
		running: true
	}

	function changeBrightnessByPercent(amount) {

		Quickshell.execDetached(["sh","-c","brightnessctl set " + Math.min(Math.max(Math.round(brightness+amount),0),100) + "%" ])
	}
}
