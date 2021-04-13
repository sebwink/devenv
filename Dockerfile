FROM debian:stretch-slim

RUN apt update && \
    apt upgrade -y && \
    apt install neovim -y
