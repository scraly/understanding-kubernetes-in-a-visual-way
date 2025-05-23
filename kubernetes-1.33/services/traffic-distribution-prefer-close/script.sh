#!/bin/bash

declare -A host_count

for i in $(seq 1 100); do
  response=$(curl -s http://svc-prefer-close.test:8080)
  hostname=$(echo "$response" | grep "Hostname:" | cut -d":" -f2 | xargs)
  if [[ -n "$hostname" ]]; then
    ((host_count["$hostname"]++))
  fi
done

for host in "${!host_count[@]}"; do
  echo "$host: ${host_count[$host]}"
done
