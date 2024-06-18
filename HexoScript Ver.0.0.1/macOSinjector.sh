#!/bin/bash

# 检测操作系统
OS=$(uname -s)

if [ "$OS" = "Darwin" ]; then
    echo "操作系统是 macOS"

    # 获取macOS版本
    MACOS_VERSION=$(sw_vers -productVersion)
    MACOS_MAJOR_VERSION=$(echo $MACOS_VERSION | cut -d '.' -f 1)
    MACOS_MINOR_VERSION=$(echo $MACOS_VERSION | cut -d '.' -f 2)

    if [ "$MACOS_MAJOR_VERSION" -ge 12 ] || ([ "$MACOS_MAJOR_VERSION" -eq 11 ] && [ "$MACOS_MINOR_VERSION" -ge 0 ]); then
        echo "macOS版本 >= 12"

        # 检查Node.js和npm是否安装
        if ! command -v node &> /dev/null; then
            echo "Node.js 未安装，使用brew安装"
            if ! command -v brew &> /dev/null; then
                echo "Homebrew 未安装，正在安装Homebrew"
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install node
        else
            echo "Node.js 已安装"
        fi

        if ! command -v npm &> /dev/null; then
            echo "npm 未安装，正在安装npm"
            brew install npm
        else
            echo "npm 已安装"
        fi

    else
        echo "macOS版本 < 12"

        # 检查是否安装MacPorts
        if ! command -v port &> /dev/null; then
            echo "MacPorts 未安装，正在安装MacPorts"
            /bin/bash -c "$(curl -fsSL https://distfiles.macports.org/MacPorts/MacPorts-2.7.2.tar.bz2)"
            cd MacPorts-2.7.2
            ./configure && make && sudo make install
            cd ..
            rm -rf MacPorts-2.7.2
        else
            echo "MacPorts 已安装"
        fi

        # 使用MacPorts安装Node.js和npm
        if ! command -v node &> /dev/null; then
            echo "Node.js 未安装，使用MacPorts安装"
            sudo port install nodejs
        else
            echo "Node.js 已安装"
        fi

        if ! command -v npm &> /dev/null; then
            echo "npm 未安装，使用MacPorts安装"
            sudo port install npm
        else
            echo "npm 已安装"
        fi
    fi

else
    echo "操作系统不是macOS，当前脚本仅支持macOS"
fi

