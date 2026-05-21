import QtQuick
import Quickshell

import "utils" as Utils

Utils.TextIconModule {
	Utils.CPUUtils { id: cpuUtils }

	number: cpuUtils.memUsagePercent
	icons: [""]
}
