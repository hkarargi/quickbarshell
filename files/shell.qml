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
		spacing: 8
		id: rightGrid
		columns: children.length
		anchors.right: parent.right
		anchors.verticalCenter: parent.verticalCenter
		Network { icons: ["󰤯","󰤟","󰤢","󰤥","󰤨"] }
		CPU { }
		Memory { }
		Temperature { }
		Backlight { }
		Battery { }
		Clock { }
		Tray { }
		PowerButton { }
	}

	Grid {
		spacing: 8
		id: centerGrid
		anchors.horizontalCenter: parent.horizontalCenter 
		anchors.verticalCenter: parent.verticalCenter 
	}

	Grid {
		spacing: 8
		id: leftGrid
		anchors.left: parent.left
		anchors.verticalCenter: parent.verticalCenter
		Workspaces { persistentWorkspaces: 10 }
		ActiveWindow { }
	}
}

