#!/usr/bin/env bash

# Claude Router — Local skill registry
declare -A SKILLS=(
  [skill-pilot]="skills/skill-pilot/SKILL.md"
)

if [[ $# -eq 0 ]]; then
  echo "Usage: source ./skill.sh <skill-name>"
  echo "Available skills: ${!SKILLS[@]}"
else
  echo "${SKILLS[$1]}"
fi
