import QtQuick

import "." as Utils

Utils.Base {
	id: textModule

	property var text: ""
	property var textColor: "#ff000000"
	property var textSize: 10
	property var style: Text.Normal
	property var styleColor: "#00000000"

	property var textAnchorLeft: false
	property var textAnchorRight: false
	property var textAnchorHCenter: false
	property var textAnchorVCenter: false
	property var textAnchorTop: false
	property var textAnchorBottom: false

	childrenWidth: textBox.width

	Text {
		id: textBox
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
