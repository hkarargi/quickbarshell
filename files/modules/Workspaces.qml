import QtQuick
import Quickshell
import Quickshell.Hyprland

import "utils" as Utils

Rectangle {
	
	id: rect
	color: "#a0383b40"; radius: 8; width: childrenRect.width*1.005; height: 30

	property int persistentWorkspaces: 10

	
	Grid { 
		anchors.centerIn: parent
		columns: children.length
		spacing: 2
		Repeater {
			model: Utils.WorkspaceUtils.getWorkspaceIds(10)
			Rectangle {
				radius: 30
				width: 18
				height: 30
				property int num: modelData
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
