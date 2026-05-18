import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

import "utils" as Utils

Utils.Base {
	width: childrenRect.width
	height: 30
	radius: 30
	rectColor: "#a0c7c4bf"
	Grid {
		anchors.centerIn: parent
	 	spacing: 2
		Repeater { 
			model: SystemTray.items
			Utils.Base {
				width: 30
				height: 30
				radius: 30
				rectColor: "#00000000"

				function clicked() {
					modelData.display(root,globalPos.x+mouseX,globalPos.y+mouseY)
				}
				

				Image { 
					source: modelData.icon
					anchors.centerIn: parent
					width: 25
					height: 30
					fillMode: Image.PreserveAspectFit
					horizontalAlignment: Image.AlignHCenter
					verticalAlignment: Image.AlignVCenter
				}
			}
		}
	}	
}
