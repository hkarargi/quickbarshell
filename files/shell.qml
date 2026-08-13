//@ pragma UseQApplication

import Quickshell
import QtQml
import QtQuick

import "modules"
import "modules/templates"
import "modules/utils"

ShellRoot {
	id: root
	property color backgroundColor: "#00000000"
	property color foregroundColor: "#ffffffff"
	property color urgencyColor: "#ffffa0a0"
	property real itemRadius: 5
 
	Binding {
		target: ShellState
		property: "shellRoot"
		value: root
	}

	Bar { 
		id: topBar
		position: "top"
		
		color: "#007f7f7f" 

		implicitHeight: 35

		Compartment {
			id: rightGrid

			position: "right"

			Mic { }
			Speaker { }
			Backlight { }
			Clock { } 
			PowerButton { }
		}

		Compartment {
			id: centerGrid

			position: "center"

			ActiveWindow { }
		}

		Compartment {
			id: leftGrid

			position: "left"

			Workspaces { }
		}
	}

	Bar {

		id: leftBar
		position: "left"
		color: "#007f7f7f"

		implicitWidth: 35

		Compartment {
			id: topGrid
			position: "top"

			Battery { }
			Temperature { }
			Memory { }
			CPU { }
		}

		Compartment {
			id: bottomGrid
			position: "bottom"

			Network { }
			Tray { }
		}
	}
}
