FROM node:20-alpine3.23 AS builder
WORKDIR /app/server
COPY package.json .
COPY *.js .
RUN npm install


FROM node:20-alpine3.23 
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
WORKDIR /app/server
USER roboshop
COPY --from=builder /app/server /app/server
CMD ["node", "server.js"]


