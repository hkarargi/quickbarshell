import QtQuick
import QtQml

Grid {
	property string position: "center"
	property bool useVertical: false

	anchors.centerIn: position == "center" ? parent : undefined
	anchors.right: position == "right" ? parent.right : undefined
	anchors.left: position == "left" ? parent.left : undefined
	anchors.top: position == "top" ? parent.top : undefined
	anchors.bottom: position == "bottom" ? parent.bottom : undefined
	anchors.fill: position == "fill" ? parent : undefined

	padding: 2
	
	anchors.horizontalCenter: useVertical ? parent.horizontalCenter : undefined
	anchors.verticalCenter: useVertical ? undefined : parent.verticalCenter

	spacing: 8

	columns: useVertical ? 1 : children.length
	rows: useVertical ? children.length : 1
}
