import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "templates"
import "utils"

PopupWindow {
	id: networkPopup

	anchor.window: parentWin
	anchor.rect.x: useVertical ? parentWin.width :  parentWin.itemPosition(parent).x + (parent.width - implicitWidth) * 0.5
	anchor.rect.y: useVertical ? parentWin.itemPosition(parent).y + (parent.height - implicitHeight) * 0.5: parentWin.height
	implicitWidth: 175
	implicitHeight: 300
	color: "#00000000"
	visible: true

	property var icons: parent.icons

	property color styleCol: Qt.rgba(root.backgroundColor.r,root.backgroundColor.g,root.backgroundColor.b,root.foregroundColor.a)

	
	property color textCurrent: Qt.rgba(root.foregroundColor.r,root.foregroundColor.g,root.foregroundColor.b,root.foregroundColor.a)
	property color textNcurrent: Qt.rgba(root.foregroundColor.r*0.75,root.foregroundColor.g*0.75,root.foregroundColor.b*0.75,root.foregroundColor.a)

	property color rectCurrent: Qt.rgba(root.backgroundColor.r,root.backgroundColor.g,root.backgroundColor.b,root.backgroundColor.a)
	property color rectNcurrent: Qt.rgba(root.backgroundColor.r,root.backgroundColor.g,root.backgroundColor.b,root.backgroundColor.a)


	Rectangle {
		id: rectangle

		anchors.fill: parent
		radius: 5
		color.r: backgroundColor.r
		color.g: backgroundColor.g
		color.b: backgroundColor.b//"#a0f0f0f0"
		color.a: 0.5
		ScrollView {
			

			anchors.fill: parent
			Component.onCompleted: {
				ScrollBar.vertical.position = 0.5 - ScrollBar.vertical.size/2
				ScrollBar.horizontal.position = 0.5 - ScrollBar.horizontal.size/2
				contentItem.interactive = false
			}

			ColumnLayout {
				width: networkPopup.width
				height: children.height

				spacing: -2

				Repeater {
					model: NetworkUtils.ssids

					Symbol {
						Layout.alignment: Qt.AlignHCenter
						Layout.margins: 2
						color: "#00000000"
						number: modelData[1]
						property var ssid: modelData[2]
						
						property var isCurrent: ssid === NetworkUtils.activessid
						
				styleColor: styleCol
				textColor: isCurrent ? textCurrent : textNcurrent
				rectColor: isCurrent ?  rectCurrent : rectNcurrent 
						icons: networkPopup.icons

						textAnchorVCenter: true
						textAnchorHCenter: true
						text: icon() + " " + number + "% " + ssid
						function clicked() {
							NetworkUtils.connect(ssid)
						}
					}
				}
				BarItem {
					textAnchorHCenter: true
					textAnchorVCenter: true
					Layout.alignment: Qt.AlignHCenter
					Layout.margins: 2
					color: "#00000000"

					property var isCurrent: !(NetworkUtils.state === "disconnected")

				styleColor: styleCol
				textColor: isCurrent ? textCurrent : textNcurrent
				rectColor: isCurrent ?  rectCurrent : rectNcurrent 
					
					text: isCurrent ? "Disconnect" : "Disconnected"

					function clicked() {
						NetworkUtils.disconnect(NetworkUtils.wifiDevice)
					}
				}
			}
		}
		
		Timer {
			id: endTimer
			interval: 1250
			running: false
			repeat: false
			onTriggered: popupLoader.source = ""
		}

		MouseArea {
			anchors.fill: parent
			acceptedButtons: Qt.NoButton
			hoverEnabled: true
			onEntered: endTimer.stop()
			onExited: endTimer.start()
		}
	}
}

