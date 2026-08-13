import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "templates"
import "utils"

PopupWindow {
	id: networkPopup

	property point parentGlobalPos: parent.globalPosition()
	property rect parentRect: Qt.rect(parentGlobalPos.x,parentGlobalPos.y,parent.width,parent.height)
	
	anchor.window: parentWin
	anchor.rect.x: useVertical ? parentWin.implicitWidth :  parentRect.x + (parentRect.width - implicitWidth) * 0.5
	anchor.rect.y: useVertical ? parentRect.y + (parentRect.height - implicitHeight) * 0.5 : parentWin.implicitHeight
	implicitWidth: 175
	implicitHeight: 300
	color: "#00000000"
	visible: true

	property var icons: parent.normalIcons

	property color styleCol: Qt.rgba(ShellState.shellRoot.backgroundColor.r,ShellState.shellRoot.backgroundColor.g,ShellState.shellRoot.backgroundColor.b,ShellState.shellRoot.foregroundColor.a)


	property color textCurrent: Qt.rgba(ShellState.shellRoot.foregroundColor.r,ShellState.shellRoot.foregroundColor.g,ShellState.shellRoot.foregroundColor.b,ShellState.shellRoot.foregroundColor.a)
	property color textNcurrent: Qt.rgba(ShellState.shellRoot.foregroundColor.r*0.75,ShellState.shellRoot.foregroundColor.g*0.75,ShellState.shellRoot.foregroundColor.b*0.75,ShellState.shellRoot.foregroundColor.a)

	property color rectCurrent: Qt.rgba(ShellState.shellRoot.backgroundColor.r,ShellState.shellRoot.backgroundColor.g,ShellState.shellRoot.backgroundColor.b,ShellState.shellRoot.backgroundColor.a)
	property color rectNcurrent: Qt.rgba(ShellState.shellRoot.backgroundColor.r,ShellState.shellRoot.backgroundColor.g,ShellState.shellRoot.backgroundColor.b,ShellState.shellRoot.backgroundColor.a)


 	Component.onCompleted: {  opacity = 1;visible = false;grabFocus = true}

	Rectangle {
		id: rectangle

		anchors.fill: parent
		radius: 5
		color.r: Math.max(backgroundColor.r,0.5)
		color.g: Math.max(backgroundColor.g,0.5)
		color.b: Math.max(backgroundColor.b,0.5)
		color.a: Math.max(backgroundColor.a,0.5)
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
					model: NetworkUtils.ssids.sort(function(a,b) { return (b[1] + (b[2]==NetworkUtils.activessid ? 1000 : 0)-(a[1] + (a[2]==NetworkUtils.activessid ? 1000: 0)))})

					Symbol {
						Layout.alignment: Qt.AlignHCenter
						Layout.margins: 2
						color: "#00000000"
						number: modelData[1] ?? 0
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

					property var isCurrent: NetworkUtils.state === "disconnected"

					styleColor: styleCol
					textColor: isCurrent ? textCurrent : textNcurrent
					rectColor: isCurrent ?  rectCurrent : rectNcurrent 

					text: isCurrent ? "Disconnected" : "Disconnect"

					function clicked() {
						NetworkUtils.disconnect(NetworkUtils.wifiDevice)
					}
				}
			}
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

