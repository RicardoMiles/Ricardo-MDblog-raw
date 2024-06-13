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
使用 yay 安装 (AUR Helper)
yay 是一个 Arch User Repository (AUR) 助手，它可以简化从 AUR 安装软件包的过程。首先，确保你已经安装了 yay：

bash
复制代码
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
安装 yay 后，可以使用以下命令安装 Visual Studio Code：

bash
复制代码
yay -S visual-studio-code-bin
使用 snap 安装
snap 是一个包管理系统，可以跨不同的 Linux 发行版使用。如果你的系统支持 snapd，可以使用 snap 来安装 Visual Studio Code：

安装 snapd：

bash
复制代码
sudo pacman -S snapd
启用 snapd 服务：

bash
复制代码
sudo systemctl enable --now snapd.socket
创建一个符号链接，使 snap 命令可用：

bash
复制代码
sudo ln -s /var/lib/snapd/snap /snap
安装 Visual Studio Code：

bash
复制代码
sudo snap install code --classic
'

