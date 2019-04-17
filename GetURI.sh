#!/bin/bash

USER_CONFIG_DEFAULTS="SLACK_TOKEN=\"\"\n";
USER_CONFIG_FILE="${HOME}/.slacktoken.cfg";
if ! [[ -f "${USER_CONFIG_FILE}" ]]; then
    touch "${USER_CONFIG_FILE}";
    echo -e "${USER_CONFIG_DEFAULTS}" > "${USER_CONFIG_FILE}";
fi
source "${USER_CONFIG_FILE}";
APIKEY=$SLACK_TOKEN

uri=$(osascript -e 'tell application "Spotify" to spotify url of current track')
json="{\"text\": \"$uri\"}"
curl -s -d "payload=$json" $webhook
