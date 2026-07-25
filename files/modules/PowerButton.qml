import Quickshell
import Quickshell.Io
import QtQuick

import "templates"

BarItem { 
	function clicked() { 
		lock.running = true
	}

	property var lockCommand: "hyprlock"
	property var buttonText: "⏻ "
	
	textAnchorHCenter: true
	textAnchorVCenter: true
	
	width: size
	height: size

	color: "#00000000"
	Process { command: [ lockCommand ]; id: lock }
	text: buttonText
}
