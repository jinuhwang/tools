# syntax = docker/dockerfile:experimental
#
# NOTE: To build this you will need a docker version > 18.06 with
#       experimental enabled and DOCKER_BUILDKIT=1
#
#       If you do not use buildkit you are not going to have a good time
#
#       For reference: 
#           https://docs.docker.com/develop/develop-images/build_enhancements/
ARG ubuntu18.04

ENV DEBIAN_FRONTEND noninteractive

RUN --mount=type=cache,id=apt-example,target=/var/cache/apt \
    apt-get update && apt-get install -y --no-install-recommends \
        unzip \
        wget \
        vim \
        ctags \
        less \
        tree \
        software-properties-common && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/jinuhwang/tools && tools/setup.sh

RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim && \
    vim +PluginInstall +qall

# Setup Oh-my-zsh
RUN yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY dotfile/zshrc /root/.zshrc
COPY dotfile/p10k.zsh /root/.p10k.zsh
RUN chsh --shell /usr/bin/zsh

CMD ["/usr/bin/zsh"]
