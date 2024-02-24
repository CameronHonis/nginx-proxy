#!/bin/bash

cd "$(dirname "$0")/.." || exit

cp nginx.conf temp_nginx.conf

while IFS=: read -r matched_env_string; do
  env_name="${matched_env_string:1}"
  if [[ -z "${!env_name}" ]]; then
    echo "Environment variable $env_name is not set, skipping"
    continue
  fi
  sed -i "s/\$${env_name}/$(printf '%s' "${!env_name}")/g" temp_nginx.conf
  echo "Injected $env_name into nginx.conf"
done < <(grep -oP '[$][A-Z | 0-9 | _]+' nginx.conf | sort | uniq)

echo "config with env injected:"
cat temp_nginx.conf