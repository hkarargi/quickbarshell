import Quickshell
import Quickshell.Io
import QtQuick

import "utils" as Utils

Utils.TextModule { 
	function clicked() { 
		lock.running = true
	}

	property var lockCommand: "hyprlock"
	property var buttonText: "⏻ "
	
	textAnchorHCenter: true
	textAnchorVCenter: true

	width: 30
	height: 30
	color: "#00000000"
	Process { command: [ lockCommand ]; id: lock }
	text: buttonText
}
