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
# YCM DEPENCENCIES
RUN install-packages vim-nox && \
    # TODO go -> manual && nodejs/nom -> nvm && java -> java11?
    install-packages mono-complete golang nodejs default-jdk npm

# C/C++ - clang
RUN install-packages clang-format \
      clang-tidy \
      clang-tools \
      clang \
      clangd \
      libc++-dev \
      libc++1 \
      libc++abi-dev \
      libc++abi1 \
      libclang-dev \
      libclang1 \
      liblldb-dev \
      libllvm-ocaml-dev \
      libomp-dev \
      libomp5 \
      lld \
      lldb \
      llvm-dev \
      llvm-runtime \
      llvm \
      python3-clang

# GITPOD USER
RUN useradd -l -u 1000 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod
ENV HOME=/home/gitpod
WORKDIR $HOME

USER gitpod

# SPACEVIM
RUN curl -sLf https://spacevim.org/install.sh | bash && \
    vim "+call dein#install#_update([], 'update', 0)" +qall && \
    vim "+call dein#add('Shougo/vimproc.vim', {'build': 'make'})" +qall && \
    vim +VimProcInstall +qall
# SPACEVIM CONFIG
COPY SpaceVim.d /home/gitpod/.SpaceVim.d
RUN vim "+call dein#install#_update([], 'update', 0)" +qall
# YCM
RUN cd ~/.cache/vimfiles/repos/github.com/Valloric/YouCompleteMe && \
    python3 install.py --all

RUN vim +UpdateRemotePlugins +qall

# XONSH CONFIG
COPY xonshrc /home/gitpod/.xonshrc
RUN mkdir -p $HOME/.xcontext/docker
# TMUX CONFIG
COPY tmux.conf /home/gitpod/.tmux.conf
# TMUXP
#
RUN mkdir workspace
WORKDIR /home/gitpod/workspace
