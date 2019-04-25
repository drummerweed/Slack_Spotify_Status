#!/bin/bash

TOKEN_LOC="${HOME}/.bin/.token"
TOKEN=$(<$TOKEN_LOC)


uri=$(osascript -e 'tell application "Spotify" to spotify url of current track')
channel="music"
URL="https://slack.com/api/chat.postMessage?token="${TOKEN}"&channel="${channel}"&text="${uri}"&as_user=patrick_weed&pretty=1"
curl -s -d "payload=$json" $URL

# webhook_url="Your Webhook URL Here"
# channel="Slackbot"

# escapedText=$(echo $text | sed 's/"/\"/g' | sed "s/'/\'/g" )
# json="{\"channel\": \"$channel\", \"text\": \"$escapedText\"}"

# curl -s -d "payload=$json" "$webhook_url"