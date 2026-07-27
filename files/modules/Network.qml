import QtQuick
import Quickshell

import "templates"
import "utils"

Symbol {
	property var showNetworkName: false

	property var component: Qt.createComponent("NetworkPopup.qml")
	
	function clicked() {	
		//TrayUtils.getTrayItemsIncluding("Network")[0].display(parentWin,globalPos.x+mouseX,globalPos.y+mouseY)
		if (popupLoader.source == "") {
			NetworkUtils.rescan()
			popupLoader.source = "NetworkPopup.qml"
		}
		else {
			popupLoader.source = ""
		}
	}
	property var normalIcons: ["󰤯","󰤟","󰤢","󰤥","󰤨"]
	property var limitedIcons: ["󰤫","󰤠","󰤣","󰤦","󰤩"]
	
	icons: NetworkUtils.connectivity != "limited" ? normalIcons : limitedIcons
	altIcon: NetworkUtils.state === "disconnected" ? "󰤭" : "󱥸"
	useAlt: NetworkUtils.state != "connected"

	prefix: showNetworkName ? useVertical ? (NetworkUtils.state === "connected" ? NetworkUtils.activessid + "\n" : "Disconnected...\n") : (NetworkUtils.state === "connected" ? NetworkUtils.activessid : "Disconnected...") : ""
	
	Loader {
		id: popupLoader
	}

	number: NetworkUtils.state === "connected" ? NetworkUtils.activessidSignal : 0

}


