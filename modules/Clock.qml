import Quickshell
import QtQuick
import Quickshell.Io

Rectangle { 
	width: 175
	height: 30
	color: "#00000000"
	SystemClock { id: clock; precision: SystemClock.Seconds }
	Rectangle { id: clockRect; color: "#a0c7c4bf"; radius: 25; width: 175; height: 30 }
	Text { text: Qt.formatDateTime(clock.date, "hh:mm:ss AP - dd/MM/yyyy"); anchors.centerIn: clockRect; font.pointSize: 10 }
}
