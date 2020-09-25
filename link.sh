#!/usr/bin/env sh
cd "$(dirname "$0")" || exit

if [ -z "$1" ]; then
    live_install="$HOME/.steam/steam/steamapps/common/Team Fortress 2/"
else
	live_install="$1"
fi

if [ ! -d "$live_install" ]; then
    echo Failed to find TF2 at \'"$live_install"\'
    echo Did you move your steam library?
    echo If so, put the path to your TF2 folder after \'link.sh\'
    exit 1
fi

link_dir() {
	ln -s "$live_install/$1" "../game/$1"
}

link_glob() {
	ln -s "$live_install/$1/"*".$2" "../game/$1/"
}

link_dir hl2
link_dir platform
link_dir tf/maps
mkdir ../game/tf/materials
link_dir tf/materials/models
link_dir tf/materials/vgui
link_dir tf/media
link_dir tf/resource
link_dir tf/scripts

link_glob bin 'so'
link_glob tf 'vpk'

cp -r "$live_install/tf/cfg" "../game/tf/cfg"
cp "$live_install/tf/gameinfo.txt" "../game/tf/"

cp game_clean/copy/bin/*.so ../game/bin/
cp -r game_clean/copy/tf/custom/ ../game/tf/custom
