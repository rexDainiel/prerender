FROM node:4.3.2
MAINTAINER Zen Day <zenday@keylol.com>

ENV NPM_CONFIG_LOGLEVEL warn

COPY package.json .
RUN npm install

COPY lib lib/

COPY *.js ./

EXPOSE 3000

COPY keylol-prerender.sh /usr/local/bin
RUN chmod +x /usr/local/bin/keylol-prerender.sh

CMD /usr/local/bin/keylol-prerender.sh