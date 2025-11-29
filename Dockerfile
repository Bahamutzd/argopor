FROM node:alpine3.20

WORKDIR /app

# 先复制 package 文件，利用缓存（可选优化）
COPY package*.json ./

RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    npm install

# 再复制剩余代码（这里要保证 index.js 在仓库根目录）
COPY . .

# Render 的默认端口是 PORT 环境变量（默认 10000），EXPOSE 写 10000 更直观
EXPOSE 10000

CMD ["node", "index.js"]
