//@ pragma UseQApplication
//@ pragma IconTheme breeze

import Quickshell
import QtQml
import QtQuick
import QtQuick.Layouts

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

			Network { }
			Mic { }
			Speaker { }
			Backlight { }
			Memory { }
			Temperature { }
			CPU { }
			Battery { }
			Clock { } 
			PowerButton { }
		}
		Compartment {
			id: centerGrid

			position: "center"
			//Tray { }
			ActiveWindow { }
		}

		Compartment {
			id: leftGrid

			position: "left"
			Workspaces { }
		}
	}
}
