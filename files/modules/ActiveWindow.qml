import Quickshell
import QtQuick

import "utils" as Utils


Utils.TextModule {
	textAnchorLeft: true
	textAnchorVCenter: true

	property var cutOff: 50

	property var windowTitle: Utils.ActiveWindowUtils.activeWindowTitle

	rectColor: "#00000000"
	text: windowTitle.substring(0,cutOff) + (windowTitle.substring(0,cutOff) == windowTitle ? "" : "...")
	textColor: "#ffc7c4bf"
	styleColor: "#80383b40"
	style: Text.Outline
}
