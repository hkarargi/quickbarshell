import QtQuick
import Quickshell
import Quickshell.Hyprland
Rectangle {
	color: "#a0383b40"; radius: 8; width: 200; height: 30
	Grid { 
		anchors.centerIn: parent
		columns: 10
		spacing: 2
		Repeater {
			model: parent.columns
			Rectangle {
				
				radius: 30
				width: 18
				height: 30
				property int num: index +1
				property bool isCurrent: Hyprland.focusedWorkspace?.id === num
				Text {
					anchors.centerIn: parent				
					text: num
					font.pointSize: 10
					color: isCurrent ? "#ff404040" : "#ffffffff"
				}
				MouseArea { anchors.fill: parent; onClicked: Hyprland.dispatch("hl.dsp.focus({workspace = " + num + " })")}
				
				color: isCurrent ? "#80ffffff" : "#00404040"
			}
		}
	}
}
