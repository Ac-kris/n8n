#!/bin/bash

# 安装 Python 和 distutils
apt-get update
apt-get install -y python3 python3-distutils

# 安装 node-gyp 依赖
npm install -g node-gyp

# 正常构建
pnpm run build
