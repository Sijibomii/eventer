FROM node:16.14.0-alpine
WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm i

COPY . .

RUN npm run build

ENV NODE_ENV development
CMD [ "node", "dist/index.js" ]
USER node