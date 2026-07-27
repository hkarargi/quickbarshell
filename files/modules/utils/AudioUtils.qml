pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

Singleton {
	id: audioUtils

	readonly property PwNode sink: Pipewire.defaultAudioSink
	readonly property PwNode source: Pipewire.defaultAudioSource

	readonly property bool speakerMuted: !!sink?.audio?.muted
	readonly property bool micMuted: !!source?.audio?.muted
	
	readonly property real speakerVolume: (sink?.audio?.volume ?? 0) * 100
	readonly property real micVolume: (source?.audio?.volume ?? 0) * 100

	PwObjectTracker { objects: [audioUtils.sink, audioUtils.source]}

	function changeSpeakerVolumeByPercent(amount) {
		if (sink?.ready && sink?.audio) {
			sink.audio.muted = false;
			sink.audio.volume = (Math.min(Math.max(speakerVolume+amount,0),100))*0.01
		}
	}

	function changeMicVolumeByPercent(amount) {
		if (source?.ready && source?.audio) {
			source.audio.muted = false;
			source.audio.volume = (Math.min(Math.max(micVolume+amount,0),100))*0.01
		}
	}
}
