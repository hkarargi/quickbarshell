import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Networking

Rectangle {
	width: childrenRect.width
	height: 30
	color: "#00000000"
	Rectangle { id: netRect; color: "#a0c7c4bf"; radius: 25; width:netText.width + 20 ;height: 30 }

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
	Text {
		property var netIcon: activessidSignal > 75 ? "󰤨" : activessidSignal > 50 ? "󰤥" : activessidSignal > 25 ? "󰤢" : activessidSignal > 0 ? "󰤟" : "󰤯"
		id: netText
		anchors.centerIn: netRect
		text: connected ? activessid + " " + activessidSignal + "% " + netIcon : "Disconnected 0% 󰤭"
		font.pointSize: 10
	}
	
}


