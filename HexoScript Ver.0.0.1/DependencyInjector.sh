#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Node.js and npm on macOS
install_node_npm_macOS() {
    echo "macOS 系统，开始检查安装 Node.js 和 npm..."
    # Check macOS version
    macos_version=$(sw_vers -productVersion)
    major_version=$(echo "$macos_version" | cut -d '.' -f 1)
    if [ "$major_version" -ge 12 ]; then
        echo "macOS 版本大于等于 12，使用 Homebrew 安装 Node.js 和 npm..."
        brew install node
    else
        echo "macOS 版本低于 12，使用 MacPorts 安装 Node.js 和 npm..."
        # Check if MacPorts is installed
        if ! command_exists port; then
            echo "MacPorts 未安装，开始安装 MacPorts..."
            sudo port install macports
            # Add MacPorts to PATH
            echo 'export PATH="/opt/local/bin:$PATH"' >> ~/.zshrc
            source ~/.zshrc
        fi
        # Install Node.js and npm using MacPorts
        sudo port install nodejs npm
    fi
}

# Function to install Node.js and npm on Windows using Chocolatey
install_node_npm_windows() {
    echo "Windows 系统，开始检查安装 Node.js 和 npm..."
    # Check if Chocolatey is installed
    if ! command_exists choco; then
        echo "Chocolatey 未安装，开始安装 Chocolatey..."
        powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    fi
    # Install Node.js and npm using Chocolatey
    choco install nodejs npm
}

# Function to install Hexo CLI
install_hexo_cli() {
    echo "正在安装 Hexo CLI..."
    sudo npm install -g hexo-cli
    echo "Hexo CLI 安装完成。"
}

# Main script
if [ "$(uname)" == "Darwin" ]; then
    install_node_npm_macOS
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ] || [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    install_node_npm_windows
else
    echo "未知系统，请手动安装 Node.js 和 npm。"
    exit 1
fi

install_hexo_cli
