import Quickshell
import QtQuick

import "utils" as Utils


Utils.TextModule {
	textAnchorLeft: true
	textAnchorVCenter: true

	rectColor: "#00000000"
	text: Utils.ActiveWindowUtils.activeWindowTitle
	textColor: "#ffc7c4bf"
	styleColor: "#80383b40"
	style: Text.Outline
}
