//@ pragma UseQApplication

import Quickshell
import Quickshell.Hyprland
import QtQml
import QtQuick
import QtQuick.Layouts

import "modules"

PanelWindow {
	id: root
	anchors.top: true
	anchors.left: true
	anchors.right: true
	implicitHeight: 35
	color: "#00000000"
	
	property var backgroundColor: "#a0c7c4bf"

	Grid {
		id: rightGrid
		columns: children.length
		anchors.right: parent.right
		anchors.verticalCenter: parent.verticalCenter
		Battery { icons: ["","","","",""] }
		Network { icons: ["󰤯","󰤟","󰤢","󰤥","󰤨"] }
		Clock { format: "hh:mm AP"; icon: "" }
		Clock { format: "dd/MM/yyyy"; icon: "󰸘" }
		
		Tray { excludedTrays: ["Network"]}
		PowerButton { lockCommand: "hyprlock"; buttonText: "⏻ " }
	}

	Grid {
		id: centerGrid
		anchors.horizontalCenter: parent.horizontalCenter 
		anchors.verticalCenter: parent.verticalCenter 
	}

	ColumnLayout {
		id: leftGrid
		anchors.left: parent.left
		anchors.verticalCenter: parent.verticalCenter
		Workspaces { persistentWorkspaces: 10 }
	}
}

