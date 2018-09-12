#! /bin/sh -
#
# List of all endpoints from the Discord API
# https://discordapp.com/developers/docs/intro


# discord guild-channel create|read|update(sorting) --guild="..."
DISCORDSH_API_ENDPOINT_GUILD_CHANNEL=

# discord guild-member create|read|update|delete --guild="..." --user="..."
DISCORDSH_API_ENDPOINT_GUILD_MEMBER="/guilds/{guild.id}/members/{user.id}"

# discord guild-members read --guild="..."
DISCORDSH_API_ENDPOINT_GUILD_MEMBERS="/guilds/{guild.id}/members"

# discord guild-nick update --guild="..."
DISCORDSH_API_ENDPOINT_GUILD_NICK="/guilds/{guild.id}/members/@me/nick"

# discord guild-member-role create|read|
DISCORDSH_API_ENDPOINT_GUILD_MEMBER_ROLE="/guilds/{guild.id}/members/{user.id}/roles/{role.id}"
DISCORDSH_API_ENDPOINT_GUILD_BAN="/guilds/{guild.id}/bans/{user.id}"
DISCORDSH_API_ENDPOINT_GUILD_BANS="/guilds/{guild.id}/bans"
DISCORDSH_API_ENDPOINT_GUILD_ROLE="/guilds/{guild.id}/roles/{role.id}"
DISCORDSH_API_ENDPOINT_GUILD_ROLES="/guilds/{guild.id}/roles"
DISCORDSH_API_ENDPOINT_GUILD_PRUNE="/guilds/{guild.id}/prune"
DISCORDSH_API_ENDPOINT_GUILD_REGIONS="/guilds/{guils.id}/regions"
DISCORDSH_API_ENDPOINT_GUILD_INVITES="/guilds/{guils.id}/invites"
DISCORDSH_API_ENDPOINT_GUILD_INTEGRATION="/guilds/{guild.id}/integrations/{integration.id}"
DISCORDSH_API_ENDPOINT_GUILD_INTEGRATIONS="/guilds/{guild.id}/integrations"
DISCORDSH_API_ENDPOINT_GUILD_INTEGRATION_SYNC="/guilds/{guild.id}/integrations/{integration.id}/sync"
DISCORDSH_API_ENDPOINT_GUILD_EMBED="/guilds/{guild.id}/embed"
DISCORDSH_API_ENDPOINT_GUILD_VANITY_URL="/guilds/{guild.id}/vanity-url"

DISCORDSH_API_ENDPOINT_EMOJI="/guilds/{guild.id}/emojis/{emoji.id}"
DISCORDSH_API_ENDPOINT_EMOJIS="/guilds/{guild.id}/emojis"

DISCORDSH_API_ENDPOINT_CHANNEL="/channels/{channel.id}"
DISCORDSH_API_ENDPOINT_CHANNEL_REACTIONS="/channels/{channel.id}/messages/{message.id}/reactions"
DISCORDSH_API_ENDPOINT_CHANNEL_REACTIONS_EMOJI="/channels/{channel.id}/messages/{message.id}/reactions/{emoji}"
DISCORDSH_API_ENDPOINT_CHANNEL_MESSAGES="/channels/{channel.id}/messages"
DISCORDSH_API_ENDPOINT_CHANNEL_MESSAGES_BULK_DELETE="/channels/{channel.id}/messages/bulk-delete"
DISCORDSH_API_ENDPOINT_CHANNEL_MESSAGE="/channels/{channel.id}/messages/{message.id}"
DISCORDSH_API_ENDPOINT_CHANNEL_MESSAGE_REACTION_USER="/channels/{channel.id}/messages/{message.id}/reactions/{emoji}/{user.id}"
DISCORDSH_API_ENDPOINT_CHANNEL_MESSAGE_REACTION_ME="/channels/{channel.id}/messages/{message.id}/reactions/{emoji}/@me"
DISCORDSH_API_ENDPOINT_CHANNEL_PERMISSIONS="/channels/{channel.id}/permissions/{overwrite.id}"
DISCORDSH_API_ENDPOINT_CHANNEL_INVITES="/channels/{channel.id}/invites"
DISCORDSH_API_ENDPOINT_CHANNEL_TYPING="/channels/{channel.id}/typing"
DISCORDSH_API_ENDPOINT_CHANNEL_MESSAGES_PINNED="/channels/{channel.id}/pins"
DISCORDSH_API_ENDPOINT_CHANNEL_MESSAGE_PINNED="/channels/{channel.id}/pins/{message.id}"
DISCORDSH_API_ENDPOINT_CHANNEL_DM_RECIPIENTS="/channels/{channel.id}/recipients/{user.id}"

