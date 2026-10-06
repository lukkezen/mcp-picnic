#!/bin/sh
set -eu

OPTIONS_FILE="/data/options.json"

get_option() {
    jq -r --arg key "$1" '.[$key] // empty' "$OPTIONS_FILE"
}

export PICNIC_USERNAME="$(get_option picnic_username)"
export PICNIC_PASSWORD="$(get_option picnic_password)"
export PICNIC_COUNTRY_CODE="$(get_option picnic_country_code)"
export CONTROL_PLANE_API_KEY="$(get_option openai_api_key)"
export CONTROL_PLANE_TUNNEL_ID="$(get_option tunnel_id)"

[ -n "$PICNIC_USERNAME" ] || { echo "ERROR: picnic_username is required."; exit 1; }
[ -n "$PICNIC_PASSWORD" ] || { echo "ERROR: picnic_password is required."; exit 1; }
[ -n "$CONTROL_PLANE_API_KEY" ] || { echo "ERROR: openai_api_key is required."; exit 1; }
[ -n "$CONTROL_PLANE_TUNNEL_ID" ] || { echo "ERROR: tunnel_id is required."; exit 1; }

export ENABLE_HTTP_SERVER="false"
export MCP_COMMAND="node /app/bin/mcp-server.js"

export PICNIC_SESSION_FILE="/data/picnic-session.json"
export PICNIC_DEVICE_FILE="/data/picnic-device.json"

export HEALTH_LISTEN_ADDR="0.0.0.0:8080"
export ALLOW_REMOTE_UI="true"
export LOG_LEVEL="info"
export LOG_FORMAT="struct-text"

exec /usr/bin/tunnel-client run
