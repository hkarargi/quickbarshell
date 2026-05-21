import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Networking

import "utils" as Utils

Utils.TextIconModule {
	Utils.NetworkUtils { id: netUtils}
	
	property var showNetworkName: true

	function clicked() {
		Utils.TrayUtils.getTrayItemsIncluding("Network")[0].display(root,globalPos.x+mouseX,globalPos.y+mouseY)

	}

	icons: ["󰤯","󰤟","󰤢","󰤥","󰤨"]

	prefix: showNetworkName ? (netUtils.connected ? netUtils.activessid : "Disconnected...") : ""
	number: netUtils.connected ? netUtils.activessidSignal : 0
}


