---
title: Java开发环境极简配置
date: 2024-03-15 13:27:21
categories:
  - Coding
tags: 
- Handy-Trick
- Java
excerpt: Windows命令行安装Java开发环境 | CommandLine installation of Java dev environment for Windows users.
---

不得已使用重型IDE intellijIDEA(以下简称"IDEA")，以便课程项目debug。
基本的开发环境，以最新LTS版jdk17为标准。

#### ***1.1 要求***
- vagrant debian 12 虚拟机安装基本的jdk
- 物理机安装jdk，maven和Java重型IDE
- 不破坏两者的环境，不冲突
- 最小化安装，最简单维护

#### ***1.2 注意事项***
- 在virtual-Vagrant安装jdk之前先行安装实体机的java环境，否则会被共享jdk，要设置HOME_JAVA的环境变量将变麻烦
- 安装虚拟机的maven时候，不能单纯像debian12的Linux教程一样安装maven后配置环境，无需这一步，这一步将会导致`/etc/environment`覆盖掉虚拟机的最基本配置，导致永远无法通过命令台`vagrant halt`命令，且永远只能访客登录
- `Windows™`下先行安装chocolatey包管理软件，以便choco接替用户的手动配置环境变量以及手动“下一步”安装后手动删除安装包
    ```powershell
    Set-ExecutionPolicy Bypass -Scope Process -Force
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    ```
    - 验证安装
    ```powershell
    choco -v
    ```

#### ***1.3 实现命令行***

- `Windows™`

    请一定注意要在管理员权限下打开power shell，来使用choco，原理是：Choco会配置环境变量，需要高权限。

    - jdk

        ```powershell
        choco install openjdk17 17.0.2.20220913
        ```

    - maven
        ```powershell
        choco install maven
        ```

    - IDEA
        ```powershell
        choco install intellijidea-community
        ```
- Vagrant虚拟机debian 12
    ```bash
    sudo apt upgrade
    sudo apt install default-jdk
    java -version
    sudo apt install maven
    mvn -version
    ```
    千万千万不要动环境，以上！


