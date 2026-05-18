pragma Singleton

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick

Singleton {
	id: trayUtils
	function getTrayItems() {
		return SystemTray.items.values
	}


	function getTrayItemsExcluding(excluded) {
		return [...SystemTray.items.values.filter(function(x) { return !excluded.includes(x.title)})]
	}

	function getTrayItemsIncluding(included) {
		return [...SystemTray.items.values.filter(function(x) { return included.includes(x.title)})]
	}
}
