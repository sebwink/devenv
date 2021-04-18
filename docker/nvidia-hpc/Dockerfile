FROM devenv-cpp

USER root

# NVIDIA HPC SDK
RUN wget https://developer.download.nvidia.com/hpc-sdk/21.3/nvhpc-21-3_21.3_amd64.deb \
      https://developer.download.nvidia.com/hpc-sdk/21.3/nvhpc-2021_21.3_amd64.deb \
       https://developer.download.nvidia.com/hpc-sdk/21.3/nvhpc-21-3-cuda-multi_21.3_amd64.deb && \
    install-packages gfortran \
      libnuma1 \
      libncursesw5 \
      libtinfo5 && \
    apt install ./nvhpc-21-3_21.3_amd64.deb ./nvhpc-2021_21.3_amd64.deb ./nvhpc-21-3-cuda-multi_21.3_amd64.deb && \
    rm nvhpc-21-3_21.3_amd64.deb nvhpc-2021_21.3_amd64.deb && \
    cp /opt/nvidia/hpc_sdk/Linux_x86_64/21.3/math_libs/lib64/*.so* /opt/nvidia/hpc_sdk/Linux_x86_64/2021/cuda/10.2/lib64/ && \
    cp /opt/nvidia/hpc_sdk/Linux_x86_64/21.3/math_libs/lib64/*.a /opt/nvidia/hpc_sdk/Linux_x86_64/2021/cuda/10.2/lib64/ && \
    cp -r /opt/nvidia/hpc_sdk/Linux_x86_64/21.3/math_libs/lib64/stubs /opt/nvidia/hpc_sdk/Linux_x86_64/2021/cuda/10.2/lib64/stubs && \
    cp /opt/nvidia/hpc_sdk/Linux_x86_64/21.3/math_libs/lib64/*.so* /opt/nvidia/hpc_sdk/Linux_x86_64/2021/cuda/11.0/lib64/ && \
    cp /opt/nvidia/hpc_sdk/Linux_x86_64/21.3/math_libs/lib64/*.a /opt/nvidia/hpc_sdk/Linux_x86_64/2021/cuda/11.0/lib64/ && \
    cp /opt/nvidia/hpc_sdk/Linux_x86_64/21.3/math_libs/lib64/stubs/* /opt/nvidia/hpc_sdk/Linux_x86_64/2021/cuda/11.0/lib64/stubs/ && \
    cp /opt/nvidia/hpc_sdk/Linux_x86_64/21.3/math_libs/lib64/*.so* /opt/nvidia/hpc_sdk/Linux_x86_64/2021/cuda/11.2/lib64/ && \
    cp /opt/nvidia/hpc_sdk/Linux_x86_64/21.3/math_libs/lib64/*.a /opt/nvidia/hpc_sdk/Linux_x86_64/2021/cuda/11.2/lib64/ && \
    cp /opt/nvidia/hpc_sdk/Linux_x86_64/21.3/math_libs/lib64/stubs/* /opt/nvidia/hpc_sdk/Linux_x86_64/2021/cuda/11.2/lib64/stubs/

USER sebwink

# Compiler PATHS
RUN echo 'export PATH=$PATH:/opt/nvidia/hpc_sdk/Linux_x86_64/21.3/compilers/bin' >> ~/.bashrc && \
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.2/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
