import Quickshell
import Quickshell.Io
import QtQuick

import "templates"
import "utils"

Symbol {
	function wheel(angleDelta) {
		BacklightUtils.changeBrightnessByPercent(Math.sign(angleDelta.y))
	}

	
	icons: ["", "", "", "", "", "", "", "", ""]

	number: BacklightUtils.brightness
}
