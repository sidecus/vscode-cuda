#!/bin/bash

docker build -t sidecus/vscode-cuda .
# docker tag sidecus/vscode-cuda:latest sidecus/vscode-cuda:torch2.1.2-cuda11.8-cudnn8
docker push sidecus/vscode-cuda
