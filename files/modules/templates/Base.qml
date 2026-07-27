import QtQuick
import Quickshell
import Qt5Compat.GraphicalEffects

Rectangle {
	id: base
	
	property var parentWin: parent.parentWin

	function clicked() {}
	function wheel(angleDelta) {}
	property point globalPos: Qt.point(0,0)
	property real mouseX: 0
	property real mouseY: 0

	property real childrenHeight
	property real childrenWidth

	property bool useVertical: !!parent.useVertical

	property color rectColor: root.backgroundColor

	property real size: 30
	property real sizePadding: 20

	property real blurRadius: 0
	property bool blurTransparentBorder: true

	height: useVertical ? childrenHeight + sizePadding : size
	width: useVertical ? size : childrenWidth + sizePadding
	radius: root.itemRadius
	color: "#00000000"
	Rectangle {
		id: baseRect
		color: base.rectColor
		radius: parent.radius
		width: parent.width
		height: parent.height 
	}


	MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		onClicked: { 
			globalPos = parentWin?.itemPosition(mouseArea) ?? Qt.point(0,0)
			base.mouseX = mouseArea.mouseX
			base.mouseY = mouseArea.mouseY
			base.clicked() 
		} 
		onWheel: function(wheel) {
			globalPos = parentWin?.itemPosition(mouseArea) ?? Qt.point(0,0)
			base.mouseX = mouseArea.mouseX
			base.mouseY = mouseArea.mouseY
			base.wheel(wheel.angleDelta) 
		} 

	}
	FastBlur { 
		radius: base.blurRadius
		transparentBorder: base.blurTransparentBorder
		anchors.fill: baseRect
		source: baseRect
	}
}
