# 使用官方的 Go 语言镜像作为基础镜像
FROM golang:1.22.4-alpine3.20 AS builder

# 设置工作目录
WORKDIR /app

# 将 go.mod 和 go.sum 文件复制到工作目录
COPY go.mod ./

# 下载依赖
RUN go mod download

# 将项目文件复制到工作目录
COPY . .

# 编译项目
RUN go build -o myapp

# 使用较小的基础镜像运行应用
FROM busybox:latest

# 设置工作目录
WORKDIR /root/

# 从构建阶段中复制编译后的二进制文件
COPY --from=builder /app/myapp .

# 设置容器启动时运行的命令
CMD ["./myapp"]
