import QtQuick

import "." as Utils

Utils.TextModule {
	id: textIconModule

	textAnchorHCenter: true
	textAnchorVCenter: true

	property var altIcon: ""
	property var useAlt: false

	property var icons: ["","","","",""]
	
	property var prefix: ""
	property var number: 0
	property var suffix: ""

	function icon() {
		var perIcon = 100/(icons.length-1)
		return useAlt ? altIcon : icons[Math.ceil(number/perIcon)]
	}

	text: (prefix != "" ? prefix + " ":prefix) + number + "% " + icon() + (suffix != "" ? suffix + " ":suffix)
	
}
