---
title: Windows端口占用解除
date: 2024-07-17 23:31:28
categories:
  - Coding
tags:
- Handy-Trick
- Net

excerpt: 网络端口占用报错的极简解决方式，以及文件占用解除的迁移说明。
---

# Overall 三步走梗概

* 找占用线程PID

* 检查PID对应应用程序确保没杀错

* 直接杀死比赛解除占用

  

# 找占用线程 

以后8888端口占用为例

```powershell
netstat -ano | findstr :8888
```

**注意：**冒号后面不能有空格的

**Caution :**  Do not put any blank after ":"

**输出结果如下：**

```powershell
  TCP    0.0.0.0:8888           0.0.0.0:0              LISTENING       29120
  TCP    [::]:8888              [::]:0                 LISTENING       29120
```



# Double check PID mapped application 进程的死刑复核程序

```bash
tasklist | grep "29120"
```

然后就能看到结果为

```powershell
java.exe                     29120 Console                    1     44,584 K
```

对我的例子而言，是无碍当下的进程，我选择直接杀死。It depends.

# 解除占用

```powershell
taskkill /F /PID 29120
```

**`/F` 参数**：

- **用途**：强制终止指定的进程。
- **词根**：`F` 代表 `Force`。
- **说明**：在正常情况下，有些进程可能不会响应终止请求，使用 `/F` 参数可以强制终止这些不响应的进程。

**`/PID` 参数**：

- **用途**：指定要终止的进程的进程标识符 (PID)。
- **词根**：`PID` 代表 `Process Identifier`。
- **说明**：每个运行中的进程都有一个唯一的 PID，通过指定 PID，`taskkill` 命令可以精确地终止该进程。

# 总结迁移Conclusion & Extension

## 删除文件时占用问题

这个思路还可以用于不能删除文件的解除占用和删除，只不过第一步并非网络端口占用情况检查，而是检查文件的占用情况：

* `openfiles` 命令可以显示或断开远程共享文件的连接，但需要先启用文件对象跟踪。、

* 启用文件追踪

  ```cmd
  openfiles /local on
  ```

* 重启

* 用命令行检查占用

  ```cmd
  openfiles /query | findstr /i "C:\path\to\your\file.txt"
  ```

  

* 然后其余步骤同上最后两步。

## `grep`命令导致的报错和命令支持安装

值得注意的是，本文在查PID对应应用程序的时候，使用了`grep`命令, Windows的Powershell和cmd都是原生不带的。可以通过以下方法下载，或者去掉我上述的`| grep "PID数字"`，用肉眼硬找也行。

* Windows安装`grep`命令支持可以通过管理员模式命令台的`choco`命令, 干净好管理，但前提得装choco（套娃）。

  ```bash
  choco install grep
  ```

  

* Windows安装`choco`

  **打开命令提示符（以管理员身份运行）**：

  - 按 `Win + X`，选择 “Windows PowerShell（管理员）” 或 “命令提示符（管理员）”。

  **运行以下命令安装 Chocolatey**：

  ```powershell
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  ```

  **验证安装**：

  - 关闭并重新打开命令提示符或 PowerShell，然后输入以下命令验证安装是否成功：

    ```
    choco --version
    ```

  
