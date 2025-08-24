#!/bin/bash

# Monitor Hyprland events
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
  while read -r event; do
    # Only react to workspace changes or window open/close
    if [[ "$event" =~ "workspace" || "$event" =~ "openwindow" || "$event" =~ "closewindow" ]]; then
      # Check if current workspace has windows
      ws=$(hyprctl activeworkspace -j | jq '.id')
      windows=$(hyprctl clients -j | jq --argjson ws "$ws" '[.[] | select(.workspace.id == $ws)] | length')

      if [ "$windows" -eq 0 ]; then
        pkill -SIGUSR1 waybar # hide
      else
        pkill -SIGUSR2 waybar # show
      fi
    fi
  done
