#!/usr/bin/env bash

launch_project() {
    local name="$1"

    # Replace spaces with underscores
    local safe_name="${name// /_}"

    # Full path
    local dir="$HOME/Programming/Projects/$safe_name"

    # Create directory if it doesn't exist
    mkdir -p "$dir"

    # Open Kitty in that directory and echo the project name
    kitty --directory "$dir" zsh -c "echo \"Project: $safe_name\"; exec zsh"
}

# Prompt for input
input=$(rofi -dmenu -p "Enter project name:" -no-show-icons -lines 0 -theme-str 'window { width: 70ch; }')

# Call function if input is not empty
if [[ -n "$input" ]]; then
    launch_project "$input"
fi
