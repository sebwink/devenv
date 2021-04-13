FROM debian:stretch-slim

RUN apt update && \
    apt-get upgrade -y \
    apt-get install neovim
