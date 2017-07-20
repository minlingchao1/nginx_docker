#!/bin/bash

set -e

docker build -f nginx_ssl-2.0/Dockerfile -t nginx:ssl200 .
docker build -f nginx_tls-1.3/Dockerfile -t nginx:tls304 .
