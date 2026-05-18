//@ pragma UseQApplication

import Quickshell
import Quickshell.Hyprland
import QtQuick

import "modules"

PanelWindow {
	id: root
	anchors.top: true
	anchors.left: true
	anchors.right: true
	implicitHeight: 35
	color: "#00000000"


	Grid {
		id: rightGrid
		columns: children.length
		anchors.right: parent.right
		Battery { }
		Network { }
		Clock { }
		Tray { }
		PowerButton { }
	}

	Grid {
		id: centerGrid
		anchors.centerIn: parent
	}

	Grid {
		id: leftGrid
		anchors.left: parent.left
		Workspaces { persistentWorkspaces: 20 }
	}
}

