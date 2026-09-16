import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQml

Rectangle {
	default property alias data: compartmentGrid.data
	property var parentWin: parent.parentWin

	color: compartmentGrid.color

	property string position: "center"
	property bool useVertical: parent.useVertical

	Layout.column: !useVertical ? (position == "left" ? 0 : position == "center" ? 1 : position == "right" ? 2 : undefined) : 0
	Layout.row: useVertical ? (position == "left" ? 0 : position == "center" ? 1 : position == "right" ? 2 : undefined) : 0
	Layout.alignment: position == "left" ? Qt.AlignLeft : position == "center" ? Qt.AlignCenter : position == "right" ? Qt.AlignLeft : undefined

	Layout.fillWidth: position == "center" || useVertical ? true : false
	Layout.fillHeight: position == "center" || !useVertical ? true : false

	Layout.preferredWidth: compartmentGrid.implicitWidth
	Layout.preferredHeight: compartmentGrid.implicitHeight

//	anchors.centerIn: position == "center" ? parent : undefined
//	anchors.right: position == "right" ? parent.right : undefined
//	anchors.left: position == "left" ? parent.left : undefined
//	anchors.top: position == "top" ? parent.top : undefined
//	anchors.bottom: position == "bottom" ? parent.bottom : undefined
//
//	anchors.fill: position == "fill" ? parent : undefined
//
//	anchors.horizontalCenter: useVertical ? parent.horizontalCenter : undefined
//	anchors.verticalCenter: useVertical ? undefined : parent.verticalCenter
//
	property real padding: 2
	property real spacing: 8
	Grid {
		id: compartmentGrid

		property var parentWin: parent.parentWin

		x: position == "center" && !useVertical ? Math.max(Math.min((parentWin.width-parent.width+0.5*width)*0.5,parent.width-width),0) : 0
		y: position == "center" && useVertical ? Math.max(Math.min((parentWin.height-parent.height+0.5*height)*0.5,parent.height-height),0) : 0


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

		columns: useVertical ? 1 : children.length + 3
		rows: useVertical ? children.length : 1
	}
}
