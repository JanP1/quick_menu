#!/usr/bin/env bash

# --- Define functions for each menu entry ---
launch_apps() {
    rofi -show drun -i -show-icons
}

launch_programming() {
    ~/.rofi_launcher/rofi_programming_menu.sh
}

launch_websites() {
    ~/.rofi_launcher/rofi_website_menu.sh
}

launch_system() {
    ~/.rofi_launcher/rofi_system_menu.sh
}

launch_filesystem(){
    dolphin
}

# --- Menu entries: Name | Function name | Icon path ---
entries=(
    "Apps|launch_apps|~/.rofi_launcher/icons/apps.png"
    "Programming|launch_programming|~/.rofi_launcher/icons/programming.png"
    "Files|launch_filesystem|~/.rofi_launcher/icons/files.png"
    "Web Apps|launch_websites|~/.rofi_launcher/icons/webapp.png"
    "System|launch_system|~/.rofi_launcher/icons/settings.png"
)


# --- Build Rofi input with icons ---
rofi_input=""
for entry in "${entries[@]}"; do
    IFS='|' read -r name cmd icon <<< "$entry"
    rofi_input+="$name\0icon\x1f$icon\n"
done

# --- Show Rofi menu ---
chosen=$(echo -en "$rofi_input" | rofi -dmenu -i -p "Submenu:" -show-icons \
         -theme-str 'listview { columns: 1; } element-icon { size: 40px; }')

# --- Execute the corresponding function ---
for entry in "${entries[@]}"; do
    IFS='|' read -r name cmd icon <<< "$entry"
    if [[ "$chosen" == "$name" ]]; then
        $cmd
    fi
done
