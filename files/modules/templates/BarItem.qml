import QtQuick
import Qt5Compat.GraphicalEffects

import "." as Utils

Utils.Base {
	id: textModule

	property string text: ""
	property color textColor: foregroundColor
	property real textSize: size/3.5+1
	property real textWidth: 35
	property var style: Text.Outline
	property color styleColor: "#ff000000"

	property bool textAnchorLeft: false
	property bool textAnchorRight: false
	property bool textAnchorHCenter: false
	property bool textAnchorVCenter: false
	property bool textAnchorTop: false
	property bool textAnchorBottom: false

	childrenHeight: textBox.contentHeight
	childrenWidth: textBox.contentWidth

	property Text textItem: textBox

	Text {
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		wrapMode: useVertical ? Text.WrapAnywhere : Text.NoWrap
		id: textBox
		width: textWidth
		font.pointSize: textModule.textSize
		text: textModule.text
		
		anchors.left: textAnchorLeft ? parent.left : undefined
		anchors.right: textAnchorRight ? parent.right : undefined
		anchors.horizontalCenter: textAnchorHCenter ? parent.horizontalCenter : undefined
		anchors.verticalCenter: textAnchorVCenter ? parent.verticalCenter : undefined
		anchors.top: textAnchorTop ? parent.top : undefined
		anchors.bottom: textAnchorBottom ? parent.bottom : undefined
		color: textModule.textColor
		style: textModule.style
		styleColor: textModule.styleColor
	}

}
