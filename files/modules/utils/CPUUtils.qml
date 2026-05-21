import QtQuick
import Quickshell
import Quickshell.Io

Item {
	id: cpuUtils
	property var memUsagePercent: 0
	property var cpuUsagePercent: 0
	property var cpuTemp: 0

	Process {
		id: memProc
		command: ["sh", "-c", "free | grep Mem | awk '{print \$3/\$2 * 100.0}'" ]
		running: true
		stdout: SplitParser {
			onRead: data => { memUsagePercent = Math.round(data) }
		}
	}

	Process {
		id: cpuProc
		command: ["sh", "-c", "echo $[100-$(vmstat 1 2|tail -1|awk '{print $15}')]" ]
		running: true
		stdout: SplitParser {
			onRead: data => { cpuUsagePercent = Math.round(data) }
		}
	}
	

	Process {
		id: tempProc
		command: ["sh", "-c", "echo $[$(cat /sys/class/hwmon/hwmon1/temp1_input)/1000]" ]
		running: true
		stdout: SplitParser {
			onRead: data => { cpuTemp = Math.round(data) }
		}
	}

	Timer {
		interval: 2000
		repeat: true
		running: true
		onTriggered: { 
			memProc.running = true
			cpuProc.running = true
			tempProc.running = true
		}
	}
}
