#!/usr/bin/env zsh

services=(
  cron
  ssh
)

for service in "${services[@]}"; do
  if [[ "$(systemctl is-active ${service})" == "active" ]]; then
    continue
  fi
  sudo systemctl start "${service}"
done
