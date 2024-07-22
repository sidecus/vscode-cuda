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
    && apt-get install -y acl htop curl wget zip unzip less nano jq sudo build-essential \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install large packages to avoid reinstalling everything upon each requirements.txt change
# Use root here to avoid installing too many files under the vscode user home directory,
# which will lead to large layers when vscode devcontainer updates UID based on local user's UID
# since updateRemoteUserID is true by default (and should be true for security reasons)
COPY requirements.txt /tmp/pip-tmp/
RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt

# Create vscode user, user group and share group, and add the vscode user to the group
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG TEAMNAME=vscode-share
ARG TEAM_GID=1337
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && groupadd --gid $TEAM_GID $TEAMNAME \
    && addgroup $USERNAME $TEAMNAME

# Switch user
USER $USERNAME