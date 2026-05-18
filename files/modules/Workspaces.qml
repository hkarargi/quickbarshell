import QtQuick
import Quickshell
import Quickshell.Hyprland
Rectangle {
	
	id: rect
	color: "#a0383b40"; radius: 8; width: childrenRect.width*1.005; height: 30

	property int persistentWorkspaces: 10

	property var maxId: 0
	
	function findMaxId() {
		var workspaces = [...Hyprland.workspaces.values].sort((a, b) => a?.id - b?.id);
		workspaces = workspaces.filter(function(x) { return x.id > 0 });
		var workspaceIds = workspaces.map(item => item.id);
		maxId = workspaceIds[workspaceIds.length-1]
		var persistentWorkspaceIds = [...Array(persistentWorkspaces).keys()].map(item => item+1)
		var conjoinedWorkspaceIds = [...new Set([...workspaceIds,...persistentWorkspaceIds])].sort(function(a,b) { return a - b })
		console.log(conjoinedWorkspaceIds)
		if (maxId < persistentWorkspaces) {
			return persistentWorkspaceIds
		}
		return	conjoinedWorkspaceIds
	}
	Grid { 
		anchors.centerIn: parent
		columns: children.length
		spacing: 2
		Repeater {
			model: findMaxId()
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
