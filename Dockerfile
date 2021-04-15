FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

USER root

COPY install-packages /usr/bin
RUN chmod +x /usr/bin/install-packages

# UPGRADE PACKAGES && PURGE VIM
RUN apt update && \
    apt upgrade -yq && \
    apt purge vim -yq

# GENERAL DEPENDENCIES
RUN install-packages curl \
      zip \
      unzip \
      bash-completion \
      build-essential \
      ninja-build \
      htop \
      jq \
      less \
      locales \
      man-db \
      software-properties-common \
      time \
      multitail \
      lsof \
      ssl-cert \
      gnupg-agent \
      wget \
      cmake \
      pkg-config \
      automake \
      libtool \
      libtool-bin \
      python3 \
      ttf-mscorefonts-installer \
      fontconfig \
      tmux -yq

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

# GIT
RUN add-apt-repository -y ppa:git-core/ppa && \
    install-packages git

# PIP
RUN install-packages python3-distutils python3-apt python3-dev && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

# NVIM
RUN python3 -m pip install neovim && \
    wget https://github.com/neovim/neovim/releases/download/v0.4.4/nvim-linux64.tar.gz && \
    tar xvf nvim-linux64.tar.gz && \
    cp nvim-linux64/bin/nvim /usr/local/bin && \
    ln -s /usr/local/bin/nvim /usr/local/bin/vim && \
    cp -r nvim-linux64/share/man/* /usr/local/share/ && \
    rm -r nvim-linux64/share/man && \
    cp -r nvim-linux64/share/* /usr/local/share/ && \
    rm -r nvim-linux64*

# XONSH
RUN python3 -m pip install xonsh xonsh-autoxsh prompt_toolkit jedi
# TMUXP
RUN python3 -m pip install tmuxp
# C/C++ - clang
RUN install-packages clang-format \
      clang-tidy \
      clang \
      libomp5 \
      lld \
      lldb 

# USER
RUN useradd -l -u 1000 -G sudo -md /home/sebwink -s /bin/bash -p sebwink sebwink
ENV HOME=/home/sebwink
WORKDIR $HOME

USER sebwink

# SPACEVIM
RUN curl -sLf https://spacevim.org/install.sh | bash && \
    vim "+call dein#install#_update([], 'update', 0)" +qall && \
    vim "+call dein#add('Shougo/vimproc.vim', {'build': 'make'})" +qall && \
    vim +VimProcInstall +qall
# SPACEVIM CONFIG
COPY SpaceVim.d /home/sebwink/.SpaceVim.d
RUN vim "+call dein#install#_update([], 'update', 0)" +qall

# NVM -> node + npm
ENV NODE_VERSION 14.16.1
ENV NVM_DIR $HOME/.nvm
RUN wget https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh && \
    bash install.sh -y && rm install.sh && \
    . ~/.nvm/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm use $NODE_VERSION

# RUST
RUN wget -O install-rust.sh https://sh.rustup.rs && \
    bash install-rust.sh -y && rm install-rust.sh

# YCM
RUN cd ~/.cache/vimfiles/repos/github.com/Valloric/YouCompleteMe && \
    . ~/.nvm/nvm.sh && \
    nvm use $NODE_VERSION && \
    python3 install.py --clangd-complete --rust-completer --ts-completer

RUN vim +UpdateRemotePlugins +qall

# XONSH CONFIG
COPY xonshrc /home/sebwink/.xonshrc
RUN mkdir -p $HOME/.xcontext/docker
# TMUX CONFIG
COPY tmux.conf /home/sebwink/.tmux.conf
# TMUXP
#
RUN mkdir workspace
WORKDIR /home/sebwink/workspace
