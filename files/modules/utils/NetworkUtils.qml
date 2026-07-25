pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: networkUtils
	property list<string> ssids: []
	property string activessid: ""
	property int activessidSignal: 0
	property bool connected: false
	
	

	Process {
		id: ssidsGet
		command: ["sh", "-c", "nmcli -t -f SSID device wifi list"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return
        			ssids = data.split('\n')
			}
		}
		running: true
	}
	

	Process {
		id: nmProc
		running: true
		command: ["sh","-c","
		eval $(nmcli -f IN-USE,SIGNAL device wifi | awk '/^\*/{print \$2}' | tr -d 'SIGNAL\n' | awk '{print \"signal=\" $0}')
		
		eval $(nmcli device status | awk -F '[[:space:]]{2,}' '(\$2==\"wifi\"){print \"connected=\"$3;print \"ssid=\\\"\" $4 \"\\\"\"}')

		echo \"$signal    $connected    $ssid\"

		"]

		stdout: SplitParser {
			onRead: data => {
				var parts = data.split("    ")
				activessidSignal = parts[0]
				connected = parts[1]=="connected"
				activessid = parts[2]
			}
		}
	}

	Process {
		id: nmcliMonitor
		running: true
		command: ["sh","-c","nmcli monitor"]
		stdout: SplitParser {
			onRead: { nmProc.running = true }
		}
	}
}
