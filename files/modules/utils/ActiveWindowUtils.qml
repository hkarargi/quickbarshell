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
		command: ["sh", "-c", "hyprctl activewindow | awk 'NR==12{$1=\"\";$0=$0;$1=$1;print}{printf \"\"}'"]
		running: true

		stdout: SplitParser {
			onRead: data => {
				activeWindowTitle = data
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
