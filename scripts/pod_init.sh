mkdir -p /etc/nginx

if [[ -z ${PROXY_OUT_PORT} ]]; then
  echo "PROXY_OUT_PORT not set, using default 8080"
  export PROXY_OUT_PORT=8080
fi

if [[ -z ${PROXY_OUT_ADDR} ]]; then
  echo "PROXY_OUT_ADDR not set, using default localhost"
  export PROXY_OUT_ADDR=localhost
fi

if [[ -z ${PROXY_IN_PORT} ]]; then
  echo "PROXY_IN_PORT not set, using default 8079"
  export PROXY_IN_PORT=8079
fi

"$(dirname "$0")"/create_config_with_env.sh

mv temp_nginx.conf /etc/nginx/nginx.conf

rm ./nginx.conf

nginx -t

nginx -g 'daemon off;'