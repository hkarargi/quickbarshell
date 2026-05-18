pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
	id: workspaceUtils
	
	property var maxId: 0
	property var workspaces: []

	function getWorkspaceIds(minWorkspaces) {
		var hyprworkspaces = [...Hyprland.workspaces.values].sort((a, b) => a?.id - b?.id).filter(function(x) { return x.id > 0 });
		var hyprworkspaceIds = hyprworkspaces.map(item => item.id);
		maxId = hyprworkspaceIds[hyprworkspaceIds.length-1]
		var minWorkspaceIds = [...Array(minWorkspaces).keys()].map(item => item+1)
		var conjoinedWorkspaceIds = [...new Set([...hyprworkspaceIds,...minWorkspaceIds])].sort(function(a,b) { return a - b })
		if (maxId < minWorkspaces) {
			return minWorkspaceIds
		}
		return	conjoinedWorkspaceIds
	}
	Connections {
        	target: Hyprland
        	function onRawEvent(event) {
			let eventName = event.name;
			switch (eventName) {
			case "createworkspacev2":
				{
					workspaceUtils.workspaces = getWorkspaceIds(1)           
				}
	            		case "destroyworkspacev2":
	                	{
					workspaceUtils.workspaces = getWorkspaceIds(1)           
				}
            		}
        	}
    	}
}
