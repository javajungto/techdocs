#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 youtube_url"
  exit 1
fi

# download video using yt-dlp
downloadFile=$(yt-dlp "$1" | grep Merging | sed 's/.*"\(.*\.webm\)".*/\1/')

# convert webm to mp3 using ffmpeg
ffmpeg -i "$downloadFile" -b:a 320K "${downloadFile%.webm}.mp3"

# remove original webm file
rm "$downloadFile"
