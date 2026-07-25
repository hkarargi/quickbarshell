pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Singleton {
	id: activeWorkspaceUtils

	property string activeWindowTitle: ""

	Process {
		id: getTitle
		command: ["sh", "-c", "hyprctl activewindow | grep title: | sed 's/^[^:]*: //'"]
		running: true

		stdout: SplitParser {
			onRead: data => {
				if (data != "") { activeWindowTitle = data }
			}
		}
	}

	Component.onCompleted: {
		Hyprland.rawEvent.connect(hyprEvent)
	}

	function hyprEvent(event) {
		if (!getTitle.running) {
			getTitle.running = true
		}
	}
}
