import QtQuick
import Quickshell

import "templates"
import "utils"

Symbol {
	property var showNetworkName: false

	function clicked() {
		TrayUtils.getTrayItemsIncluding("Network")[0].display(root,globalPos.x+mouseX,globalPos.y+mouseY)

	}

	icons: ["󰤯","󰤟","󰤢","󰤥","󰤨"]

	prefix: showNetworkName ? useVertical ? (NetworkUtils.connected ? NetworkUtils.activessid + "\n" : "Disconnected...\n") : (NetworkUtils.connected ? NetworkUtils.activessid : "Disconnected...") : ""
	number: NetworkUtils.connected ? NetworkUtils.activessidSignal : 0

}


