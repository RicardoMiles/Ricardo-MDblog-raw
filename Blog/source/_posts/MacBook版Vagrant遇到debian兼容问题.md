---
title: MacBook版Vagrant遇到debian兼容问题
date: 2024-02-19 02:55:16
tags: 
- Handy-Trick
- macOS
- Vagrant
---
## 问题描述 - Issue

当使用Vagrant安装debian 12虚拟机时，Vagrant处理机制是通过```Vagrantfile```文件读取初始化设置和虚拟机。

根据我课程项目需求，我的默认```Vagrantfile```如下，其中特别制定了'```generic/debian```'字段以配置和初始化虚拟机的系统选择。

问题是反复报错该包不存在。我在Vagrant官网能够查到该容器，在其它系统使用相同配置文件顺利创建了虚拟机。

It appears that you're encountering an issue with Vagrant while trying to access the '```generic/debian12```'box.

```bash
Vagrant.configure("2") do |config|
    config.vm.box = "generic/debian12"
    config.vm.synced_folder ".", "/vagrant"
    
    config.vm.network "forwarded_port", guest: 8000, host: 8000

    config.vm.provision "shell", inline: <<-SHELL
      echo "Post-provision installs go here"
    SHELL
end
```

## 机型情况（仅供参考）- Reference Platform Devices

### 笔记本 X86 Laptop
CPU : Intel Core i5 8300h

macOS version : macOS big Sur 11.6.n

MacBook Pro 15'' 2015 - Hackintosh
### 台式机 X86 Desktop
CPU : Intel Core i5 10500

macOS version : macOS monterry 12.3.n

iMac20,1

## 原因 - Reason

Vagrant 1.8.7 和它内置的curl版本和macOS Sierra以及更高版本的macOS中（如：本人测试机型为X86系统上的macOS big Sur）自带的curl不兼容。

There has been a known issue with Vagrant 1.8.7 and the embedded curl version on macOS Sierra and higher version macOS because of incompatible curl version
## 解决方案 - Solution
移除Vagrant嵌入的curl，使用一下命令

To resolove this, you can remove the embedded curl from Vagrant using the following command.

```bash
sudo rm /opt/vagrant/embedded/bin/curl
```
Make sure to also remove the embedded curl when a vagrant box to avoid simillar errors during the box addition process.