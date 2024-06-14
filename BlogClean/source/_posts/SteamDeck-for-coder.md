---
title: Coder's SteamDeck 基础开发环境
date: 2024-06-13 16:19:33
tags:
- Handy-Trick
- SteamOS
- Arch Linux
- Steam Deck
categories: 
- Coding
---


# Using brew as package manager
## Install HomeBrew in commandline terminal
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
After installation, please add brew into deck's PATH. Add HomeBrew into `.bashrc` file.
```bash
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/deck/.bashrc
```
Then run this command to enable it.
```bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

## Install the dependency of HomeBrew
If you have sudo permission, run the following command. Trust and import the PGP public key
```bash
sudo pacman-key --init
sudo pacman-key --recv-keys EF0A3CCF
sudo pacman-key --lsign-key EF0A3CCF
sudo pacman -S base-devel
```

# Install VS Code
## 使用 yay 安装 (AUR Helper) Installation by yay
yay 是一个 Arch User Repository (AUR) 助手，它可以简化从 AUR 安装软件包的过程。首先，确保你已经安装了 yay：

```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
安装 yay 后，可以使用以下命令安装 Visual Studio Code：
```bash
yay -S visual-studio-code-bin
```
## 使用 snap 安装 Installation by snap

snap 是一个包管理系统，可以跨不同的 Linux 发行版使用。如果你的系统支持 snapd，可以使用 snap 来安装 
Visual Studio Code：
* 安装 snapd | Install snapd：
```bash
sudo pacman -S snapd
```
* 启用 snapd 服务 | Enable snapd service：
```bash
sudo systemctl enable --now snapd.socket
```
* 创建一个符号链接，使 snap 命令可用 | Enable snapd command：

```bash
sudo ln -s /var/lib/snapd/snap /snap
```
* 安装 Visual Studio Code | Install Visual Studio Code：

```bash
sudo snap install code --classic
```



# What is yay
Yay 是一个用于 Arch Linux 和基于 Arch 的发行版的 AUR（Arch User Repository）助手。AUR 是 Arch Linux 用户维护的软件库，包含了大量的软件包，这些软件包可能没有包含在官方的 Arch Linux 软件库中。Yay（Yet Another Yaourt）旨在提供一个简单易用的命令行工具来管理 AUR 和官方软件包。

以下是 Yay 的一些主要特点和功能：

统一的界面：可以同时处理官方软件库和 AUR 软件包。
自动处理依赖：在安装软件包时自动处理其依赖项。
包搜索：可以搜索官方库和 AUR 中的软件包。
包安装和更新：可以方便地安装和更新软件包。
包删除：可以删除不需要的软件包。
用户友好的交互：提供友好的用户交互界面，减少手动干预的需求。
Yay 的常用命令示例：

* 安装软件包：yay -S <package_name>
* 更新所有软件包：yay -Syu
* 搜索软件包：yay -Ss <search_term>
* 删除软件包：yay -R <package_name>

## HomeBrew and yay
### Homebrew 
#### Cross-Platform:
Homebrew was initially designed for macOS, but it can also be used on Linux, providing a consistent experience across platforms.
#### Independent Management:
Homebrew operates in the user's home directory, avoiding interference with the system package manager. This is suitable for installing software without affecting the system environment.
#### Low Integration with Pacman:
Homebrew does not integrate with Pacman, requiring separate management of packages outside the system's main package manager.
#### Package Coverage
Although Homebrew's repository is extensive, it may not be as comprehensive or up-to-date as the Arch User Repository (AUR) in an Arch Linux environment.
### Yay
#### Deep integration:
Yay is specifically designed for Arch Linux and tightly integrates with Pacman, handling both official repositories and the AUR (Arch Users Repository).
#### Dependency Management
Yay automatically handles package dependencies.*Yay will not install a package that Pacman has already installed if it is required as a dependency. Yay is designed to work seamlessly with Pacman and respects the existing package database maintained by Pacman.*
## Pacman
Pacman (用于 Arch Linux)
* 包格式：使用 .pkg.tar.zst 格式。
* 包管理器：Pacman 是 Arch Linux 的默认包管理器。
## Debian
* .deb
* Apt is the default package manager of debian
# What is snap
Another package manager developed by Canonical.
## Cross-Platform Compatibility
Snaps work on a variety of Linux distributions
## Self-Contained Packages
Each snap package includes all necessary dependencies, libraries, and configuration files.
* This could eliminates issues related to missing dependencies or version conflicts.
* Each snap pack has it own dependencies, although some of them have been installed by sudo in PATH or have been installed by another snap pack. It will cause duplicate dependencies, but they are invisible. This approach also leads to increased disk space usage and potential performance overhead.

