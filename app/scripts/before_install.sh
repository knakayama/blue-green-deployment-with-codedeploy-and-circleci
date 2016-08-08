#!/usr/bin/env bash

sed -i "s@server_name  localhost@server_name $(curl -s http://169.254.169.254/latest/meta-data/public-hostname)@" \
  "/etc/nginx/nginx.conf"

INDEX_HTML="/usr/share/nginx/html/index.html"

[[ -f "$INDEX_HTML" ]] && rm -rf "$INDEX_HTML"
