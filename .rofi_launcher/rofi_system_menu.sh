#!/usr/bin/env bash

launch_settings() {
    systemsettings
}

launch_btop() {
    kitty btop
}

entries=(
  "Settings|launch_settings|~/.rofi_launcher/icons/settings.png"
  "Vitals|launch_btop|~/.rofi_launcher/icons/vitals.png"
)

rofi_input=""
for entry in "${entries[@]}"; do
    IFS='|' read -r name cmd icon <<< "$entry"
    rofi_input+="$name\0icon\x1f$icon\n"
done

chosen=$(echo -en "$rofi_input" | rofi -dmenu -i -p "Launch:" -show-icons \
         -theme-str 'listview { columns: 1; } element-icon { size: 40px; }')

for entry in "${entries[@]}"; do
    IFS='|' read -r name cmd icon <<< "$entry"
    if [[ "$chosen" == "$name" ]]; then
        # Call the function
        $cmd
    fi
done
