#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# This script can be used to change the color theme of Alacritty. It cicles
# through a list of available color themes.
#
# In order for that to work, do the following:
# - Place your color themes that you want to cycle through into the directory
#   ${XDG_CONFIG_HOME}/alacritty/themes. One color theme per file. You can also
#   put links to color theme files into the mentioned directory.
# - In your alacritty.toml config file, add the following:
#   ```
#   import = [
#       "<path/to/current/color_theme.toml",    # COLOR_THEME
#   ]
#   ```
#   The "# COLOR_THME" part is important. It will be used to identify the color
#   theme configuration line. This part should not occure anywhere else in the
#   configuration file.
#
# Now you can either call this script manually, or add a short cut to execute
# it.
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Constants
# -----------------------------------------------------------------------------

COLOR_THEMES_DIR="${XDG_CONFIG_HOME}/alacritty/themes"
ALACRITTY_CONFIG_FILE="${XDG_CONFIG_HOME}/alacritty/alacritty.toml"

# -----------------------------------------------------------------------------
# The actual script
# -----------------------------------------------------------------------------

# Get a list of all available color themes (files or links) in the directory,
# sorted alphabetically.
available_color_themes=(\
    $(find "$COLOR_THEMES_DIR" -maxdepth 1 -type f -o -type l | sort)
)

# Extract the path to the color theme file from the config.toml line with the
# marker.
color_theme_config_line=$(grep "# COLOR_THEME" $ALACRITTY_CONFIG_FILE)
current_color_theme=$(echo "$color_theme_config_line" | awk -F'"' '{print $2}')

# Check if the color theme path from config.toml is in the list of available
# color themes.
# If so replace it with the next item in the list of available color themes.
# If not, write the first color theme path of the list of available color
# themes into the config file.
if [[ " ${available_color_themes[@]} " =~ " $current_color_theme " ]]; then
    # Find the index of the current color theme in the list.
    for (( i=0; i<${#available_color_themes[@]}; i++ )); do
        if [[ "${available_color_themes[$i]}" == "$current_color_theme" ]]; then
            current_index=$i
            break
        fi
    done

    # Get the next color theme in the list (circular).
    next_index=$(( (current_index + 1) % ${#available_color_themes[@]} ))
    next_color_theme=${available_color_themes[next_index]}

    # Replace the path in config.toml with the next path in the list.
    sed \
        -i \
        "s|\"$current_color_theme\"|\"$next_color_theme\"|g" \
        $ALACRITTY_CONFIG_FILE

    echo "Replaced $(basename ${current_color_theme})" \
         "with the next color theme: $(basename $next_color_theme)"
else
    # Set the first color theme in the list as the current color theme.
    first_color_theme=${available_color_themes[0]}
    sed \
        -i "s|.*# COLOR_THEME|    \"$first_color_theme\",    # COLOR_THEME|g" \
        $ALACRITTY_CONFIG_FILE

    echo "Set color theme to: $(basename $first_color_theme)"
fi

