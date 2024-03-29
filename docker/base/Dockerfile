FROM ubuntu:22.04

RUN yes | unminimize

ARG DEBIAN_FRONTEND=noninteractive

# CONFIGURATION
# NEOVIM version
ARG NVIM_VERSION
ENV NVIM_VERSION=${NVIM_VERSION:-0.8.0}
# CMAKE version
ARG CMAKE_VERSION
ENV CMAKE_VERSION=${CMAKE_VERSION:-3.24.2}
# NODE version
ARG NODE_VERSION
ENV NODE_VERSION=${NODE_VERSION:-18.12.0}

USER root


COPY docker/base/install-packages /usr/bin
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
      pkg-config \
      automake \
      libtool \
      libtool-bin \
      python3 \
      python-is-python3 \
      ttf-mscorefonts-installer \
      fontconfig \
      libssl-dev \
      tree \
      tmux \
      neofetch -yq

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

# GIT
RUN add-apt-repository -y ppa:git-core/ppa && \
    install-packages git

# CMAKE
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz && \
    tar xvf cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz && rm cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz && \
    cd cmake-${CMAKE_VERSION}-linux-x86_64 && \
    cp bin/* /usr/local/bin/ && \
    mkdir -p /usr/local/man/man1 && \
    cp man/man1/* /usr/local/man/man1/ && \
    mkdir -p /usr/local/man/man7 && \
    cp man/man7/* /usr/local/man/man7/ && \
    mkdir -p /usr/local/doc && \
    cp -r doc/cmake /usr/local/doc/ && \
    mkdir -p /usr/local/share/bash-completion/completions && \
    cp share/bash-completion/completions/* /usr/local/share/bash-completion/completions/ && \
    CMAKE_MAJOR_MINOR=$(echo $CMAKE_VERSION | sed "s/\([0-9]\+\.[0-9]\+\)\.[0-9]\+/\1/g") && \
    cp -r share/cmake-${CMAKE_MAJOR_MINOR} /usr/local/share/cmake-${CMAKE_MAJOR_MINOR} && \
    cd .. && rm -r cmake-${CMAKE_VERSION}-linux-x86_64

# PIP
RUN install-packages python3-distutils python3-apt python3-dev python3-venv && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

# NVIM
RUN python3 -m pip install neovim && \
    wget https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux64.tar.gz && \
    tar xvf nvim-linux64.tar.gz && \
    cp nvim-linux64/bin/nvim /usr/local/bin && \
    ln -s /usr/local/bin/nvim /usr/local/bin/vim && \
    cp -r nvim-linux64/share/man/* /usr/local/share/ && \
    rm -r nvim-linux64/share/man && \
    cp -r nvim-linux64/share/* /usr/local/share/ && \
    rm -r nvim-linux64*

# TMUXP
RUN python3 -m pip install tmuxp

# GCC 12
RUN install-packages gcc-12 g++-12

# CLANG 14
RUN install-packages clang-format \
      clang-tidy \
      clang \
      libomp5 \
      lld \
      lldb 

# .NET 6
RUN install-packages dotnet6

# USER
RUN useradd -l -u 1000 -G sudo -md /home/u -s /bin/bash -p u u
ENV HOME /home/u
WORKDIR $HOME
USER u

# NVM -> node + npm
ENV NVM_DIR $HOME/.nvm
RUN wget https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh && \
    bash install.sh -y && rm install.sh && \
    . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm use $NODE_VERSION

RUN . $NVM_DIR/nvm.sh && \
    nvm use $NODE_VERSION && \
    npm install -g neovim

# SPACEVIM
RUN curl -sLf https://spacevim.org/install.sh | bash && \
    vim "+call dein#install#_update([], 'update', 0)" +qall && \
    vim "+call dein#add('Shougo/vimproc.vim', {'build': 'make'})" +qall && \
    vim +VimProcInstall +qall
# SPACEVIM CONFIG
COPY docker/base/SpaceVim.d $HOME/.SpaceVim.d
RUN . $NVM_DIR/nvm.sh && \
    nvm use $NODE_VERSION && \
    vim "+call dein#install#_update([], 'update', 0)" +qall

# Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > install-rust.sh && \
    bash install-rust.sh -y && \
    rm install-rust.sh

# YCM
RUN cd ~/.cache/vimfiles/repos/github.com/Valloric/YouCompleteMe && \
    . ~/.nvm/nvm.sh && \
    nvm use $NODE_VERSION && \
    python3 install.py --clangd-completer --rust-completer --ts-completer

RUN . $NVM_DIR/nvm.sh && \
    nvm use $NODE_VERSION && \
    vim +UpdateRemotePlugins +qall

# CPPCHECK & PYLINT
RUN python3 -m pip install --user cpplint pylint
# POETRY
RUN mkdir -p $HOME/.local/share/pypoetry && \
    cd $HOME/.local/share/pypoetry && \
    python3 -m venv venv && \
    ./venv/bin/pip install -U pip setuptools && \
    ./venv/bin/pip install poetry

RUN echo 'export PATH=$PATH:$HOME/.local/bin' >> $HOME/.bashrc && \
    echo 'export PATH=$PATH:$HOME/.nvm/versions/node/$NODE_VERSION/bin' >> $HOME/.bashrc && \
    ln -s $HOME/.local/share/pypoetry/venv/bin/poetry $HOME/.local/bin/poetry

USER root
RUN ln -s $HOME/.nvm/versions/node/v$NODE_VERSION/bin/node /usr/local/bin/node && \
    ln -s $HOME/.nvm/versions/node/v$NODE_VERSION/bin/npm /usr/local/bin/npm
USER u

# TMUX CONFIG
COPY docker/base/tmux.conf $HOME/.tmux.conf

RUN mkdir workspace
WORKDIR $HOME/workspace
