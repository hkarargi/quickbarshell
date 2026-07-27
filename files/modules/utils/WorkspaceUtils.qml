pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
	id: workspaceUtils
	
	property int maxId: 0
	property list<string> workspaces: []
	property var currentWorkspace: Hyprland.focusedWorkspace?.id

	function getWorkspaceIds(minWorkspaces) {
		var hyprworkspaces = [...Hyprland.workspaces.values].sort((a, b) => a?.id - b?.id).filter(function(x) { return x.id > 0 });
		var hyprworkspaceIds = hyprworkspaces.map(item => item.id);
		var newMaxId = hyprworkspaceIds[hyprworkspaceIds.length-1] ?? 0
		maxId = newMaxId
		var minWorkspaceIds = [...Array(minWorkspaces).keys()].map(item => item+1)
		var conjoinedWorkspaceIds = [...new Set([...hyprworkspaceIds,...minWorkspaceIds])].sort(function(a,b) { return a - b })
		if (newMaxId < minWorkspaces) {
			return minWorkspaceIds
		}
		return	conjoinedWorkspaceIds
	}

	function isUrgent(i) {
		return !!Hyprland.workspaces?.values?.find(x => x.id === i)?.urgent
	}

	Connections {
        	target: Hyprland
        	function onRawEvent(event) {
			let eventName = event.name;
			switch (eventName) {
			case "createworkspacev2":
	            	case "destroyworkspacev2":
				workspaceUtils.workspaces = getWorkspaceIds(1)         
				break
            		}
        	}
    	}
}
