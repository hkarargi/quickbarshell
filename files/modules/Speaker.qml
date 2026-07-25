import Quickshell
import QtQuick
import Quickshell.Services.Pipewire

import "templates"
import "utils"

Symbol {
	function wheel(angleDelta) {
		AudioUtils.changeSpeakerVolumeByPercent(Math.sign(angleDelta.y))
	}

	icons: ["", "", ""]
	altIcon: ""

	number: AudioUtils.speakerMuted ? 0 : AudioUtils.speakerVolume
	useAlt: AudioUtils.speakerMuted
}
