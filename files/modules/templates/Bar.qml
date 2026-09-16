import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
	id: panel

	property string position: "top"
	property bool useVertical: (position == "right" || position == "left")

	default property alias data: gridLayout.data

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
		GridLayout {
			id: gridLayout
			anchors.fill: parent

			property var parentWin: panel
			property bool useVertical: (position == "right" || position == "left")

			columns: useVertical ? 1 : 3
			rows: useVertical ? 3 : 1
		}
	}
}
