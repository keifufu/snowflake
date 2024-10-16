#!/usr/bin/env bash

if [ $# -lt 1 ]; then
  echo "Usage: vpn.sh (connect|disconnect|server|status) [--waybar]"
  exit 1
fi

if [ -z "$XDG_CACHE_HOME" ]; then
  echo "Environment variable XDG_CACHE_HOME is missing"
  exit 1
fi

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

function connect_to_server() {
  piapath="$XDG_CACHE_HOME/.pia"
  if [[ ! -d "$piapath" ]]; then
    git clone https://github.com/pia-foss/manual-connections "$piapath"
  fi

  cd "$piapath"

  pia_credentials=$(cat "$SNOWFLAKE_SECRETS/pia_credentials")
  sudo $pia_credentials VPN_PROTOCOL=wireguard PREFERRED_REGION="$1" ./get_region.sh

  echo "$1" > "$SNOWFLAKE_SECRETS/.last_vpn_server"

  cd "$SCRIPT_PATH"
}

if [[ "$1" == "connect" ]]; then
  if [ -f "$SNOWFLAKE_SECRETS/.last_vpn_server" ]; then
    server=$(cat "$SNOWFLAKE_SECRETS/.last_vpn_server")
    connect_to_server "$server"
  else
    wg-quick up pia
  fi
elif [[ "$1" == "disconnect" ]]; then
  wg-quick down pia
elif [[ "$1" == "server" ]]; then
  if [ $# -lt 2 ]; then
    echo "Usage: vpn.sh server (NAME)"
    echo "Server list: https://serverlist.piaservers.net/vpninfo/servers/v6"
    exit 1
  fi

  connect_to_server "$2"
elif [[ "$1" == "status" ]]; then
  if [[ "$2" == "--waybar" ]]; then
    res=$(sudo wg show pia)
    server=$(cat "$SNOWFLAKE_SECRETS/.last_vpn_server")
    if [[ "$res" =~ "latest handshake" ]]; then
      icon=""
      class="on"
      status="Connected to $server"
    else
      icon=""
      class="off"
      status="Disconnected from $server"
    fi
    printf '{"text": "%s", "class": "%s", "tooltip": "%s"}\n' "$icon" "$class" "$status"
  else
    sudo wg show pia
  fi
else
  echo "Usage: vpn.sh (connect|disconnect|status) [--waybar]"
  exit 1
fi