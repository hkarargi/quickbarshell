import QtQuick
import Quickshell
import Quickshell.Hyprland

import "templates"
import "utils"

Base {
	property var workspaceIds: WorkspaceUtils.getWorkspaceIds(persistentWorkspaces)

	property color styleCurrent: Qt.rgba(ShellState.shellRoot.backgroundColor.r,ShellState.shellRoot.backgroundColor.g,ShellState.shellRoot.backgroundColor.b,ShellState.shellRoot.foregroundColor.a)
	property color styleUcurrent: Qt.rgba(0.5*ShellState.shellRoot.urgencyColor.r,0.5*ShellState.shellRoot.urgencyColor.g,0.5*ShellState.shellRoot.urgencyColor.b,ShellState.shellRoot.foregroundColor.a)
	property color styleNcurrent: Qt.rgba(ShellState.shellRoot.foregroundColor.r,ShellState.shellRoot.foregroundColor.g,ShellState.shellRoot.foregroundColor.b,4*ShellState.shellRoot.backgroundColor.a)
	
	property color textCurrent: Qt.rgba(ShellState.shellRoot.foregroundColor.r,ShellState.shellRoot.foregroundColor.g,ShellState.shellRoot.foregroundColor.b,ShellState.shellRoot.foregroundColor.a)
	property color textUcurrent: Qt.rgba(ShellState.shellRoot.urgencyColor.r,ShellState.shellRoot.urgencyColor.g,ShellState.shellRoot.urgencyColor.b,ShellState.shellRoot.foregroundColor.a)
	property color textNcurrent: Qt.rgba(ShellState.shellRoot.backgroundColor.r,ShellState.shellRoot.backgroundColor.g,ShellState.shellRoot.backgroundColor.b,ShellState.shellRoot.foregroundColor.a)

	property color rectCurrent: Qt.rgba(ShellState.shellRoot.backgroundColor.r,ShellState.shellRoot.backgroundColor.g,ShellState.shellRoot.backgroundColor.b,ShellState.shellRoot.backgroundColor.a)
	property color rectNcurrent: Qt.rgba(ShellState.shellRoot.backgroundColor.r,ShellState.shellRoot.backgroundColor.g,ShellState.shellRoot.backgroundColor.b,ShellState.shellRoot.backgroundColor.a)

	radius: Math.max(4,ShellState.shellRoot.itemRadius/4)
	
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
				radius: ShellState.shellRoot.itemRadius

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
