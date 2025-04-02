FROM node:20-slim

WORKDIR /app

# 安装依赖
RUN apt-get update && apt-get install -y \
    python3 \
    python3-distutils \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 安装 pnpm
RUN npm install -g pnpm@10.2.1

# 复制 package.json 并安装依赖
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY packages ./packages
COPY turbo.json tsconfig.json ./

# 安装依赖和构建
RUN pnpm install
RUN pnpm run build

# 设置环境变量
ENV NODE_ENV=production
ENV DB_TYPE=postgresdb

# 启动应用
CMD ["node", "packages/cli/bin/n8n", "start"]
