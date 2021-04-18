FROM devenv-cpp

USER root

# Intel Compiler
RUN wget -O - https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | apt-key add - && \
    echo "deb https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list && \
    add-apt-repository "deb https://apt.repos.intel.com/oneapi all main" && \
    install-packages intel-hpckit

USER sebwink

RUN echo 'export PATH=$PATH:/opt/intel/oneapi/compiler/2021.2.0/linux/bin/intel64' >> ~/.bashrc
