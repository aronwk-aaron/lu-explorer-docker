# syntax=docker/dockerfile:1

FROM node:16.13.1 as builder
WORKDIR /app
RUN git clone https://github.com/Xiphoseer/lu-explorer.git .
RUN npm ci
RUN npx ng build --configuration production

FROM rust:1.58.1-bullseye
COPY --from=builder /app/dist /dist

WORKDIR /usr/src/paradox-server
RUN cargo install --git https://github.com/aronwk-aaron/ParadoxServer.git --branch main
COPY docker-paradox.toml paradox.toml
COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh
EXPOSE 3030

ENTRYPOINT ["./entrypoint.sh"]