DISCORDSH_API_ENDPOINT_AUDIT_LOG="/guilds/{guild.id}/audit-logs"

DISCORDSH_API_ENDPOINT_INVITE="/invites/{invite.code}"

DISCORDSH_API_ENDPOINT_USER="/users/{user.id}"

DISCORDSH_API_ENDPOINT_ME="/users/@me"
DISCORDSH_API_ENDPOINT_ME_GUILDS="/users/@me/guilds"
DISCORDSH_API_ENDPOINT_ME_GUILD_LEAVE="/users/@me/guilds/{guild.id}"
DISCORDSH_API_ENDPOINT_ME_DM="/users/@me/channels"
DISCORDSH_API_ENDPOINT_ME_CONNECTIONS="/users/@me/connections"

DISCORDSH_API_ENDPOINT_WEBHOOKS="/channels/{channel.id}/webhooks"

DISCORDSH_API_ENDPOINT_WEBHOOK="/webhooks/{webhook.id}"
DISCORDSH_API_ENDPOINT_WEBHOOK_WITH_TOKEN="/webhooks/{webhook.id}/{webhook.token}"

DISCORDSH_API_ENDPOINT_WEBHOOK_SLACK="/webhooks/{webhook.id}/{webhook.token}/slack"
DISCORDSH_API_ENDPOINT_WEBHOOK_GITHUB="/webhooks/{webhook.id}/{webhook.token}/github"


replace_tokens() {
    log_debug "Calling replace_tokens..."

    path="$1"
    if echo $path | grep -q "{guild.id}"
    then
        log_debug "Replacing guild tag..."
        validate_opts_guild
        path="$(echo "$path" | sed "s/{guild.id}/$OPTS_GUILD/")"
        log_debug "Path updated \"$path\""
    fi

    if echo $path | grep -q "{channel.id}"
    then
        log_debug "Replacing channel tag..."
        validate_opts_channel
        path="$(echo "$path" | sed "s/{channel.id}/$OPTS_CHANNEL/")"
        log_debug "Path updated \"$path\""
    fi

    if echo $path | grep -q "{user.id}"
    then
        log_debug "Replacing user tag..."
        validate_opts_user
        path="$(echo "$path" | sed "s/{user.id}/$OPTS_USER/")"
        log_debug "Path updated \"$path\""
    fi

    if echo $path | grep -q "{message.id}"
    then
        log_debug "Replacing message tag..."
        validate_opts_user
        path="$(echo "$path" | sed "s/{message.id}/$OPTS_MESSAGE/")"
        log_debug "Path updated \"$path\""
    fi

    if echo $path | grep -q "{webhook.id}"
    then
        log_debug "Replacing webhook tag..."
        validate_opts_webhook
        path="$(echo "$path" | sed "s/{webhook.id}/$OPTS_WEBHOOK/")"
        log_debug "Path updated \"$path\""
    fi

    if echo $path | grep -q "{integration.id}"
    then
        log_debug "Replacing integration tag..."
        validate_opts_integration
        path="$(echo "$path" | sed "s/{integration.id}/$OPTS_INTEGRATION/")"
        log_debug "Path updated \"$path\""
    fi

    if echo $path | grep -q "{emoji}"
    then
        log_debug "Replacing emoji tag..."
        validate_opts_emoji
        path="$(echo "$path" | sed "s/{emoji}/$OPTS_EMOJI/")"
        log_debug "Path updated \"$path\""
    fi

    echo $path
}

