import Quickshell
import Quickshell.Io
import QtQuick

Rectangle { 
	width: 30
	height: 30
	color: "#00000000"
	Process { command: [ "hyprlock" ]; id: lock }
	Rectangle { id: hyprlockRect; color: "#a0c7c4bf"; radius: 30; width: 30; height: 30 }
	Text { text: "⏻ "; anchors.centerIn: hyprlockRect; font.pointSize: 10 }
	MouseArea { anchors.fill: parent; onClicked: lock.startDetached() }
}
