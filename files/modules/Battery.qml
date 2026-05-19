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
	
	altIcon: ""
	icons: ["","","","",""]
	
	useAlt: !UPower.onBattery
	
	number: UPower.displayDevice.percentage*100
}
