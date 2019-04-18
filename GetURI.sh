#!/bin/bash

TOKEN_LOC="${HOME}/.bin/.token"
TOKEN=$(<$TOKEN_LOC)


uri=$(osascript -e 'tell application "Spotify" to spotify url of current track')
URL="https://slack.com/api/chat.postMessage?token="${TOKEN}"&channel=%23spotify-playlist&text="${uri}"&as_user=Patrick&pretty=1"
curl -s -d "payload=$json" $URL