import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Networking

import "utils" as Utils

Utils.TextIconModule {
	Utils.NetworkUtils { id: netUtils}
	
	icons: ["󰤯","󰤟","󰤢","󰤥","󰤨"]

	prefix: netUtils.connected ? netUtils.activessid : "Disconnected..."
	number: netUtils.connected ? netUtils.activessidSignal : 0
}


