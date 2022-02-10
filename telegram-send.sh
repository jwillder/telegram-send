#!/bin/bash

#
# Send telegram messages
#
# Usage: ./telegram-send.sh "<message>"
#

# Get the chat id and api token from the following files 
CHAT_ID=$(cat $(dirname $0)/chat_id.secret)
API_TOKEN=$(cat $(dirname $0)/api_token.secret)

# Check for a message
if [ -z "$1" ]
then
    echo "Add some message text after the command i.e. ./telegram-send.sh '<message>'"
    exit 1
fi

# Check only one argument is passed (triggered if the message was not in quotes for example)
if [ "$#" -ne 1 ]
then
    echo "Pass in one message only. If there are spaces put it in quotes."
    exit 1
fi

# Send the message
curl -s -X POST https://api.telegram.org/bot$API_TOKEN/sendMessage -d chat_id="$CHAT_ID" -d text="$1" > /dev/null