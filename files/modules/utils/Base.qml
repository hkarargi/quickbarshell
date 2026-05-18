import QtQuick
import Qt5Compat.GraphicalEffects

Rectangle {
	id: base
	function clicked() {}
	property var globalPos: Qt.point(0,0)
	property var mouseX: 0
	property var mouseY: 0

	property var rectColor: "#a0c7c4bf"

	property var blurRadius: 32
	property var blurTransparentBorder: true
	
	width: childrenRect.width + 20
	height: 30
	radius: 30
	color: "#00000000"
	Rectangle { id: baseRect; color: base.rectColor; radius: parent.radius; width: parent.width; height: parent.height }
	MouseArea { id: mouseArea; anchors.fill: parent; onClicked: { globalPos = mouseArea.mapToItem(root.contentItem, mouseArea.x, mouseArea.y);base.mouseX = mouseArea.mouseX; base.mouseY = mouseArea.mouseY;base.clicked() } }
	FastBlur { radius: base.blurRadius; transparentBorder: base.blurTransparentBorder; anchors.fill: baseRect; source: baseRect}
}
