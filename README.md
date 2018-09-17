```
      _ _                       _       _
     | (_)                     | |     | |
   __| |_ ___  ___ ___  _ __ __| |  ___| |__
  /  ` | / __|/ __/   \| '__/  ` |_/ __| '_ \
 |  X  | \__ \ (_|  X  | | |  X  |_\__ \ | | |
  \__,_|_|___/\___\___/|_|  \__,_| |___/_| |_|
  ```

Shell script for integrating with the discord API.

This script supports the full REST API documented at <https://discordapp.com/developers/docs/intro>.

> **STILL IN BETA**
>
> This script is still in beta while I test the exposed interface more thoroughly. Feel free to use it and provide feedback or open pull requests for any issues you run into. Just be warned that the interface and command line options can change at any point. I will release a 1.0.0 release when I am more confident in the interface at which point I will start to maintain proper backwards compatibility.

## Installation

```sh
# Download the script somewhere on your shell's search path. Note that you may need to add ~/bin/ to your $PATH
curl -Lo ~/bin/discord --create-dirs "https://raw.githubusercontent.com/ryakad/discord-sh/master/bin/discord"
chmod +x ~/bin/discord

# Export your authentication token
export DISCORDSH_API_TOKEN="Bot ....."
```

## Usage

the `discord` command will read from stdin and call the specified endpoint with the provided json data.

```sh
cat 'data.json' | discord [endpoint] [options]
```

### `[options]`

| Option | Description |
| --- | --- |
| `-h` `--help` `help` | Display help message |
| `-v` `--version` `version` | Display the version |
| `-g` | Guild ID for urls that require a value for `{guild.id}` |
| `-u` | User ID for urls that require a value for `{user.id}` |
| `-c` | Channel ID for urls that require a value for `{channel.id}` |
| `-m` | Message ID for urls that require a value for `{message.id}` |
| `-p` | Permission Overwrite ID for urls that require a value for `{overwrite.id}` |
| `-w` | Webhook ID for urls that require a value for `{webhook.id}` |
| `-t` | Webhook token for urls that require a value for `{webhook.token}` |
| `-i` | Integration ID for urls that require a value for `{integration.id}` |
| `-e` | Emoji for urls that require a value for `{emoji}` |

### `[endpoint]`

Supported values for `endpoint`. The formatting for the names is meant to match the API documentation after replacing all spaces with hyphens and converting to lowercase.

As an example the [Create Message](https://discordapp.com/developers/docs/resources/channel#create-message) API call is accessed by setting endpoint to `create-message`.

For information on what data structures the endpoints accept you can read through the [Discord API Documentation](https://discordapp.com/developers/docs/reference) for the appropriate endpoint.

* `get-guild-audit-log`
* `get-channel`
* `modify-channel`
* `delete-channel'|'close-channel`
* `get-channel-messages`
* `get-channel-message`
* `create-message`
* `create-reaction`
* `delete-own-reaction`
* `delete-user-reaction`
* `get-reactions`
* `delete-all-reactions`
* `edit-message`
* `delete-message`
* `bulk-delete-messages`
* `edit-channel-permissions`
* `get-channel-invites`
* `create-channel-invite`
* `delete-channel-permission`
* `trigger-typing-indicator`
* `get-pinned-messages`
* `add-pinned-channel-message`
* `delete-pinned-channel-message`
* `group-dm-add-recipient`
* `group-dm-remove-recipient`
* `list-guild-emojis`
* `get-guild-emoji`
* `create-guild-emoji`
* `modify-guild-emoji`
* `delete-guild-emoji`
* `create-guild`
* `get-guild`
* `modify-guild`
* `delete-guild`
* `get-guild-channels`
* `create-guild-channel`
* `modify-guild-channel-positions`
* `get-guild-member`
* `list-guild-members`
* `add-guild-member`
* `modify-guild-member`
* `modify-current-user-nick`
* `add-guild-member-role`
* `remove-guild-member-role`
* `remove-guild-member`
* `get-guild-bans`
* `get-guild-ban`
* `create-guild-ban`
* `remove-guild-ban`
* `get-guild-roles`
* `create-guild-role`
* `modify-guild-role-positions`
* `modify-guild-role`
* `delete-guild-role`
* `get-guild-prune-count`
* `begin-guild-prune`
* `get-guild-voice-regions`
* `get-guild-invites`
* `get-guild-integrations`
* `create-guild-integration`
* `modify-guild-integration`
* `delete-guild-integration`
* `sync-guild-integration`
* `get-guild-embed`
* `modify-guild-embed`
* `get-guild-vanity-url`
* `get-invite`
* `delete-invite`
* `get-current-user`
* `get-user`
* `modify-current-user`
* `get-current-user-guilds`
* `leave-guild`
* `get-user-dms`
* `create-dm`
* `create-group-dm`
* `get-user-connections`
* `list-voice-regions`
* `create-webhook`
* `get-channel-webhooks`
* `get-guild-webhooks`
* `get-webhook`
* `get-webhook-with-token`
* `modify-webhook`
* `modify-webhook-with-token`
* `delete-webhook`
* `delete-webhook-with-token`
* `execute-webhook`
* `execute-slack-compatible-webhook`
* `execute-github-compatible-webhook`

## Examples

```sh
# Create a #testing channel in guild (Guild ID: 000000000000000000)
echo '{ "name": "testing" }' | discord create-guild-channel -g 000000000000000000
# send a message to the #testing channel
echo '{ "content": "Testing Message" }' | discord create-message -c 000000000000000000
# Delete the #testing channel
discord delete-channel -c 000000000000000000
```

## Using with Docker

There is a Docker image available on DockerHub at [ryakad/discord-sh](https://hub.docker.com/r/ryakad/discord-sh/). To use the image simply pull it and run the commands within the container like:

```
docker run --rm -e DISCORDSH_API_TOKEN -it ryakad/discord-sh:0.0.0 discord version
```
