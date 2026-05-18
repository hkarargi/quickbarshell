import QtQuick

import "." as Utils

Utils.Base {
	id: textModule

	property var text: ""
	property var textColor: "#ff000000"
	property var textSize: 10

	Text {
		font.pointSize: textModule.textSize
		text: textModule.text
		anchors.centerIn: parent
		color: textModule.textColor
	}

}
