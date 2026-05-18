import QtQuick
import Quickshell
import Quickshell.Hyprland

import "utils" as Utils

Utils.Base {
	
	radius: 8; width: Utils.WorkspaceUtils.getWorkspaceIds(persistentWorkspaces).length*19.9; height: 30

	property int persistentWorkspaces: 10
	rectColor: "#a0383b40"
	
	Grid { 
		anchors.fill: parent
		columns: children.length
		spacing: 2
		Repeater {
			model: Utils.WorkspaceUtils.getWorkspaceIds(persistentWorkspaces)
			Utils.TextModule {
				radius: 30;width: 18;height: 30

				property int num: modelData
				property bool isCurrent: Hyprland.focusedWorkspace?.id === num

				function clicked() {
					Hyprland.dispatch("hl.dsp.focus({workspace = " + num + " })")
				}				
			
				text: num
				textColor: isCurrent ? "#ff404040" : "#ffffffff"
				rectColor: isCurrent ? "#80ffffff" : "#00404040"
			}
		}
	}
}
