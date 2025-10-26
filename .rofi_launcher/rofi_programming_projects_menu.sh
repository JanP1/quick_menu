#!/usr/bin/env bash

launch_project() {
    ~/.rofi_launcher/programming_projects/open_project.sh
}

launch_create_project() {
    ~/.rofi_launcher/programming_projects/create_project.sh
}

entries=(
    "Open Project|launch_project|~/.rofi_launcher/icons/projects.png"
    "Create Project|launch_create_project|~/.rofi_launcher/icons/projects.png"
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
