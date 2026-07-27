import QtQuick
import Quickshell
import Quickshell.Hyprland

import "templates"
import "utils"

Base {
	property var workspaceIds: WorkspaceUtils.getWorkspaceIds(persistentWorkspaces)

	property color styleCurrent: Qt.rgba(root.backgroundColor.r,root.backgroundColor.g,root.backgroundColor.b,root.foregroundColor.a)
	property color styleUcurrent: Qt.rgba(0.5*root.urgencyColor.r,0.5*root.urgencyColor.g,0.5*root.urgencyColor.b,root.foregroundColor.a)
	property color styleNcurrent: Qt.rgba(root.foregroundColor.r,root.foregroundColor.g,root.foregroundColor.b,4*root.backgroundColor.a)
	
	property color textCurrent: Qt.rgba(root.foregroundColor.r,root.foregroundColor.g,root.foregroundColor.b,root.foregroundColor.a)
	property color textUcurrent: Qt.rgba(root.urgencyColor.r,root.urgencyColor.g,root.urgencyColor.b,root.foregroundColor.a)
	property color textNcurrent: Qt.rgba(root.backgroundColor.r,root.backgroundColor.g,root.backgroundColor.b,root.foregroundColor.a)

	property color rectCurrent: Qt.rgba(root.backgroundColor.r,root.backgroundColor.g,root.backgroundColor.b,root.backgroundColor.a)
	property color rectNcurrent: Qt.rgba(root.backgroundColor.r,root.backgroundColor.g,root.backgroundColor.b,root.backgroundColor.a)

	radius: Math.max(4,root.itemRadius/4)
	
	//height: useVertical ? workspaceIds.length*(size) : size
	//width: useVertical ? size : workspaceIds.length*(size)

	height: workspacesGrid.implicitHeight
	width: workspacesGrid.implicitWidth


	property int persistentWorkspaces: 10
	rectColor: backgroundColor

	Grid { 
		id: workspacesGrid
		anchors.centerIn: parent
		rows: useVertical ? children.length : 1
		columns: useVertical ? 1 : children.length
		spacing: 2
		property var useVertical: parent.useVertical 

		Repeater {
			model: workspaceIds
			property var useVertical: parent.useVertical

			anchors.horizontalCenter: parent.horizontalCenter
			BarItem {
				textWidth: parent.width
				radius: root.itemRadius

				textAnchorHCenter: true
				textAnchorVCenter: true

				property int num: modelData
				property bool isCurrent: WorkspaceUtils.currentWorkspace === num
				property bool isUrgent: WorkspaceUtils.isUrgent(num)

				function clicked() {
					Hyprland.dispatch("hl.dsp.focus({workspace = " + num + " })")
				}				

				styleColor: isCurrent ?  styleCurrent : isUrgent ? styleUcurrent : styleNcurrent 
				text: num
				textColor: isCurrent ? textCurrent : isUrgent ? textUcurrent : textNcurrent
				rectColor: isCurrent ?  rectCurrent : rectNcurrent 
			}
		}
	}
}
