import QtQuick
import Quickshell

import "templates"
import "utils"

Symbol {
	property var showNetworkName: false

	property var component: Qt.createComponent("NetworkPopup.qml")

	function clicked() {	
		//TrayUtils.getTrayItemsIncluding("Network")[0].display(parentWin,globalPos.x+mouseX,globalPos.y+mouseY)
		networkPopup.item.visible = !networkPopup.item?.visible
	}
	property var normalIcons: ["󰤯","󰤟","󰤢","󰤥","󰤨"]
	property var limitedIcons: ["󰤫","󰤠","󰤣","󰤦","󰤩"]

	icons: NetworkUtils.connectivity != "limited" ? normalIcons : limitedIcons
	altIcon: NetworkUtils.state === "disconnected" ? "󰤭" : "󱥸"
	useAlt: NetworkUtils.state != "connected"

	prefix: showNetworkName ? useVertical ? (NetworkUtils.state === "connected" ? NetworkUtils.activessid + "\n" : "Disconnected...\n") : (NetworkUtils.state === "connected" ? NetworkUtils.activessid : "Disconnected...") : ""

	Loader {
		id: networkPopup
		source: "NetworkPopup.qml"
		active: false
	}
	Component.onCompleted: timer.running = true

	Timer {
		id: timer
		interval: 100
		repeat: false
		onTriggered: {
			networkPopup.active = true
		}
	}
	number: NetworkUtils.state === "connected" ? NetworkUtils.activessidSignal : 0

}


