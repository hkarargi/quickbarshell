import Quickshell
import Quickshell.Services.UPower
import QtQuick

import "templates"
import "utils" as Utils

Symbol {
	function clicked() {
		useTimeTillEmpty = !useTimeTillEmpty
	}

	property var timeToEmpty: UPower.displayDevice.timeToEmpty != 0 ? UPower.displayDevice.timeToEmpty : UPower.displayDevice.timeToFull

	property var useTimeTillEmpty: false

	color: "#00000000"
	
	altIcon: ""
	icons: ["","","","",""]
	
	useAlt: !UPower.onBattery
	number: Math.round(UPower.displayDevice.percentage*100)
	text: useTimeTillEmpty ? 
(prefix != "" ? prefix + " ":prefix) + Math.floor(timeToEmpty/3600) + "h " + Math.floor(timeToEmpty%3600/60) + "m " + (useVertical ? "\n" : "") + icon() + suffix
 : (prefix != "" ? prefix + " ":prefix) + number + "% " + (useVertical ? "\n" : "") + icon() + suffix

}
