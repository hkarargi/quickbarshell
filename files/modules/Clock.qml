import Quickshell
import QtQuick
import Quickshell.Io

import "utils" as Utils

Utils.TextModule { 
	textAnchorHCenter: true
	textAnchorVCenter: true

	property var initialFormat: "hh:mm"
	property var altFormat: "yyyy-MM-dd"
	property var initialIcon: ""
	property var altIcon: "󰸗"

	property var format: initialFormat
	property var icon: initialIcon
	
	function clicked() {
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
	text: Qt.formatDateTime(clock.date, format) + " " + icon
}
