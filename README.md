# Torch Dev Container for VSCode

Torch dev container image with CUDA support.

## Docker image repo (pre-built dev container)

[Docker Hub](https://hub.docker.com/repository/docker/sidecus/torch-devcontainer/general)

```Shell
docker pull sidecus/torch-devcontainer:2.2.1.9026e18
```

See below devcontainer.json example:

![image](https://github.com/sidecus/vscode-cuda/assets/4399408/5f818621-335f-4ba9-9d00-b62d0ac676c9)

## Version Info

- TORCH_VERSION="2.2.1"
- CUDA_VERSION="11.8"
- CUDNN_VERSION="8"
- PYTHON_VERSION="3.10.13"
- UBUNTU_VERSION="20.04"

## What it does

- Creates vscode user and group
- Installs zsh and commonly used libs
- Creates vsc-share group which can be used for data sharing among different dev container users
- Installs commonly used Python libraries including numpy, torch, jupyter, etc.
