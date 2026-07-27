import QtQuick
import Quickshell
import Qt5Compat.GraphicalEffects
import Quickshell.Services.SystemTray

import "templates"
import "utils"

Base {
	property var excludedTrays: []
	id: tray


	height: useVertical ? itemsGrid.height : size
	
	width: useVertical ? size : itemsGrid.width

	radius: root.itemRadius
	rectColor: root.backgroundColor
	Compartment {
		id: itemsGrid
		position: "center"
		
		Repeater { 
			model: TrayUtils.getTrayItemsExcluding(excludedTrays)
			Base {
				width: size
				height: size
				radius: size
				rectColor: "#00000000"

				function clicked() {
					modelData.display(parentWin,globalPos.x+mouseX,globalPos.y+mouseY)
				}
				
				Image { 
					id: icon
					source: modelData.icon
					anchors.centerIn: parent
					width: size
					height: size
					fillMode: Image.PreserveAspectFit
					horizontalAlignment: Image.AlignHCenter
					verticalAlignment: Image.AlignVCenter
					layer.enabled: true
					layer.effect: DropShadow {
						verticalOffset: 0
						horizontalOffset: 0
						radius: 1
						spread:0.75
						color: "#ff000000"
					}
				}
			}
		}
	}	
}
