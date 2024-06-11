#!/bin/bash

services=(
  cron
  ssh
)

for service in "${services[@]}"; do
  status="$(service ${service} status)"
  if [[ $status = *"is not running"* ]]; then
    sudo service "${service}" --full-restart
  fi
done
