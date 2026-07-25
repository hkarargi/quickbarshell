import Quickshell
import QtQuick

import "templates"
import "utils"

Symbol {
	function wheel(angleDelta) {
		AudioUtils.changeMicVolumeByPercent(Math.sign(angleDelta.y))
	}

	icons: ["󰍮","󰍬"]
	altIcon: "󰍭"

	number: AudioUtils.micMuted ? 0 : AudioUtils.micVolume
	useAlt: AudioUtils.micMuted
}
