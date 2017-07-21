FROM alpine:3.5

MAINTAINER razeen <razeen.cheng@gmail.com>

# 安装基础环境
RUN apk add --no-cache --virtual .build-deps \
    g++ \
    gcc \
    libc-dev \
    make \
    openssl-dev \
    pcre-dev \
    zlib-dev \
    linux-headers \
    curl \
    gnupg \
    libxslt-dev \
    gd-dev \
    geoip-dev \
    perl-dev \ 
&& cd /root \
&& curl -kfSL https://www.openssl.org/source/openssl-1.0.2l.tar.gz -o openssl.tar.gz \
&& curl -kfSL https://zlib.net/zlib-1.2.11.tar.gz -o zlib.tar.gz \
&& curl -kfSL https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.gz -o pcre.tar.gz \
&& curl -kfSL https://nginx.org/download/nginx-1.12.0.tar.gz -o nginx.tar.gz \
&& mkdir -p /usr/src \
&& tar -zxC /usr/src -f nginx.tar.gz \
&& tar -zxC /usr/src -f openssl.tar.gz \
&& tar -zxC /usr/src -f zlib.tar.gz \
&& tar -zxC /usr/src -f pcre.tar.gz \
&& rm nginx.tar.gz openssl.tar.gz zlib.tar.gz pcre.tar.gz \
&& cd /usr/src/nginx-1.12.0 \
&& ./configure \
		--prefix=/etc/nginx \
		--sbin-path=/usr/sbin/nginx \
		--modules-path=/usr/lib/nginx/modules \
		--conf-path=/etc/nginx/nginx.conf \
		--error-log-path=/var/log/nginx/error.log \
		--http-log-path=/var/log/nginx/access.log \
		--pid-path=/var/run/nginx.pid \
		--lock-path=/var/run/nginx.lock \
                --with-http_ssl_module \
                --with-openssl=/usr/src/openssl-1.0.2l \
                --with-openssl-opt=enable-tls2 \
		--with-http_realip_module \
		--with-http_addition_module \
		--with-http_sub_module \
		--with-http_dav_module \
		--with-http_flv_module \
		--with-http_mp4_module \
		--with-http_gunzip_module \
		--with-http_gzip_static_module \
		--with-http_random_index_module \
		--with-http_secure_link_module \
		--with-http_stub_status_module \
		--with-http_auth_request_module \
		--with-pcre=/usr/src/pcre-8.40 \
                --with-zlib=/usr/src/zlib-1.2.11 \
		--with-threads \
		--with-stream \
		--with-stream_ssl_module \
		--with-stream_ssl_preread_module \
		--with-stream_realip_module \
		--with-http_slice_module \
		--with-mail \
		--with-mail_ssl_module \
		--with-compat \
		--with-file-aio \
		--with-http_v2_module \
&& make \
&& make install \
&& apk del .build-deps \
&& rm -rf /usr/src/nginx-1.12.0 \
&& rm -rf /usr/src/openssl-1.0.2l \
&& rm -rf /usr/src/pcre-8.40 \
&& rm -rf /usr/src/zlib=1.2.11 \
# forward request and error logs to docker log collector
&& ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log

ADD nginx.conf /etc/nginx/nginx.conf
ADD nginx.www.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
WORKDIR /usr/sbin
CMD ["./nginx", "-g", "daemon off;"]

