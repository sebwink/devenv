FROM devenv-base:latest

USER root

RUN install-packages libsecret-1-dev libx11-dev libxkbfile-dev

USER u

RUN mkdir $HOME/theia

COPY --chown=u:u ./docker/base-theia/package.json $HOME/theia/package.json

RUN cd $HOME/theia && \
    . $NVM_DIR/nvm.sh && \
    nvm use $NODE_VERSION && \
    npm i -g yarn && \
    yarn && \
    yarn theia build

COPY --chown=u:u ./docker/base-theia/start.sh $HOME/theia/start.sh
CMD $HOME/theia/start.sh