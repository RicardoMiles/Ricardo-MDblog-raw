---
title: SolidWorks报错避坑&安装细节
date: 2024-06-08 16:19:33
tags:
- Handy-Trick
- SolidWorks
- Software Error Log
categories: 
- Software Error Log
---


## 报错避坑
### 常规 - SolidWorks Flexnet Server服务无法启动
* 检查 `C://SolidWorks_Flexnet_Server`路径下`sw_d`是否存在
    * 不存在 -> 去360等杀毒软件或者Windows defender的隔离区查找恢复
    * 存在 -> 启动相关服务
* 计算机 -> 右键管理 -> 服务及应用程序 -> 服务; 找`SolidWorks_Flexnet_Server`，右键属性，弹出窗口常规处启动类型选为`自动`，恢复处均选择为`重新启动操作`，然后可以在任务管理器 (`Ctrl`+`Shift`+`ESC`) 中查看`SolidWorks_Flexnet_Server`是否在运行。
* 则去我的电脑，管理、服务及应用程序、服务，找SolidWorks_Flexnet_Server，右键属性，弹出窗口常规处启动类型选为自动，恢复处均选择为重新启动操作，然后可以在任务管理器中查看SolidWorks_Flexnet_Server是否在运行。
* 则去我的电脑，管理、服务及应用程序、服务，找SolidWorks_Flexnet_Server，右键属性，弹出窗口常规处启动类型选为自动，恢复处均选择为重新启动操作，然后可以在任务管理器中查看SolidWorks_Flexnet_Server是否在运行。
* 按序管理员权限运行`server_remove`和`server_install`

### 特殊 - 上一步中反复无法启动SolidWorks Flexnet Server服务
右键此电脑或计算机->单击属性-> 在弹出新窗口中单击高级系统设置 -> 在弹出窗口的计算机名tab下看计算机全名，进行排查（描述根本不重要）。如要更改选择下方更改。
![此电脑->属性](/images/此电脑-属性.png)
![此电脑->属性](/images/此电脑-属性2.png)
![高级系统设置](/images/高级系统设置.png)
![计算机命名](/images/计算机全名.png)
* 最基本的，不能有中文字符。
* 不能有特殊字符，比如`'`或者`"`, 本人代安装的用户实例存在这种情况，计算机命名中虽然全英文，但存在`'s`。


## 安装细节
### 安装之前先做准备
* 先做准备在安装.iso文件，先做准备，先做准备！！！
    * 准备指的是先部署Flexnet Server并安装启用服务
        * 打开`_SolidSQUAD_`文件夹
        * 找到`sw2021_network_serials_licensing.reg`，双击运行它，根据安装的版本而言，文件名前缀有可能是sw2022、sw2020等。选择“是”和“确定”。
        * 找到`SolidWorks_Flexnet_Server`文件夹，复制到C盘根目录下
        * 进入该文件夹，按序以管理员权限运行`server_remove.bat``server_install.bat`,未开启文件名后缀显示的电脑为显示为`server_remove`和`server_install`，操作一致，这两对等效的。
        * 等待命令行界面显示为`SolidWorks Flexnet Server服务已经启动成功`，就可以对.iso安装文件进行安装了。

### 注册表文件相关
* 有老版本会导致数据库注册表有差异无法安装，跳过电子模块的安装即可。
* Flexnet Server 相关注册表文件在重启后（如果因安装其他环境和更改计算机名重启过）需要再次双击添加
### 善后维护
* `SolidWorks_Flexnet_Server`一定维持在C盘根目录保持不动，即使安装完成后续不能误删
* 要替换安装文件夹中的内容，一定要替换。默认安装直接在`\ProgramData`目录下找到SolidWorks Corp. 文件夹里面替换；自定义安装位置的话，在安装目录的同级目录更换。

## 资源链接
* 官方安装包清华网盘镜像：https://cloud.tsinghua.edu.cn/d/79df7b0de78c4b278f01/
* 辅助文件包 `_SolidSQUAD`：https://pan.baidu.com/s/1-cT-Lqad_9PMr9rqnmsAng?pwd=5fba 提取码: 5fba (解压密码：xifengboke.com)

