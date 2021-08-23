# syntax=docker/dockerfile:experimental
FROM node:14.15.1-alpine3.12 AS builder

WORKDIR /app

COPY package.lock  package.json .

RUN npm install

COPY src src

COPY tsconfig.json .

RUN npm build
# =================== release ====================
FROM nginx AS release

COPY --from=builder /app/dist /usr/share/nginx/html

# COPY entrypoint.sh /bin/entrypoint

# CMD ["/bin/entrypoint"]
