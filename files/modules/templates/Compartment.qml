import Quickshell
import QtQuick
import QtQml

Rectangle {
	default property alias data: compartmentGrid.data
	property var parentWin: parent.parentWin
	
	color: compartmentGrid.color

	property string position: "center"
	property bool useVertical: parent.useVertical

	anchors.centerIn: position == "center" ? parent : undefined
	anchors.right: position == "right" ? parent.right : undefined
	anchors.left: position == "left" ? parent.left : undefined
	anchors.top: position == "top" ? parent.top : undefined
	anchors.bottom: position == "bottom" ? parent.bottom : undefined
	anchors.fill: position == "fill" ? parent : undefined

	width: compartmentGrid.implicitWidth
	height: compartmentGrid.implicitHeight

	anchors.horizontalCenter: useVertical ? parent.horizontalCenter : undefined
	anchors.verticalCenter: useVertical ? undefined : parent.verticalCenter

	property real padding: 2
	property real spacing: 8
	Grid {
		id: compartmentGrid
		
		property var parentWin: parent.parentWin

		anchors.centerIn: position == "center" ? parent : undefined
		anchors.right: position == "right" ? parent.right : undefined
		anchors.left: position == "left" ? parent.left : undefined
		anchors.top: position == "top" ? parent.top : undefined
		anchors.bottom: position == "bottom" ? parent.bottom : undefined
		anchors.fill: position == "fill" ? parent : undefined

		anchors.horizontalCenter: useVertical ? parent.horizontalCenter : undefined
		anchors.verticalCenter: useVertical ? undefined : parent.verticalCenter
		
		property color color: "#00000000"
		
		property bool useVertical: parent.useVertical

		padding: parent.padding
		spacing: parent.spacing

		columns: useVertical ? 1 : children.length
		rows: useVertical ? children.length : 1
	}
}
