//@ pragma UseQApplication

import Quickshell
import Quickshell.Hyprland
import QtQml
import QtQuick
import QtQuick.Layouts

import "modules"
import "modules/templates"
import "modules/utils" as Utils

PanelWindow {
	id: root
	anchors { right: true; left: true; top: true; bottom: true }
	focusable: false
	aboveWindows: false
	color: "#00ffffff"
	
	exclusionMode: ExclusionMode.Ignore

	property color backgroundColor: "#00000000"
	property color foregroundColor: "#ffffffff"
	property real itemRadius: 5	
	
	PanelWindow {
		id: topBar
		anchors { top: true; left: true; right: true }
		
		color: "#007f7f7f"

		implicitHeight: 35

		Compartment {
			id: rightGrid

			position: "right"
			
			Backlight { }
			Mic { }
			Speaker { }
			Clock { }
			PowerButton { }
		}

		Compartment {
			id: centerGrid

			position: "center"

			ActiveWindow { useVertical: false }
		}

		Compartment {
			id: leftGrid

			position: "left"

			Workspaces { }
		}
	}

	PanelWindow {
		id: leftBar
		anchors { left: true; top: true; bottom: true }
		
		color: "#007f7f7f"

		implicitWidth: 35

		Compartment {
			id: topGrid

			position: "top"
			useVertical: true

			Battery { }
			Temperature { }
			Memory { }
			CPU { }
		}

		Compartment {
			id: bottomGrid

			anchors.horizontalCenter: parent.horizontalCenter

			position: "bottom"
			useVertical: true
			
			Network { }
			Tray { }
		}
	}
}
