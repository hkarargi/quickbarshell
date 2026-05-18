import QtQuick

Rectangle {
	id: base
	function clicked() {}

	property var globalPos: mouseArea.mapToItem(root.contentItem, mouseArea.x, mouseArea.y)
	property var rectColor: "#a0c7c4bf"
	
	width: childrenRect.width + 20
	height: 30
	radius: 30
	color: "#00000000"
	Rectangle { id: baseRect; color: base.rectColor; radius: parent.radius; width: parent.width; height: parent.height }
	MouseArea { id: mouseArea; anchors.fill: parent; onClicked: { base.clicked() } }

}
