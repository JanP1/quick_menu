#!/usr/bin/env bash

launch_youtube() {
    firefox --new-window https://www.youtube.com/
}

launch_lichess() {
    firefox --new-window https://lichess.org/
}

launch_uni() {
    firefox --new-window https://platforma.polsl.pl/rms/
}

launch_usos() {
    firefox --new-window https://usosweb.polsl.pl/kontroler.php?_action=home/index
}

entries=(
  "YouTube|launch_youtube|~/.rofi_launcher/icons/youtube.png"
  "Lichess|launch_lichess|~/.rofi_launcher/icons/lichess.png"
  "Politechnika|launch_uni|~/.rofi_launcher/icons/polibuda.png"
  "Usos|launch_usos|~/.rofi_launcher/icons/usos.png"

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
