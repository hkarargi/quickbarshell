import Quickshell
import Quickshell.Io
import QtQuick

import "utils" as Utils

Utils.Base { 
	function clicked() { 
		lock.running = true
	}

	property var lockCommand: "hyprlock"
	property var buttonText: "⏻ "

	width: 30
	height: 30
	color: "#00000000"
	Process { command: [ lockCommand ]; id: lock }
	Text { text: buttonText; anchors.centerIn: parent; font.pointSize: 10 }
}
