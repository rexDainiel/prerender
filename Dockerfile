FROM node:4.3.2
MAINTAINER Zen Day <zenday@keylol.com>

ENV NPM_CONFIG_LOGLEVEL warn

COPY package.json .
RUN npm install

COPY lib lib/
COPY server.js ./

COPY keylol-prerender.sh /usr/local/bin
RUN chmod +x /usr/local/bin/keylol-prerender.sh

ENV PORT 3000 # Prerender 监听端口
ENV CACHE_ROOT_DIR /prerender-file-cache # Prerender 文件缓存位置
ENV CACHE_LIVE_TIME 86400 # Prerender 文件缓存有效期
ENV BASIC_AUTH_USERNAME keylol # Prerender basicAuth 默认用户名
ENV BASIC_AUTH_PASSWORD foobar # Prerender basicAuth 默认密码

EXPOSE 3000
VOLUME /prerender-file-cache
CMD /usr/local/bin/keylol-prerender.sh
