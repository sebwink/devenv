FROM debian:stretch-slim

RUN apt update && \
    apt upgrade -y && \
    apt install neovim curl -y && \
    curl -sLf https://spacevim.org/install.sh | bash
