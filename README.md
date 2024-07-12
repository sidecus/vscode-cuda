# Torch Dev Container for VSCode

Pre-built Torch devcontainer image with CUDA support.

## Usage

See below devcontainer.json example:

```JSON
"name": "torchdevcontainer",
"image": "sidecus/torch-devcontainer:2.2.1.8267797",
"hostRequirements": {
  "gpu": "optional"
}
```

## Docker repo

[Docker Hub](https://hub.docker.com/repository/docker/sidecus/torch-devcontainer/general)

```Shell
docker pull sidecus/torch-devcontainer:2.2.1.8267797
```

## Version Info

- TORCH_VERSION="2.2.1"
- CUDA_VERSION="11.8"
- CUDNN_VERSION="8"
- PYTHON_VERSION="3.10.13"
- UBUNTU_VERSION="20.04"

## What it does

- Creates vscode user and group
- Creates vscode-share group which can be used for data sharing among different dev container users
- Installs zsh and other common packages
- Installs common Python libraries including numpy, torch, jupyter, etc.
