---
title: Docker-based MariaDB Installation
date: 2024-12-16 13:47:05
tags:
---
# Reason
When I use brew to install MariaDB directly, terminal just warned me like the screenshot shown below.

So I want to have a environment that independent from current database management under MySQL.
I am super sure nobody want to mess up with database on any OS especially in a green hand level to learn database mechanism.

# Install Docker
## MacPorts
I use MacPorts on my hackintosh laptop running Big Sur, which is not supported by brew any more.
```bash
sudo port install docker
sudo port install colima
```

Don't try `sudo port selfupdate` when you are in public library, especially when you are in UK. The rules under those public libraries may block you from access to default port `873` used by rsync. (Also, macPorts uses rsync to update itself). I tried lots of times for the commands `rsync rsync://rsync.macports.org/macports/` under different states of filter firewall. I even changed the DNS server to 8.8.8.8. But it failed all the time with `Operation timed out (60)`  logs from `-v` parameter. When I used my own mobile router with data allowance, it works as a miracle. Just in case someone would face same situation and irritated.

## Brew
I use brew as package manager on Apple M2 Max laptop tho. That makes more sense for most macOS users.
```bash
brew install docker
Brew install colima
```

# Use Docker install MariaDB
## Start Colima
```bash
colima start
```
## Check colima state by
```bash
Colima status
```
When the task is done, use `colima stop` to terminate all process, `colima delete` command could completely remove colima virtual machine.

# Why you need Colima  to start Docker and protect its process
Docker requires a Linux kernel to run. On macOS, Docker Desktop uses a virtualized Linux environment to provide the kernel. Colima also runs a lightweight Linux VM, optimized for container workloads, making it suitable for running Docker on macOS without the full overhead of Docker Desktop.

When Docker is installed from the command line, it relies on the `dockerd` process to run containers. Managing this manually can be cumbersome, requiring additional configuration and management of virtualized environments.

○ Colima simplifies the lifecycle management of the Docker environment:
    § It automatically starts the virtual machine and the Docker daemon (`dockerd`).
    § It ensures proper resource allocation (e.g., CPU, memory, disk space).
    § It isolates and manages the container processes without requiring manual intervention.



Colima Setup with CLI Docker
If Docker is already installed via CLI, you can simply use Colima to manage its processes:
1. Install Colima
```bash
brew install colima
```
2. Start Colima with Docker:
```bash
colima start --runtime docker
```    
3. Verify Docker is Running:
```bash
docker info
```
Colima will manage the Docker runtime, abstracting complexities and ensuring smooth operation.



# Install mariaDB without Colima
# Install mariaDB with Colima
```bash
colima start --runtime docker
```

# Run Docker Daemon Manually
如果只安装了命令行docker，可以尝试手动运行 Daemon，
If only CLI docker installed, there is a manual approch to run Docker Daemon: 
## Install Docker Engine:
```bash
brew install docker-machine
```
Start Daemon
```bash
sudo dockerd
```
Validate if it is runned by command:
```bash
docker info
```

# Why it is unavailable to use only CLI docker
Docker CLI 是一个客户端工具，不能自己管理容器或与底层资源交互。Docker Daemon（dockerd）是核心，它负责：
    •  * 容器的创建和管理。
    •  * 网络和存储的配置。
    •  * 与操作系统资源交互。
所以需要一个运行中的 Docker Daemon（通过 Docker Desktop、Colima 或直接运行 Daemon）来使 CLI 正常工作。

Docker Cli is only a client tool, it could not manage container or interact with underlying resources. It takes charge of 
*Container management and establishment
*Network and Storage Configuration
*Interact with Operational System
So we need a runnable Docker Daemon to make CLI work.

# What's the difference between `dockerd` and `docker-machine`
* dockerd 是核心服务:
    * 它是 Docker 的核心组件，无论运行在哪里（本地或虚拟机中），都需要它来启动和管理容器。
* docker-machine 是工具:
    * 它是一个便捷工具，用于在虚拟机中自动化安装和管理 Docker Daemon（dockerd）。
* `dockerd` is core services component, no matter where it is running. Both Local machine and VM need it to start and manage container.
`docker-machine` is a tool used to automatically install and manage`dockerd` in VM. So it is a tool aiming to simplify the configuration of virtualized environment.

# Rancher Desktop: a GUI tool provides command line approach to manage `dockerd`
## How to use
Rancher Desktop 本质上会设置一个容器运行环境，并配置 containerd 或 dockerd 来与 Docker CLI 集成。
如果你的 Docker CLI 要连接 dockerd，请确保在 Rancher Desktop 设置中选择了 Docker（dockerd） 作为后端。

```
echo $DOCKER_HOST
```
如果输出为空，说明未设置 DOCKER_HOST 环境变量。设置它以指向 Rancher Desktop 的套接字路径：
```bash
vim ~/.zshrc
```
Add following rule into `.zshrc`
```
export DOCKER_HOST=unix://$HOME/.rd/docker.sock
```
Then activate it by 
```bash
source ~/.bashrc  # If your terminal uses Bash shell
source ~/.zshrc   # If your terminal uses Zsh shell
```
Then validate it by `echo $DOCKER_HOST` again, it should work and be shown like this `unix:///Users/yourusername/.rd/docker.sock`.

