FROM node:latest

MAINTAINER arnold

USER root

RUN apt-get -q update && \
    apt-get -qy upgrade && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /home/slack && \
    groupadd -r slack -g 433 && \
    useradd -u 431 -r -g slack -d /home/slack -s /sbin/nologin -c "Docker image user" slack && \
    chown -R slack:slack /home/slack && \
    npm install -g yo generator-hubot hubot coffee-script hubot-slack

USER slack
WORKDIR /home/slack

RUN mkdir myhubot && \
    cd myhubot && \
    yo hubot --owner="your name <name@example.com>" --name="hubot-example" --description="A simple helpful robot for your Company" --adapter="slack" && \
    npm install hubot-script-shellcmd && \
    cp -R node_modules/hubot-script-shellcmd/bash ./

WORKDIR ./myhubot
COPY external-scripts.json ./external-scripts.json
COPY bash/handlers/* ./bash/handlers/

USER root
RUN chown slack:slack ./external-scripts.json && \
    chown slack:slack ./bash/handlers/*

ENV PORT 9009
EXPOSE 9009

CMD ./bin/hubot --adapter slack
