# Telegram-send

A convenient script to send a Telegram message from the command line. You could call this from other scripts to notify you of events or problems on a system.

## Setup

If you haven't already done so you will need to create a bot and channel on Telegram.

### Create Bot (provides API Token)

On Telegram start a chat with `@BotFather`.

Send the message `\newbot` and follow the on-screen instructions.

Make a note of the name you give the bot e.g. `@my_name_bot`

You will get an API token looking something like `123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11`.

Save this API token into the `api_token.secret.sample` file here, then rename the file to `api_token.secret`

### Create Channel (provides Chat ID)

Once the bot is created send it a message through the Telegram app to start a channel.

- Start a message to your bot `@my_name_bot`
- Send the message `\start`
- Then send another message like `Hello bot`

You can now find the channel ID use the following `curl` command substituting in the API token generated above.

```
curl https://api.telegram.org/bot<API_TOKEN>/getUpdates
```

You should get a JSON response that contains, for example, `"chat": {"id":-1231231231,`, this is the number you want.

Save this chat ID into the `chat_id.secret.sample` file here, then rename the file to `chat_id.secret`

Note: if you get an empty JSON result, simply send another message to the channel and run the curl command again.

### Permissions

Set the permissions on the `.secret` files so only you can read/write them:

```
chmod 600 api_token.secret chat_id.secret
```

Set the permission on the script so only you can read/write/execute it:

```
chmod 700 telegram-send.sh
```

## Usage

To send a message just run the script with a message in quotes e.g.:

```
./telegram-send.sh "Hello from bot"
```