#!/bin/bash

docker build -t sidecus/vscode-cuda .

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Error occured building image."
    exit $retVal
fi

docker tag sidecus/vscode-cuda:latest sidecus/vscode-cuda:en-torch2.1.2-cuda11.8-cudnn8
docker push sidecus/vscode-cuda
