#!/bin/bash

###############################################################################################
# To automatically download a bunch of youtube playlists using the awesome "youtube-dl" program
# For Simpliciy, it downloads only one playlist then terminates.
# Feel free to automate this snippet.

# by @0xOFFSET

#save both the name & link of the playlist in the file below
# NOTE! "Please, don't use whitespaces or special characters for naming your playlist."
videos_file="to_be_downloaded_list.csv"

#parse the first line (FIFO), depending on "," as a delimiter without whitespaces
IFS=, ; read -r name link <<< $(head -1 $videos_file)

#trim whitespaces
name=$(sed -e 's/^[[:space:]]*//' <<< $name | tr -s ' ' '_' )
# link=$(sed -e 's/^[[:space:]]*//' <<< $link)

# check variables
if [ -z $name ] || [ -z $link ]; then
	echo "Exiting"
	exit
fi

#delete the first parsed line
tail -n +2 $videos_file > $videos_file

#create a new directory for the current playlist
if [ ! -d $name ]; then
	mkdir $name
fi
cd $name

#first, check if "youtube-dl" exists
if which youtube-ddl &> /dev/null; then
	echo "[+] (youtube-dl) exists"
else
	echo "[+] can't find (youtube-dl)"
	echo "[*] Downloading & installing it, ROOT permission is required !"
	sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
	sudo chmod a+rx /usr/local/bin/youtube-dl
fi
#start downloading
# NOTES:
# download & install (youtube-dl) from https://youtube-dl.org/
# pass your desired and avialable resolution quality code ( "-f 22" in my case, normally it's 720p)
# see ($man youtube-dl) from details

echo "Downloading $name"
echo "Link: $link"
youtube-dl --write-auto-sub --yes-playlist -o "%(title)s.%(ext)s" -f 22 $link

