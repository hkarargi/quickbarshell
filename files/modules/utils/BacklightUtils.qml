import QtQuick
import Quickshell
import Quickshell.Io

Item {
	property var brightness
	
	Timer {
		interval: 1
		running: true
		repeat: true
		onTriggered: {brightnessProc.running = true}
	}

	Process { id: process; stdout: SplitParser { onRead: data => {return data}} }

	Process { 
		id: brightnessProc
		command: ["sh", "-c", "echo $[100*$(brightnessctl get)/$(brightnessctl max)]"]
		stdout: SplitParser { 
			onRead: data => {
				brightness = data
				return data
			}
		}
		running: true
	}

	function changeBrightnessByPercent(amount) {
		var change = Math.abs(amount) + "%" + (Math.sign(amount) == "-1" ? "-": "+")

		process.exec({ command: ["sh","-c","brightnessctl set " + change ]})
	}
}
