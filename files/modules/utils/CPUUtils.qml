pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: cpuUtils
	property int memUsagePercent: 0
	property int cpuUsagePercent: 0
	property int cpuTemp: 0

	Process {
		command: ["sh", "-c", "
			while :; do
				# Mem
				eval \$(awk '/^MemTotal:/{t=\$2} /^MemAvailable:/{a=\$2} END{print \"mem=\" int((t-a)/t*100)}' /proc/meminfo)

				# CPU
				eval \$(awk '/^cpu /{print \"t1=\" \$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11; print \"i1=\" \$5}' /proc/stat)
				sleep 1
				eval \$(awk '/^cpu /{print \"t2=\" \$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11; print \"i2=\" \$5}' /proc/stat)

				[ \$t2 -eq \$t1 ] && cpu=0 || cpu=\$(( (t2 - t1 - i2 + i1) * 100 / (t2 - t1) ))
				
				# Temp
				temp=\$(cat \$(ls /sys/class/hwmon/hwmon*/temp1_input 2>/dev/null | head -1) 2>/dev/null)
				temp=\$((temp / 1000))

				echo \"\$mem \$cpu \$temp\"
			done
		"]
		running: true
		stdout: SplitParser {
			onRead: data => { 
				var parts = data.trim().split(" ")
				if (parts.length >= 3) {
					memUsagePercent = parseInt(parts[0])
					cpuUsagePercent = parseInt(parts[1])
					cpuTemp = parseInt(parts[2])
				}
			}
		}
	}
}
