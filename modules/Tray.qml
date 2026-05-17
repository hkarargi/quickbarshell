import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Rectangle {
	width: childrenRect.width
	height: 30
	radius: 30
	color: "#a0c7c4bf"
	Grid {
		anchors.centerIn: parent
	 	spacing: 2
		Repeater { 
			model: SystemTray.items
			Rectangle {
				width: 30
				height: 30
				radius: 30
				color: "#00000000"
				Text { text: mouseArea.selfPos }
				MouseArea {
					id: mouseArea
					anchors.fill: parent
					onClicked: {
						var selfPos = mouseArea.mapToItem(root.contentItem, mouseArea.x, mouseArea.y);
						modelData.display(root,selfPos.x+mouseX,selfPos.y+mouseY) 
					}					
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
