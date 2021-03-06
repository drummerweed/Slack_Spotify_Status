# Slack_Spotify_Status
First things first, props to the original script, with updates found here:
[Original Script](https://gist.github.com/jgamblin/9701ed50398d138c65ead316b5d11b26) by [jgamblin](https://gist.github.com/jgamblin)  
This is a script that will run in a Terminal or iTerm window.  
It will monitor your Spotify currently playing song and update your Slack status with it.

# Setup
**Required - Spotify**  
Create a file in your Home directory called `.slacktoken.cfg`
You need to get a Legacy Token from [here](https://api.slack.com/custom-integrations/legacy-tokens)  
This file needs to have the following text:
```
SLACK_TOKEN="Your Token Here"
```
This prevents your token from being in the same location as your script.  
One note that I recently discovered. The emoticon that is in the code has to match one that you have in your Slack instance. Otherwise it won't work. 

# Instalation
### Run the script manually
Download the bash file:
```sh
slack_status.sh
```
Run it and voila!

### Automator
**Required - iTerm2** unless you edit the file  
I wanted to have an app that loaded the bash file in iTerm2 and then launched Spotify.  
I have uploaded the Automator file, of which you can edit in order to run in Terminal if you wish.
```
Spotify-Script.app.zip
```
Download that, along with the `slack_status.sh` file.  
Make sure you have the config file set correctly.  
The app will attempt to open iTem, run the script, and then launch Spotify. 