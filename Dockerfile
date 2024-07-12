# TORCH/CUDA args
ARG TORCH_VERSION="2.2.1"
ARG CUDA_VERSION="11.8"
ARG CUDNN_VERSION="8"

FROM pytorch/pytorch:${TORCH_VERSION}-cuda${CUDA_VERSION}-cudnn${CUDNN_VERSION}-runtime
ENV PATH="/usr/local/bin:$PATH"
ENV LANG="C.UTF-8"

# Install common packages
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y acl htop curl wget zip unzip less nano jq sudo \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Create vscode user, user group and share group, and add the vscode user to the group
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG TEAMNAME=vsccode-share
ARG TEAM_GID=1337
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && groupadd --gid $TEAM_GID $TEAMNAME \
    && addgroup $USERNAME $TEAMNAME

# Install large packages to avoid reinstalling everything upon each requirements.txt change
USER $USERNAME
COPY requirements.txt /tmp/pip-tmp/
RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt

# Below are special processing if image requires apt or pypi mirrors
USER root
ARG UBUNTU_MIRROR=""
RUN if [ -n "${UBUNTU_MIRROR}" ]; then \
        cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
        sed -i s/archive.ubuntu.com/$UBUNTU_MIRROR/g /etc/apt/sources.list && \
        sed -i s/security.ubuntu.com/$UBUNTU_MIRROR/g /etc/apt/sources.list && \
        sed -i s/ports.ubuntu.com/$UBUNTU_MIRROR/g /etc/apt/sources.list; \
    fi
ARG PYPI_MIRROR=""
RUN if [ -n "${PYPI_MIRROR}" ]; then \
        echo "[global]" > /etc/pip.conf && \
        echo "index-url = ${PYPI_MIRROR}" >> /etc/pip.conf; \
    fi

# Switch user
USER $USERNAME