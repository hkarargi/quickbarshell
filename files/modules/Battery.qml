import Quickshell
import Quickshell.Services.UPower
import QtQuick

import "utils" as Utils

Utils.TextIconModule {
	textAnchorHCenter: true
	textAnchorVCenter: true

	width: 75
	height: 30
	color: "#00000000"

	icons: ["","","","",""]

	number: UPower.displayDevice.percentage*100
}
