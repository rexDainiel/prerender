FROM node:4.3.2
MAINTAINER Zen Day <zenday@keylol.com>

ENV NPM_CONFIG_LOGLEVEL warn

COPY package.json .
RUN npm install

COPY lib lib/
COPY server.js ./

# Prerender 监听端口
ENV PORT 3000

# Prerender 文件缓存位置
ENV CACHE_DIR /prerender-file-cache

# Prerender 文件缓存有效期
ENV CACHE_TTL 86400

# Prerender basicAuth 默认用户名
ENV BASIC_AUTH_USERNAME keylol

# Prerender basicAuth 默认密码
ENV BASIC_AUTH_PASSWORD foobar

EXPOSE 3000
VOLUME /prerender-file-cache
CMD node server.js