## 切换到其他 Docker 守护进程时，可能需要更新或移除该变量
什么是 Docker 守护进程？
Docker 守护进程是 Docker 的核心服务，负责管理容器。DOCKER_HOST 是用来指定 Docker CLI 和守护进程（dockerd）之间通信的地址。
为什么需要更新或移除？
如果你未来使用不同的 Docker 守护进程（例如换回 Docker Desktop 或其他方式运行的 dockerd），它们可能会使用不同的 DOCKER_HOST 地址。例如：
    • Rancher Desktop 使用的是 unix://$HOME/.rd/docker.sock
    • Docker Desktop 默认使用 unix:///var/run/docker.sock
此时，如果 DOCKER_HOST 指向错误的地址，就会导致 Docker CLI 无法连接正确的守护进程。
如何应对？
    • 切换守护进程时，更新 ~/.bashrc 或 ~/.zshrc 文件中 DOCKER_HOST 的值。
    • 或者，直接移除 DOCKER_HOST 相关配置，让 Docker 使用默认地址。

## 需要对所有用户生效，可以将配置写入 /etc/profile
### 什么是 /etc/profile？
/etc/profile 是一个全局配置文件。它的作用是为系统中所有用户的登录 Shell 会话设置环境变量。
什么时候需要？
如果你希望 所有用户 都使用相同的 DOCKER_HOST 设置，而不仅仅是你自己当前的账户，可以将 export DOCKER_HOST=unix://$HOME/.rd/docker.sock 写入 /etc/profile。
操作步骤：
1. 编辑 /etc/profile 文件（需要管理员权限）：

```bash
sudo nano /etc/profile
```
2. 添加以下内容：

```bash
exportDOCKER_HOST=unix://$HOME/.rd/docker.sock
```
3. 保存并退出，然后使设置生效：

```bash
source/etc/profile
```
### Caution for set global configuration
* 这个设置会影响系统中所有用户。
* 不推荐在个人设备上设置全局变量，尤其是如果你是唯一用户。
一般情况下，只需要对你自己的账户设置即可，也就是修改 ~/.bashrc 或 ~/.zshrc，无须涉及全局配置。全局配置通常用于多用户服务器环境。

# Set a container for MariaDB
## Commands to pull MariaDB
```bash
docker pull mariadb:latest
```
Then 
```bash
docker run -d \
    --name mariadb-container \
    -e MYSQL_ROOT_PASSWORD=my-secret-pw \
    -p 3306:3306 \
    mariadb:latest
```
## Commands Explaination
1. docker run
这是启动容器的命令。后面的参数指定了容器的名称、环境变量、端口映射等。

2. -d
表示 detached mode，让容器在后台运行。执行命令后不会占用终端。

3. --name mariadb-container
为容器指定一个名字 mariadb-container。如果没有提供名字，Docker 会自动生成一个随机名字。

4. -e MYSQL_ROOT_PASSWORD=my-secret-pw
设置环境变量，MYSQL_ROOT_PASSWORD 是 MariaDB 的 root 用户密码。在这个例子中，密码设置为 my-secret-pw。
    • -e 是用来传递环境变量的选项。
    • 这一步是 MariaDB 初始化所必需的，确保密码足够复杂，不要使用示例中的默认密码。

5. -p 3306:3306
将主机（本地电脑）的端口 3306 映射到容器中的端口 3306。
    • 左侧的 3306 是主机的端口，你通过这个端口连接 MariaDB。
    • 右侧的 3306 是容器内 MariaDB 的默认端口。
    • 这一步让外部应用程序（例如 MySQL 客户端）可以通过 localhost:3306 连接到容器中的 MariaDB。

6. mariadb:latest
指定要使用的镜像 MariaDB 的最新版本（latest 标签）。
    • mariadb 是镜像的名字。
    • latest 是版本号，代表最新的稳定版本。


## 运行后如何使用？
1. 查看运行状态：

```bash
docker ps
```
你会看到容器运行中的详细信息。

2. 连接 MariaDB：
* 使用命令行工具 mysql：

    ```bash
    mysql -h 127.0.0.1 -P 3306 -u root -p
    ```

    输入密码 my-secret-pw。



* 或者使用 GUI 工具（如 DBeaver 或 MySQL Workbench），连接到：
    * 主机名：127.0.0.1
    * 端口号：3306
    * 用户名：root
    * 密码：my-secret-pw
3. 停止容器：
    ```bash
    docker stop mariadb-container
    ```
4. 删除容器：
    ```bash
    docker rmmariadb-container
    ```


○ 确保容器正在运行：

bash
Copy code
docker ps

确保看到类似以下内容，说明容器正常运行：

