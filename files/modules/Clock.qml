import Quickshell
import QtQuick
import Quickshell.Io

import "utils" as Utils

Utils.TextModule { 
	property var format: "hh:mm:ss AP"
	property var icon: ""

	width: 100
	height: 30

	SystemClock { id: clock; precision: SystemClock.Seconds }
	text: Qt.formatDateTime(clock.date, format) + " " + icon
}
