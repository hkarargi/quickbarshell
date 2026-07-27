pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: networkUtils
	
	property string wifiDevice: ""
	property var ssids: []
	property string activessid: ""
	property int activessidSignal: 0
	property string connectivity: ""
	property string state: ""
	
	function connect(connect_ssid) {
		Quickshell.execDetached(["sh","-c","nmcli device wifi connect \""+connect_ssid+"\""])
	}

	function disconnect(dev) {
		Quickshell.execDetached(["sh","-c","nmcli device disconnect "+dev])
	}

	function rescan() {
		Quickshell.execDetached(["sh","-c","nmcli device wifi rescan"])
	}

	Process {
		id: nmProc
		running: true
		command: ["sh","-c","
		eval $(nmcli -f IN-USE,SIGNAL device wifi | awk '/^\*/{print \$2}' | tr -d 'SIGNAL\n' | awk '{print \"signal=\" $0}')
		
		eval $(nmcli device status | awk -F '[[:space:]]{2,}' '(\$2==\"wifi\"){print \"device=\\\"\"$1\"\\\"\";print \"connected=\\\"\"$3\"\\\"\";print \"ssid=\\\"\" $4 \"\\\"\"}')

		eval $(nmcli -t -f IN-USE,SIGNAL,SSID device wifi list | awk 'NR==1 {printf \"ssids=\\\"\"$0;next}{printf \"--\"$0}END{print \"\\\"\"}')

		eval $(nmcli networking connectivity check | awk '{print \"connectivity=\\\"\" $0 \"\\\"\"}')

		echo \"$signal    $connected    $ssid    $ssids    $device    $connectivity\"

		"]

		stdout: SplitParser {
			onRead: data => {

				var parts = data.split("    ")
				if (parts.length >= 6) {
					activessidSignal = parseInt(parts[0])
					state = parts[1].split(" ")[0]

					activessid = parts[2]

					var pssids = parts[3].split("--").map(item => item.split(":"))
					for (var i = 0; i < pssids.length;i++) {
						for (var j = i+1; j < pssids.length; j++) {
							if (pssids[i][2] == pssids[j][2])
								if(pssids[j][0] === "*") pssids.splice(i,1)
								else pssids.splice(j,1)
						}
					}

					ssids = pssids

					wifiDevice = parts[4]

					connectivity = parts[5]
				}

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
