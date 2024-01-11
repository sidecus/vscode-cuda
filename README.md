# vscode-cuda
VSCode dev container base image with CUDA support.
Kudos to [twsl's PR](https://github.com/microsoft/vscode-dev-containers/pull/1176)

# Image repo
[Docker Hub](https://hub.docker.com/repository/docker/sidecus/vscode-cuda/general)

# Version Info
TORCH_VERSION="2.1.2"
CUDA_VERSION="11.8"
CUDNN_VERSION="8"
PYTHON_VERSION="3.10.13"
UBUNTU_VERSION="20.04"

# Others
 - Creates vscode user and group
 - Installs zsh and commonly used libs
 - Creates vsc-share group which can be used for data sharing among different dev container users
 - Installs commonly used Python libraries including numpy, torch, jupyter, etc.
