#! /bin/bash

if [ -d "$HOME/.config/quickshell" ]; then
	mkdir $HOME/.config/quickshell/old
	mv $HOME/.config/quickshell/* $HOME/.config/quickshell/old
else
	mkdir  $HOME/.config/quickshell
fi
if [ -d ./files ]; then
	cp ./files/* $HOME/.config/quickshell -r
else
	git clone https://github.com/hkarargi/quickbarshell/
	cp ./quickbarshell/files/* $HOME/.config/quickshell/ -r
fi

rm -rf ./quickbarshell
pkill quickshell;quickshell &

