#!/usr/bin/env bash

project_dir="$HOME/Programming/Projects"
icon_path="$HOME/.rofi_launcher/icons/projects.png"

declare -A paths icons
names=()

# Scan for projects
while IFS= read -r -d '' dir; do
    name=$(basename "$dir")
    names+=("$name")
    paths["$name"]="$dir"
    icons["$name"]="$icon_path"
done < <(find "$project_dir" -mindepth 1 -maxdepth 1 -type d -print0)

# Format for rofi
rofi_input=""
for name in "${names[@]}"; do
    rofi_input+="$name\0icon\x1f${icons[$name]}\n"
done

chosen=$(echo -en "$rofi_input" | rofi -dmenu -i -p "Projects:" -show-icons \
         -theme-str 'listview { columns: 1; } element-icon { size: 40px; }')

# Execute directly. No eval.
if [[ -n "$chosen" ]]; then
    kitty --directory "${paths[$chosen]}" nvim -c "Nvdash"
fi
