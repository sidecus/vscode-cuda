# vscode-cuda
VSCode dev container base image with CUDA support.
Kudos to [twsl's PR](https://github.com/microsoft/vscode-dev-containers/pull/1176)

## Docker image repo
[Docker Hub](https://hub.docker.com/repository/docker/sidecus/vscode-cuda/general)

```Shell
docker pull sidecus/vscode-cuda:cn-torch2.2.1-cuda11.8-cudnn8
```

## Dev container (pre-built image)

```Shell
docker pull sidecus/vscode-cuda:devcontainer-cn-torch2.2.1-cuda11.8-cudnn8
```

How to use:

See below devcontainer.json example:
![image](https://github.com/sidecus/vscode-cuda/assets/4399408/5f818621-335f-4ba9-9d00-b62d0ac676c9)


## Version Info
- TORCH_VERSION="2.1.2" 
- CUDA_VERSION="11.8"
- CUDNN_VERSION="8"
- PYTHON_VERSION="3.10.13"
- UBUNTU_VERSION="20.04"

## What it does
 - Creates vscode user and group
 - Installs zsh and commonly used libs
 - Creates vsc-share group which can be used for data sharing among different dev container users
 - Installs commonly used Python libraries including numpy, torch, jupyter, etc.
