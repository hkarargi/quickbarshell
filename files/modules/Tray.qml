import QtQuick
import Quickshell
import Qt5Compat.GraphicalEffects
import Quickshell.Services.SystemTray

import "templates"
import "utils" as Utils

Base {
	property var excludedTrays: ["Network"]
	id: tray


	height: useVertical ? Utils.TrayUtils.getTrayItemsExcluding(excludedTrays).length*size + ( Utils.TrayUtils.getTrayItemsExcluding(excludedTrays).length > 0 ? 25 : 0) : size
	
	width: useVertical ? size : Utils.TrayUtils.getTrayItemsExcluding(excludedTrays).length*size + ( Utils.TrayUtils.getTrayItemsExcluding(excludedTrays).length > 0 ? 25 : 0)

	radius: root.itemRadius
	rectColor: root.backgroundColor
	Grid {
		rows: useVertical ? children.length : 1
		columns: useVertical ? 1 : children.length
		anchors.centerIn: parent
		spacing: 2
		property var node: parent.node
		Repeater { 
			model: Utils.TrayUtils.getTrayItemsExcluding(excludedTrays)
			Base {
				width: size
				height: size
				radius: size
				rectColor: "#00000000"

				function clicked() {
					modelData.display(root,globalPos.x+mouseX,globalPos.y+mouseY)
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
