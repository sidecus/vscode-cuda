# TORCH/CUDA args
ARG TORCH_VERSION="2.1.2"
ARG CUDA_VERSION="11.8"
ARG CUDNN_VERSION="8"

FROM pytorch/pytorch:${TORCH_VERSION}-cuda${CUDA_VERSION}-cudnn${CUDNN_VERSION}-runtime

ENV PATH="/usr/local/bin:$PATH"
ENV LANG="C.UTF-8"

# [Option] Install zsh
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="true"
# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

COPY ./library-scripts/*.sh ./library-scripts/*.env /tmp/library-scripts/
RUN apt-get clean \
    && apt-get update && export DEBIAN_FRONTEND=noninteractive \
    # Remove imagemagick due to https://security-tracker.debian.org/tracker/CVE-2019-10131
    && apt-get purge -y imagemagick imagemagick-6-common \
    # Install common packages, non-root user
    && bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    # Install setfacl and getfacl
    && apt-get install acl \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/library-scripts

# Create vscode share group, and add the vscode user to the group
ARG VSC_SHARE_GID=1337
RUN addgroup --gid $VSC_SHARE_GID vsc-share \
    && addgroup vscode vsc-share

# Switch user to vscode
USER $USERNAME

# Install large packages to avoid reinstalling everything upon each requirements.txt change
COPY requirements.txt /tmp/pip-tmp/
RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt

# Below are special processing if image requires special mirrors

USER root

# Set Ubuntu apt source
ARG UBUNTU_MIRROR=""
RUN if [[ -n "${UBUNTU_MIRROR}" ]]; then \
        cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
        sed -i s/archive.ubuntu.com/$UBUNTU_MIRROR/g /etc/apt/sources.list && \
        sed -i s/security.ubuntu.com/$UBUNTU_MIRROR/g /etc/apt/sources.list && \
        sed -i s/ports.ubuntu.com/$UBUNTU_MIRROR/g /etc/apt/sources.list; \
    fi

# Set PYPI mirror
ARG PYPI_MIRROR=""
RUN if [[ -n "${PYPI_MIRROR}" ]]; then \
        echo "[global]" > /etc/pip.conf && \
        echo "index-url = ${PYPI_MIRROR}" >> /etc/pip.conf; \
    fi

# Switch user back
USER $USERNAME