#!/bin/bash

USER_CONFIG_DEFAULTS="SLACK_TOKEN=\"\"\n";
USER_CONFIG_FILE="${HOME}/.slacktoken.cfg";
if ! [[ -f "${USER_CONFIG_FILE}" ]]; then
    touch "${USER_CONFIG_FILE}";
    echo -e "${USER_CONFIG_DEFAULTS}" > "${USER_CONFIG_FILE}";
fi
source "${USER_CONFIG_FILE}";
APIKEY=$SLACK_TOKEN

trap onexit INT

function reset() {
    echo 'Resetting status'
    curl -s -d "payload=$json" "https://slack.com/api/users.profile.set?token="$APIKEY"&profile=%7B%22status_text%22%3A%22%20Hello%22%2C%22status_emoji%22%3A%22%3Asmile%3A%22%7D" > /dev/null
}

function onexit() {
    echo 'Exitting'
    reset
    exit
}

check_song=''
if_paused=1

while true; do
    state=$(osascript -e 'tell application "Spotify" to player state')
    SONG=$(osascript -e 'tell application "Spotify" to artist of current track & " - " & name of current track')

    if [ "$state" == "playing" ]; then
        while [ "$if_playing" = 1 ]; do
            echo "Spotify: "$state" - "$SONG
            echo "Same song playing, will not update Slack Status"
            if_playing=$[$if_playing +1]
        done
    fi

    if [ "$state" == "stopped" ]; then
        reset
    elif [ "$state" == "paused" ]; then
        if [ "$if_paused" = 1 ]; then
            echo "Spotify: "$state
            curl -s -d "payload=$json" "https://slack.com/api/users.profile.set?token="$APIKEY"&profile=%7B%22status_text%22%3A%22%20Spotify%20Paused%22%2C%22status_emoji%22%3A%22%3Aheadphones%3A%22%7D" > /dev/null
            if_paused=$[$if_paused +1]
        fi
    elif [ "$check_song" != "$SONG" ]; then
        date
        echo "Spotify: "$state
        URLSONG=$(echo "$SONG" | perl -MURI::Escape -ne 'chomp;print uri_escape($_),"\n"')
        echo $SONG
        curl -s -d "payload=$json" "https://slack.com/api/users.profile.set?token="$APIKEY"&profile=%7B%22status_text%22%3A%22"$URLSONG"%20on%20Spotify%22%2C%22status_emoji%22%3A%22%3Aheadphones%3A%22%7D"  > /dev/null
        check_song=$SONG
        if_paused=1
    fi

    sleep 3
done