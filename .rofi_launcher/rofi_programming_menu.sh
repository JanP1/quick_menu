#!/usr/bin/env bash

mynvim() {
    kitty --directory ~/Programming/ nvim -c "Nvdash"
}

launch_projects() {
    ~/.rofi_launcher/rofi_programming_projects_menu.sh
}

entries=(
    "Projects|launch_projects|~/.rofi_launcher/icons/projects.png"
    "Nvim|mynvim|~/.rofi_launcher/icons/nvim.png"
    "Terminal|kitty|~/.rofi_launcher/icons/programming.png"
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
