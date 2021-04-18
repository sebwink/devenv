FROM devenv-python

USER root

# GCC 10
RUN install-packages gcc-10 g++-10

# CLANG 10
RUN install-packages clang-format \
      clang-tidy \
      clang \
      libomp5 \
      lld \
      lldb 

# CLANG 11

# CLANG 12

USER sebwink

# CPPCHECK
RUN python3 -m pip install --user cpplint
