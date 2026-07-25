import Quickshell
import QtQuick

import "templates"
import "utils" as Utils

BarItem {
	textAnchorHCenter: true
	textAnchorVCenter: true

	property real cutOff: 50

	property string windowTitle: Utils.ActiveWindowUtils.activeWindowTitle

	textWidth: 9999

	rectColor: "#00000000"
	text: windowTitle.substring(0,cutOff) + (windowTitle.substring(0,cutOff) == windowTitle ? "" : "...")
	textColor: "#ffffffff"
	styleColor: "#80000000"
	style: Text.Outline
}
