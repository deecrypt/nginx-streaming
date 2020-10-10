# Dockerfile for NGINX Streaming
#
# Author: Deecrypt

# Pull Ubuntu 18.04 base image
FROM ubuntu:18.04

#Create NGINX working dir
WORKDIR /usr/local/nginx/


# Install Nginx with RTMP & SSL module
RUN \
  apt update && \
  apt install build-essential git libpcre3-dev libssl-dev zlib1g-dev -y && \
  mkdir -p /tmp/build /mnt/hls /mnt/dash && \
  cd /tmp/build && \
  git clone https://github.com/arut/nginx-rtmp-module.git && \
  git clone https://github.com/nginx/nginx.git && \
  cd nginx && \
  ./auto/configure --add-module=../nginx-rtmp-module --with-http_ssl_module --user=www-data --group=www-data && \
  make && \
  make install && \
  rm -rf /tmp/build

# Forward logs to Docker
RUN ln -sf /dev/stdout /usr/local/nginx/logs/access.log && \
    ln -sf /dev/stderr /usr/local/nginx/logs/error.log

# COPY the NGINX Streaming Config
COPY nginx.conf  /usr/local/nginx/conf/

# Expose ports
EXPOSE 80 443 1935

#Add NGINX path
ENV PATH "${PATH}:/usr/local/nginx/sbin"

# Default command
CMD ["nginx"]

