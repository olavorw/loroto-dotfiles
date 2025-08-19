#!/bin/bash

# --- CONFIGURATION ---
# Directory where your wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/wallpapers/Static-Wallpapers"

# The name of the theme you created in oomox-gui
#THEME_NAME="arc-dark"

# The transition effect for swww
TRANSITION_TYPE="wipe"
# --- END OF CONFIGURATION ---


echo "--- Starting Theme Update ---"

# 1. Select and set a new wallpaper
WALLPAPER_PATH=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
echo "Wallpaper: $WALLPAPER_PATH"
swww query || swww init
swww img "$WALLPAPER_PATH" --transition-type $TRANSITION_TYPE

# 2. Generate all color cache files with pywal
echo "Running pywal..."
wal -q -i "$WALLPAPER_PATH"

# 3. Rebuild the GTK theme using the dedicated colors-oomox file
# This is your excellent suggestion and the most correct method.
#echo "Rebuilding GTK theme with oomox..."
#oomox-cli "$HOME/.cache/wal/colors-oomox" -o "$THEME_NAME"

# 4. Apply the newly generated GTK theme
#echo "Applying GTK theme..."
#gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
#echo "include \"$HOME/.themes/$THEME_NAME/gtk-3.20/gtkrc\"" > "$HOME/.gtkrc-3.20"

# 5. Reload other desktop components
echo "Reloading Hyprland and Waybar..."
hyprctl reload
killall -SIGUSR2 waybar

echo "--- Theme Update Complete ---"
