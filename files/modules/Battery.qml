import Quickshell
import Quickshell.Services.UPower
import QtQuick

import "templates"
import "utils" as Utils

Symbol {
	function clicked() {
		useTimeTillEmpty = !useTimeTillEmpty
	}

	property var timeToEmpty: UPower.displayDevice.timeToEmpty

	property var useTimeTillEmpty: false

	color: "#00000000"
	
	altIcon: ""
	icons: ["","","","",""]
	
	useAlt: !UPower.onBattery
	number: Math.round(UPower.displayDevice.percentage*100)
	text: useTimeTillEmpty ? timeToEmpty + " " + icon() : number + "% " + icon() + suffix + " "

}
