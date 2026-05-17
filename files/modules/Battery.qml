import Quickshell
import Quickshell.Services.UPower
import QtQuick

Rectangle {
	width: 75
	height: 30
	color: "#00000000"
	Rectangle { id: batRect; color: "#a0c7c4bf"; radius: 25; width: 75; height: 30 }
	Text {
		font.pointSize: 10
		property var percent: UPower.displayDevice.percentage*100
		property var batteryIcon: percent > 75 ? "" : percent > 50 ? "" : percent > 25 ? "" : percent > 0 ? "" : ""
		text: percent + "% " + batteryIcon 
		anchors.centerIn: batRect
	}
}
