#!/usr/bin/env bash

# Claude Router — Local skill registry
declare -A SKILLS=(
  [claude-router]="skills/claude-router/SKILL.md"
)

if [[ $# -eq 0 ]]; then
  echo "Usage: source ./skill.sh <skill-name>"
  echo "Available skills: ${!SKILLS[@]}"
else
  echo "${SKILLS[$1]}"
fi
