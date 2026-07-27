import Quickshell
import QtQuick

PanelWindow {
	id: panel

	property string position: "top"
	property bool useVertical: (position == "right" || position == "left")

	default property alias data: panelRect.data

	anchors.top: position != "bottom" ? true : false
	anchors.bottom: position != "top" ? true : false
	anchors.right: position != "left" ? true : false
	anchors.left: position != "right" ? true : false
	
	Rectangle {
		id: panelRect
		anchors.fill: parent
		
		color: "#00000000"

		property var parentWin: panel
		property bool useVertical: (position == "right" || position == "left")
	}
}
