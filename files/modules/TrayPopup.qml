import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "templates"
import "utils"

PopupWindow {
	id: trayPopup

	function fit() {
		finishedSizing = false
		timer.repeat = true
		timer.running = true
	}

	property bool isChildPopup: !!parent.hasChildPopup
	property bool hasChildSummoned: false
	property var trayItem: isChildPopup ? parent.trayItem : null

	property var useVertical: isChildPopup ? true : parent.useVertical

	property point parentGlobalPos: parent.globalPosition()
	property rect parentRect: Qt.rect(parentGlobalPos.x,parentGlobalPos.y,parent.width,parent.height)

	function toggleLoader() { parent.toggleLoader()	}

	Component.onCompleted: fit()
	QsMenuOpener {
		id: menuOpener
		menu: isChildPopup ? parent.trayItem : parent.trayItem.menu
	}

	anchor.window: parentWin
	anchor.rect.x: 0
	anchor.rect.y: 0
	implicitWidth: 1000
	implicitHeight: 1000
	color: "#00000000"
	visible: true
	property color styleCol: Qt.rgba(ShellState.shellRoot.backgroundColor.r,ShellState.shellRoot.backgroundColor.g,ShellState.shellRoot.backgroundColor.b,ShellState.shellRoot.foregroundColor.a)


	property color textCurrent: Qt.rgba(ShellState.shellRoot.foregroundColor.r,ShellState.shellRoot.foregroundColor.g,ShellState.shellRoot.foregroundColor.b,ShellState.shellRoot.foregroundColor.a)

	property color rectCurrent: Qt.rgba(ShellState.shellRoot.backgroundColor.r,ShellState.shellRoot.backgroundColor.g,ShellState.shellRoot.backgroundColor.b,ShellState.shellRoot.backgroundColor.a)

	Rectangle {
		id: rectangle

		onWidthChanged: fit()
		onHeightChanged: fit()

		height: column.implicitHeight + 32 
		width: column.implicitWidth + 32

		radius: 5
		color.r: Math.max(backgroundColor.r,0.5)
		color.g: Math.max(backgroundColor.g,0.5)
		color.b: Math.max(backgroundColor.b,0.5)
		color.a: Math.max(backgroundColor.a,0.5)
		opacity: 0

		Column {
			id: column

			anchors.centerIn: parent

			property var parentWin: trayPopup

			spacing: 2

			Repeater {
				model: menuOpener.children
				Base {
					id: itemBase

					property var trayItem: modelData
					property var hasChildPopup: true
					property var parentWin: trayPopup

					//Layout.alignment: Qt.AlignHCenter
					//Layout.margins: trayItem.isSeparator ? 6 : 2
					color: trayItem.isSeparator ? "#ffffffff" : "#00000000"

					height: trayItem.isSeparator ? 1 : textBox.contentHeight
					width: trayItem.isSeparator || finishedSizing ? parent.implicitWidth : textBox.contentWidth

					anchors.horizontalCenter: parent.horizontalCenter

					Grid {	
						id: outputGrid
						columns: 2
						spacing: 3

						anchors.horizontalCenter:  parent.horizontalCenter
						anchors.verticalCenter:  parent.verticalCenter
						Image { 
							id: icon
							visible: trayItem.icon != ""
							source: trayItem.icon
							width: size/2
							height: size/2
							fillMode: Image.PreserveAspectFit
							horizontalAlignment: Image.AlignHCenter
							verticalAlignment: Image.AlignVCenter
						}

						Text {
							verticalAlignment: Text.AlignVCenter
							horizontalAlignment: Text.AlignHCenter
							id: textBox



							font.pointSize: 10

							color: textCurrent 
							style: Text.Outline
							styleColor: styleCol

							text: trayItem.text	
						}
					}

					Text {
						verticalAlignment: Text.AlignVCenter
						horizontalAlignment: Text.AlignHCenter

 						anchors.right: parent.right
						visible: trayItem.hasChildren	

						font.pointSize: 10

						color: textCurrent 
						style: Text.Outline
						styleColor: styleCol

						text: ">"
					}


					Component.onCompleted: loadTimer.running = true

					Timer {
						id: loadTimer
						interval: 100
						repeat: false
						onTriggered: {
							childPopupLoader.active = true
						}
					}

					Loader {
						id: childPopupLoader
						source: trayItem.hasChildren ? "TrayPopup.qml" : ""
						active: false
					}


					function clicked() {
						if (trayItem.hasChildren) {
							childPopupLoader.item.visible = !childPopupLoader.item.visible
						}
						else {	
							trayItem.triggered()
						}
					}


				}
			}
		}
	}

	property var finishedSizing: false

	Timer {
		id: timer
		interval: 16
		onTriggered: {
			if (rectangle.width > 0 && rectangle.height > 0 && !finishedSizing && trayPopup.visible) {
				trayPopup.implicitWidth = rectangle.width 
				trayPopup.implicitHeight = rectangle.height 
				trayPopup.anchor.rect.x = useVertical ? parentWin.implicitWidth :  parentRect.x + (parentRect.width - implicitWidth) * 0.5
				trayPopup.anchor.rect.y = useVertical ? parentRect.y + (parentRect.height - implicitHeight) * 0.5 : parentWin.implicitHeight
				timer.repeat = false

				rectangle.opacity = 1

				trayPopup.grabFocus = true
				trayPopup.visible = false

				finishedSizing = true
			}
		}
	}


}


