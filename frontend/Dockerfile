FROM node:alpine as build-stage

ENV APP /frontend
WORKDIR $APP

COPY package.json package-lock.json vue.config.js babel.config.js $APP/
RUN npm install

COPY . $APP/

CMD ["npm", "run", "serve"]