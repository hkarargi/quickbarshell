import QtQuick

import "."

BarItem {
	id: textIconModule

	textAnchorHCenter: true
	textAnchorVCenter: true

	property string altIcon: ""
	property bool useAlt: false

	property list<string> icons: ["","","","",""]
	
	property string prefix: ""
	property int number: 0
	property string suffix: ""

	function icon() {
		var perIcon = 100/(icons.length-1)
		return useAlt ? altIcon : number > 100 ? icons[icons.length - 1] : number < 0 ? icons[0] : icons[Math.ceil(number/perIcon)] 
	}

	text: (prefix != "" ? prefix + " ":prefix) + number + "% " + (useVertical ? "\n" : "") + icon() + suffix
	
}
