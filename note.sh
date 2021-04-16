#!/bin/bash

NOTES_DIR="/home/$USER/Dropbox/Notes"

#----------------------------------------------------------#

# Comment the section below if it's not your first run!

#check text editor
if [ -z `which sublime-text.subl` ]; then
    echo "Sublime not installed!"
    echo "Run: sudo snap install sublim-text --classic"
    exit
fi

# check dropbox
if [ -z `which dropbox` ]; then
    echo "Dropbox doesn't exist!"
    echo "Please, install it first, and create Notes directory inside Dropbox dir."
fi

# check directory where to save note files
if ! [ -d $NOTES_DIR ]; then
    mkdir $NOTES_DIR
fi

#----------------------------------------------------------#

if [ -d $NOTES_DIR ]; then
    # if filename doesn't exist, name it by current date/time
	if [ -z "$1" ]; then
        note_file="$NOTES_DIR/$(date +"%Y_%m_%d_%A_%H:%M:%S").note"
    else
        note_file="$NOTES_DIR/$1.note"
    fi
    
    # check for direct input to the file
    if [ -z "$2" ]; then
        touch $note_file
    else
        echo $2 > $note_file            
    fi
    
    # open the note with text editor
	sublime-text.subl $note_file 
fi
