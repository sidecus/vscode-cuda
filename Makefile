NAMESPACE := sidecus
NAME := torch-devcontainer
COMMIT_ID := $(shell git log -1 --pretty=%h)

# Docker build args
TORCH := 2.2.1
TAG := ${TORCH}.${COMMIT_ID}

.PHONY: env envcn build buildcn

build: env
	export TORCH_VERSION=${TORCH} \
	&& export CUDA_VERSION=11.8 \
	&& export CUDNN_VERSION=8 \
	&& devcontainer build --workspace-folder . --image-name ${NAMESPACE}/${NAME}:${TAG}

buildcn: TAG = cn.${TORCH}.${COMMIT_ID}
buildcn: envcn build
	export TORCH_VERSION=${TORCH} \
	&& export CUDA_VERSION=11.8 \
	&& export CUDNN_VERSION=8 \
	&& export UBUNTU_MIRROR="mirrors.bfsu.edu.cn" \
	&& export UBUNTU_MIRROR="https://mirrors.bfsu.edu.cn/pypi/web/simple/" \
	&& devcontainer build --workspace-folder . --image-name ${NAMESPACE}/${NAME}:${TAG}
