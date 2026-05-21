import Quickshell
import Quickshell.Io
import QtQuick

import "utils" as Utils

Utils.TextIconModule {
	function wheel(angleDelta) {
		backlightUtils.changeBrightnessByPercent(Math.sign(angleDelta.y))
	}

	Utils.BacklightUtils { id: backlightUtils}
	
	icons: ["", "", "", "", "", "", "", "", ""]

	number: backlightUtils.brightness
}
