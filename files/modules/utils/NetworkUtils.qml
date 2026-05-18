import QtQuick
import Quickshell
import Quickshell.Io

Item {
	id: networkUtils
	property var ssids: []
	property var activessid: ""
	property var activessidSignal: ""
	property var connected: false
	Process {
		id: ssidsGet
		command: ["sh", "-c", "nmcli -t -f SSID device wifi list | tr '\n' '.'"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return
        			ssids = data.split('.')
			}
		}
		Component.onCompleted: running = true
	}

	Process {
		id: activessidGet
		command: ["sh", "-c", "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return
        			activessid = data
			}
		}
		Component.onCompleted: running = true
	}

	Process {
		id: activessidSignalGet
		command: ["sh", "-c", "nmcli -f IN-USE,SIGNAL device wifi | awk '/^\*/{print \$2}' | tr -d 'SIGNAL\n'"]
		stdout: SplitParser {
			onRead: data => {
				if (data == "") return
        			activessidSignal = parseInt(data)
			}
		}
		Component.onCompleted: running = true
	}

	Process {
		id: connectedGet
		command: ["sh", "-c", "nmcli -f TYPE,STATE device status | awk '/wifi / {print \$2}'"]
		stdout: SplitParser {
			onRead: data => {
				if (data == "") return
				connected = data == "connected" ? true : false
			}
		}
		Component.onCompleted: running = true
	}

	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: {
			activessidGet.running = true
			activessidSignalGet.running = true
			ssidsGet.running = true
			connectedGet.running = true
		}
	}
}
