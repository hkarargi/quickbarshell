import Quickshell
import Quickshell.Services.UPower
import QtQuick

import "utils" as Utils

Utils.TextIconModule {
	function clicked() {
		useTimeTillEmpty = !useTimeTillEmpty
	}

	property var timeToEmpty: UPower.displayDevice.timeToEmpty
	property var timeTillEmpty: Qt.formatDateTime(timeToEmpty,"h") + " h " + Qt.formatDateTime(timeToEmpty, "m") + " min"

	property var useTimeTillEmpty: false

	height: 30
	color: "#00000000"
	
	altIcon: ""
	icons: ["","","","",""]
	
	useAlt: !UPower.onBattery
	number: Math.round(UPower.displayDevice.percentage*100)
	text: useTimeTillEmpty ? timeTillEmpty + " " + icon() : number + "% " + icon()

}
