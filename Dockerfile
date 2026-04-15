FROM node:20-alpine3.19 AS builder
WORKDIR /app/server
COPY package.json .
COPY *.js .
RUN npm install


FROM node:20-alpine3.19 
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
RUN apk add --no-cache \
    musl \
    openssl \
    busybox
WORKDIR /app/server
USER roboshop
COPY --from=builder /app/server /app/server
CMD ["node", "server.js"]


