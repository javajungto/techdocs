#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 youtube_url"
  exit 1
fi

echo "url: $1"

# download video using yt-dlp
#downloadFile=$(yt-dlp $1 | grep Destination | sed 's/.*Destination: \(.*\)/\1/')
#downloadFile=$(yt-dlp $1 | grep Destination | sed 's/.*Destination: \(.*\)/\1/')
downloadFile=$(yt-dlp $1 | grep Merging | sed 's/.*into "\(.*\)/\1/' | tr -d '"')

echo "1. downloaded ... : ${downloadFile}"

# convert webm to mp3 using ffmpeg
ffmpeg -i "$downloadFile" -b:a 320K "${downloadFile}.mp3"

# remove original webm file
rm -rf "$downloadFile"
