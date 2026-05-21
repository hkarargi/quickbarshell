import Quickshell
import QtQuick

import "utils" as Utils

Utils.TextIconModule {
	Utils.CPUUtils { id: cpuUtils }

	number: cpuUtils.cpuTemp

	textAnchorHCenter: true
	textAnchorVCenter: true
	
	icons: ["", "", "", "", ""]
	
	text: number + "°C " + icon()
}
