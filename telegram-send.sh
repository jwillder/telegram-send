#!/bin/bash

#
# Send telegram messages
#
# Usage: ./telegram-send.sh "<message>"
#

# CHECK: curl is installed
if [ ! command -v curl &> /dev/null ]
then
  echo "curl could not be found"
  exit 1
fi

# CHECK: jq is installed
if [ ! command -v jq &> /dev/null ]
then
  echo "jq could not be found"
  exit 1
fi

# GET: API token from this directory or /opt/telegram-send
if [[ -e "$(dirname $0)/test/api_token.secret" ]]
then
  API_TOKEN="$(cat $(dirname $0)/test/api_token.secret)"
else
  if [[ -e "/opt/telegram-send/api_token.secret" ]]
  then
    API_TOKEN="$(cat /opt/telegram-send/api_token.secret)"
  else
    echo "Cannot find api_token.secret"
    exit 1
  fi
fi

# GET: Chat ID from this directory or /opt/telegram-send
if [[ -e "$(dirname $0)/test/chat_id.secret" ]]
then
  CHAT_ID="$(cat $(dirname $0)/test/chat_id.secret)"
else
  if [[ -e "/opt/telegram-send/chat_id.secret" ]]
  then
    CHAT_ID="$(cat /opt/telegram-send/chat_id.secret)"
  else
    echo "Cannot find chat_id.secret"
    exit 1
  fi
fi

# CHECK: for a message
if [ -z "$1" ]
then
    echo "Add some message text after the command i.e. ./telegram-send.sh '<message>'"
    exit 1
fi

# CHECK: only one argument is passed (triggered if the message was not in quotes for example)
if [ "$#" -ne 1 ]
then
    echo "Pass in one message only. If there are spaces put it in quotes."
    exit 1
fi

# Send the message
SEND="$(curl -s -X POST https://api.telegram.org/bot$API_TOKEN/sendMessage -d chat_id="$CHAT_ID" -d text="$1")"
if [[ $(echo $SEND | jq '.ok') != "true" ]]
then
  echo "The message failed to send."
  echo $SEND
  exit 1
fi