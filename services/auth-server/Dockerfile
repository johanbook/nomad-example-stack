FROM node:16.5.0-alpine

WORKDIR /app

COPY . .
RUN npm ci

ENTRYPOINT [ "node" ]
CMD [  "src/index.js" ]
EXPOSE 80