bash
Copy code
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                     NAMES
abc12345       mariadb:latest "docker-entrypoint.s…"10 seconds ago  Up 10 seconds  0.0.0.0:3306->3306/tcp    mariadb-container
○ 使用 mysql 客户端连接：

bash
Copy code
mysql -h 127.0.0.1 -P 3306 -u root -p
    • -h 127.0.0.1：指定主机为本地。
    • -P 3306：指定端口为 3306。
    • -u root：指定 MariaDB 用户为 root。
    • -p：提示输入 root 用户密码（my-secret-pw）。
○ 输入密码（my-secret-pw），成功后会进入 MariaDB 命令行界面。






# 我用mysql连接这个docker中的数据库以后，能在容器关闭后我可以解除mysql 命令和他的绑定吗，我实际上本地装了mysql才把mariadb装容器里用的

是的，可以解除 mysql 客户端与容器中的 MariaDB 的绑定。在容器停止或删除后，mysql 客户端将失去与容器的连接，你可以重新配置它连接到本地安装的 MySQL。

步骤：
    1. 停止容器：

```bash
docker stop mariadb-container
    ```
    2. 确认容器已停止：

```bash
docker ps
```
确保容器未出现在运行列表中。
    3. 删除容器（可选，防止端口冲突）：

```bash
docker rmmariadb-container
    ```
    4. 重新连接到本地 MySQL：

```bash

mysql -h 127.0.0.1 -u root -p
```
    这是指向本地安装的 MySQL，而非 Docker 中的 MariaDB。

# 切换docker MariaDB 和 local MySQL 
如果你经常在本地和 Docker 容器间切换，可以通过配置环境变量简化操作。
设置别名：
编辑你的 ~/.bashrc 或 ~/.zshrc 文件，添加以下内容：

```bash
# 连接本地 MySQL
alias mysql-local="mysql -h 127.0.0.1 -P 3306 -u root -p"

# 连接 MariaDB 容器
alias mysql-container="mysql -h 127.0.0.1 -P 3307 -u root -p"

```

由于 MySQL 和 MariaDB 使用相同的 mysql 客户端工具，但数据库可能在同一端口（默认 3306）上运行，因此需要避免冲突：
    • 确保本地 MySQL 和 Docker 中的 MariaDB 不在同一个端口上运行。
```bash
docker run -d --name mariadb-container -e MYSQL_ROOT_PASSWORD=my-secret-pw -p 3307:3306 mariadb:latest
```

# How to Check the Listening address and port of  a local MySQL
如何检查本地 MySQL 的监听地址和端口
## Check the MySQL configuration file
检查 MySQL 配置文件
    1. Locate the MySQL configuration file (usually `my.cnf` or `my.ini`, depending on the system)
    
    找到 MySQL 的配置文件（一般是 my.cnf 或 my.ini，根据系统而异）：
```bash
sudo find / -name "my.cnf"
```
Common Paths 常见路径：
    • macOS or Linux: /etc/mysql/my.cnf 或 /usr/local/mysql/my.cnf
    • Windows: C:\ProgramData\MySQL\MySQL Server X.Y\my.ini

Examine the configuration under the [mysqld] section, focusing on the following fields:
查看 [mysqld] 段的配置，重点关注以下字段
```ini
[mysqld]
bind-address = 127.0.0.1
port = 3306
```
Adjust the connection command according to the content of configuration file.
根据配置文件内容调整连接命令：
``` bash
mysql -h [你的bind-address] -P [你的port] -u root -p
```


# 删除 MariaDB 容器后注意事项
If you completely uninstalled container of MariaDB by `docker rm`, the previous stored database files will be lost. It is recommended to bind a local volume to retain the data after the container is removed:
如果你完全删除了 MariaDB 容器（docker rm），之前存储的数据库文件会丢失。建议绑定一个本地卷，以便在删除容器后保留数据：
```bash
docker run -d \
    --name mariadb-container \
    -e MYSQL_ROOT_PASSWORD=my-secret-pw \
    -p 3307:3306 \
    -v /path/to/local/dir:/var/lib/mysql \
    mariadb:latest
```
持久化数据 通过挂载本地目录来实现

```
docker run -d \
    --name mariadb-container \
    -e MYSQL_ROOT_PASSWORD=my-secret-pw \
    -v ~/mariadb-data:/var/lib/mysql \
    -p 3306:3306 \
    mariadb:latest
```
This command creates a new MariaDB container with the following specifications:
• It runs in detached mode (-d).
• It is named mariadb-container.
• It sets the root password for MySQL to my-secret-pw using the -e flag for environment variables.
• It maps port 3307 on the host to port 3306 in the container (-p 3307:3306).
• It mounts a local directory (/path/to/local/dir) to the /var/lib/mysql directory inside the container, ensuring that the database files are stored on the host and not just within the container (-v /path/to/local/dir:/var/lib/mysql).
• It uses the latest tag of the MariaDB image (mariadb:latest).