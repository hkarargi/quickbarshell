import Quickshell
import QtQuick
import Quickshell.Io

import "templates"

Symbol { 
	textAnchorHCenter: true
	textAnchorVCenter: true

	property var useAPFormat: true
	
	property var initialFormat: useVertical ? "hh\nmm\n" + (useAPFormat ? "AP\n" : "") : "hh:mm" + (useAPFormat ? " AP" : "")
	property var altFormat: useVertical ? "dd\nMM\nyy\n" : "dd-MM-yy"
	property var initialIcon: ""
	property var altIcon: "󰸗"

	property var format: initialFormat
	property var icon: initialIcon
	
	function clicked() {
		console.log(initialFormat)
		if (format == initialFormat) {
			format = altFormat
			icon = altIcon
		}
		else {
			format = initialFormat
			icon = initialIcon
		}
	}

	SystemClock { id: clock; precision: SystemClock.Seconds }
	text: Qt.formatDateTime(clock.date, format) + " " + icon + "  "
}
