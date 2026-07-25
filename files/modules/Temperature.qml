import Quickshell
import QtQuick

import "templates"
import "utils"

Symbol {

	number: CPUUtils.cpuTemp

	textAnchorHCenter: true
	textAnchorVCenter: true
	
	icons: ["", "", "", "", ""]
	
	text: number + "°C " + (useVertical ? "\n" : "") + icon()
}
