# 使用Node.js 18作为基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/ripper/node:20.14.0-alpine

# 设置工作目录
WORKDIR /app

# 安装pnpm
RUN npm install -g pnpm@9

# 安装必要的依赖包 (使用apk代替apt-get，因为这是Alpine Linux)
RUN apk update && apk add --no-cache \
    build-base \
    cairo-dev \
    pango-dev \
    jpeg-dev \
    giflib-dev \
    librsvg-dev \
    python3 \
    make \
    g++

# 复制package.json和package-lock.json
COPY package.json package-lock.json* ./

# 安装依赖
#使用国内源加速
#RUN pnpm config set registry https://registry.npmmirror.com && pnpm install
#正常安装
RUN pnpm install

# 复制所有文件
COPY . .

# 构建应用
RUN pnpm build

# 暴露端口
EXPOSE 1717

# 启动应用
CMD ["pnpm", "start"]
