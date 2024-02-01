#!/bin/bash

tag=cn-torch2.1.2-cuda11.8-cudnn8

docker build \
    -t sidecus/vscode-cuda:$tag \
    --build-arg UBUNTU_MIRROR="mirrors.bfsu.edu.cn" \
    --build-arg PYPI_MIRROR="https://mirrors.bfsu.edu.cn/pypi/web/simple/" \
    .

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Error occured building image."
    exit $retVal
fi

docker push sidecus/vscode-cuda:$tag
