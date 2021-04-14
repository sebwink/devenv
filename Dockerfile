FROM gitpod/workspace-base:latest

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN apt update && \
    apt upgrade -yq && \
    apt purge vim -yq && \
    apt install curl \
      wget \
      cmake \
      pkg-config \
      automake \
      unzip \
      libtool \
      libtool-bin \
      python3 \
      ttf-mscorefonts-installer \
      fontconfig -yq

RUN wget https://github.com/neovim/neovim/releases/download/v0.4.4/nvim-linux64.tar.gz && \
    tar xvf nvim-linux64.tar.gz && \
    cp nvim-linux64/bin/nvim /usr/local/bin && \
    ln -s /usr/local/bin/nvim /usr/local/bin/vim && \
    cp -r nvim-linux64/share/man/* /usr/local/share/ && \
    rm -r nvim-linux64/share/man && \
    cp -r nvim-linux64/share/* /usr/local/share/ && \
    rm -r nvim-linux64*

USER gitpod

RUN mkdir -p /home/gitpod/.bashrc.d && \
    touch /home/gitpod/.bashrc.d/init

RUN curl -sLf https://spacevim.org/install.sh | bash && \
    vim "+call dein#install#_update([], 'update', 0)" +qall && \
    vim "+call dein#add('Shougo/vimproc.vim', {'build': 'make'})" +qall && \
    vim +VimProcInstall +qall

COPY SpaceVim.d/init.toml /home/gitpod/.SpaceVim.d/init.toml

RUN vim "+call dein#install#_update([], 'update', 0)" +qall
