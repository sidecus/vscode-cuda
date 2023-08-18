#!/bin/bash

docker build -t sidecus/vscode-cuda .

docker tag sidecus/vscode-cuda:latest sidecus/vscode-cuda:torch1.11.0-cuda11.3-cudnn8
