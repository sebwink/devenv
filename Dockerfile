FROM debian:stretch-slim

RUN apt-get update && \
      apt-get upgrade -y \
      apt-get install neovim
