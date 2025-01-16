# syntax=docker/dockerfile:1
# https://docs.docker.com/go/dockerfile-reference/

ARG NODE_VERSION=23.6.0

FROM node:${NODE_VERSION}-alpine

# Use prod
ENV NODE_ENV=production


WORKDIR /usr/src/app

RUN --mount=type=bind,source=VoidTogether-Server/package.json,target=package.json \
    --mount=type=bind,source=VoidTogether-Server/package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

USER node

COPY . .

EXPOSE 42069

WORKDIR /usr/src/app/VoidTogether-Server

CMD node server.js
