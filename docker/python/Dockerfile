FROM devenv-base

RUN python3 -m pip install --user pylint && \
    . ~/.nvm/nvm.sh && \
    nvm use $NODE_VERSION && \
    npm install -g dockerfile_lint

RUN echo 'export PATH=$PATH:$HOME/.local/bin' > $HOME/.bashrc
