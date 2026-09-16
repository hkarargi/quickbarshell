import QtQuick
import QtQml
import Quickshell.Widgets
import Quickshell
import Qt5Compat.GraphicalEffects
import Quickshell.Services.SystemTray

import "templates"
import "utils"

Base {
	property var excludedTrays: []
	id: tray


	height: useVertical ? itemsGrid.implicitHeight : size

	width: useVertical ? size : itemsGrid.implicitWidth


	radius: ShellState.shellRoot.itemRadius
	rectColor: ShellState.shellRoot.backgroundColor


	Grid {
		id: itemsGrid
		anchors.centerIn: parent

		property QsWindow parentWin: parent.parentWin

		Repeater { 
			model: TrayUtils.getTrayItemsExcluding(excludedTrays)
			Base {
				width: size
				height: size
				radius: size
				rectColor: "#00000000"

				property var trayItem: modelData

				Loader {
					id: trayPopup
					source: "TrayPopup.qml"
					active: false
				}
				Component.onCompleted: timer.running = true

				Timer {
					id: timer
					interval: 100
					repeat: false
					onTriggered: {
						trayPopup.active = true
					}
				}

				function clicked() {
					//trayItem.display(parentWin,globalPos.x+mouseX,globalPos.y+mouseY)
					trayPopup.item.visible = true
				}

				IconImage { 
					id: icon
					source: trayItem.icon
					anchors.centerIn: parent
					implicitSize: size
					//fillMode: Image.PreserveAspectFit
					//horizontalAlignment: Image.AlignHCenter
					//verticalAlignment: Image.AlignVCenter
					layer.enabled: true
					layer.effect: DropShadow {
						verticalOffset: 0
						horizontalOffset: 0
						radius: 1
						spread: 0.5
						color: "#ff000000"
					}
				}
			}
		}
	}	
}
