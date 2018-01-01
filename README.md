# docker-slack-hubot

Dockerfile for building a containers to connect slack and hubot

## Usage
### build
- docker build -t arnold/slack-hubot .

### run
- docker run -it -e 'HUBOT_SHELLCMD_KEYWORD=run' -e 'HUBOT_SLACK_TOKEN=xoxb-123456780-xxxxx' arnold/slack-hubot
