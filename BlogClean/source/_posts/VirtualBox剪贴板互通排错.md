---

title: VirtualBox虚拟机剪贴板互通排错
date: 2024-06-09 23:55:46
categories:

- Coding
tags: 
  - Handy-Trick
  - VirtualBox
excerpt: VirtualBox下虚拟机和实体机无法互相粘贴的解决 | Tutorial for fixing Clipboard sharing error of VirtualBox
---

由于vmware最近官网下载服务器宕机，国内网页和UK官网都无法下载。所以选择了virtualbox安装虚拟机。
virtualbox轻量开源，但是随之而来存在复制粘贴，文件拖拽不生效的问题。在勾选剪贴板互通特性后还是无限循环复制失败，折腾很久留档解决方案。

## 勾选使用主机I/O

![IO_sharing](/images/IO-Sharing.png)

设置->存储->控制器：IDE Controller

勾选使用主机输入输出(I/O)缓存

## 开启固态驱动器特性

![Solid_Storage_Feature](/images/SolidStorage.png)

选择Sata Controller子项中`.vdi`后缀的具体的你的盘，和我图中可能有差异，但是后缀一样。勾选启用`固态驱动器(S)`特性。

## 重启虚拟机

重启虚拟机，分别在虚拟机窗口的菜单中完成下列两项：

* 设备->共享粘贴板->双向（这步我一开始摸索的时候就做了，没做的一定要打开）
* 设备->安装增强功能


![](/images/2024-06-10-00-23-54-image.png)

![](/images/2024-06-10-00-23-00-image.png)

本人使用的是命令行界面的Debian，不便于展示安装流程。如使用Windows镜像的虚拟机Windows在VirtualBox虚拟机里弹出“oracle vm virtualbox guest additions x.x.x Setup”安装软件界面，直接点击“NXET”按钮或“Install”按钮直到出现“Finish”按钮为止。点击“Finish”按钮，重新启动虚拟机。VirtualBox的共享粘贴板功能可以正常使用了.

Ubuntu的用户，在点击安装增强功能后系统会自动挂载光驱。打开挂载文件夹，用命令行进行安装后重启虚拟机即可。

```bash
chmod u+x VboxLinuxadditions run
sudo ./VboxLinuxadditions run
```
