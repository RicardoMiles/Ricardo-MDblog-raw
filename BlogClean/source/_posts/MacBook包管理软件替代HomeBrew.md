---
title: MacBook包管理软件MacPorts替代HomeBrew
date: 2024-05-10 02:33:19
categories:
  - Coding
tags: 
- Handy-Trick
- macOS
- Vagrant
- Software Error Log
- MacPorts
- HomeBrew
excerpt: macOS Big Sur 目前已经不再被HomeBrew最新版本支持，使用brew install npm来安装Node.js和npm会报错。用MacPorts作为替代包管理软件，或者冒险迁移回老版本HomeBrew（本人已失败）.
---
macOS Big Sur 目前已经不再被HomeBrew最新版本支持，使用brew install npm来安装Node.js和npm会卡死并报错。报错信息如下
```bash
🍺 /usr/local/Cellar/libuv/1.48.0: 19 files, 1.2MB, built in 24 seconds ==> Installing node ==> ./configure --without-npm --without-corepack --with-intl=system-icu --shared ==> make install Last 15 lines from /Users/ricardo/Library/Logs/Homebrew/node/02.make: /Library/Developer/CommandLineTools/SDKs/MacOSX11.sdk/usr/include/c++/v1/memory:3445:17: note: candidate function not viable: no known conversion from 'std::unique_ptr<char []>' to 'std::shared_ptr<char const[]>' for 1st argument shared_ptr& operator=(shared_ptr&& __r) _NOEXCEPT; ^ /Library/Developer/CommandLineTools/SDKs/MacOSX11.sdk/usr/include/c++/v1/memory:3453:9: note: candidate template ignored: could not match 'shared_ptr' against 'unique_ptr' operator=(shared_ptr<_Yp>&& __r); ^ /Library/Developer/CommandLineTools/SDKs/MacOSX11.sdk/usr/include/c++/v1/memory:3473:9: note: candidate template ignored: requirement '!is_array<char []>::value' was not satisfied [with _Yp = char [], _Dp = std::default_delete<char []>] operator=(unique_ptr<_Yp, _Dp>&& __r); ^ clang++ -o /private/tmp/node-20240506-44833-3rbwz7/node-v22.1.0/out/Release/obj.target/v8_base_without_compiler/deps/v8/src/wasm/wasm-js.o ../deps/v8/src/wasm/wasm-js.cc '-D_GLIBCXX_USE_CXX11_ABI=1' '-DNODE_OPENSSL_CONF_NAME=nodejs_conf' '-DNODE_OPENSSL_CERT_STORE' '-DICU_NO_USER_DATA_OVERRIDE' '-DV8_GYP_BUILD' '-DV8_TYPED_ARRAY_MAX_SIZE_IN_HEAP=64' '-D_DARWIN_USE_64_BIT_INODE=1' '-DV8_TARGET_ARCH_X64' '-DV8_HAVE_TARGET_OS' '-DV8_TARGET_OS_MACOS' '-DV8_EMBEDDER_STRING="-node.11"' '-DENABLE_DISASSEMBLER' '-DV8_PROMISE_INTERNAL_FIELD_COUNT=1' '-DV8_SHORT_BUILTIN_CALLS' '-DOBJECT_PRINT' '-DV8_INTL_SUPPORT' '-DV8_ATOMIC_OBJECT_FIELD_WRITES' '-DV8_ENABLE_LAZY_SOURCE_POSITIONS' '-DV8_USE_SIPHASH' '-DV8_SHARED_RO_HEAP' '-DNDEBUG' '-DV8_WIN64_UNWINDING_INFO' '-DV8_ENABLE_REGEXP_INTERPRETER_THREADED_DISPATCH' '-DV8_USE_ZLIB' '-DV8_ENABLE_SPARKPLUG' '-DV8_ENABLE_MAGLEV' '-DV8_ENABLE_TURBOFAN' '-DV8_ENABLE_SYSTEM_INSTRUMENTATION' '-DV8_ENABLE_WEBASSEMBLY' '-DV8_ENABLE_JAVASCRIPT_PROMISE_HOOKS' '-DV8_ENABLE_CONTINUATION_PRESERVED_EMBEDDER_DATA' '-DV8_ALLOCATION_FOLDING' '-DV8_ALLOCATION_SITE_TRACKING' '-DV8_ADVANCED_BIGINT_ALGORITHMS' '-DICU_UTIL_DATA_IMPL=ICU_UTIL_DATA_STATIC' -I/usr/local/opt/libuv/include -I/usr/local/opt/brotli/include -I/usr/local/opt/c-ares/include -I/usr/local/opt/libnghttp2/include -I/usr/local/opt/openssl@3/include -I/usr/local/Cellar/icu4c/74.2/include -I../deps/v8 -I../deps/v8/include -I/private/tmp/node-20240506-44833-3rbwz7/node-v22.1.0/out/Release/obj/gen/inspector-generated-output-root -I../deps/v8/third_party/inspector_protocol -I/private/tmp/node-20240506-44833-3rbwz7/node-v22.1.0/out/Release/obj/gen -I/private/tmp/node-20240506-44833-3rbwz7/node-v22.1.0/out/Release/obj/gen/generate-bytecode-output-root -I../deps/v8/third_party/zlib -I../deps/v8/third_party/zlib/google -I../deps/v8/third_party/abseil-cpp -I../deps/v8/third_party/fp16/src/include -O3 -gdwarf-2 -fstrict-aliasing -mmacosx-version-min=11.0 -arch x86_64 -Wall -Wendif-labels -W -Wno-unused-parameter -Wno-invalid-offsetof -std=gnu++17 -stdlib=libc++ -fno-rtti -fno-exceptions -fno-strict-aliasing -MMD -MF /private/tmp/node-20240506-44833-3rbwz7/node-v22.1.0/out/Release/.deps//private/tmp/node-20240506-44833-3rbwz7/node-v22.1.0/out/Release/obj.target/v8_base_without_compiler/deps/v8/src/wasm/wasm-js.o.d.raw -c 1 error generated. make[1]: *** [/private/tmp/node-20240506-44833-3rbwz7/node-v22.1.0/out/Release/obj.target/v8_base_without_compiler/deps/v8/src/wasm/wasm-engine.o] Error 1 make[1]: *** Waiting for unfinished jobs.... rm b60f9a7691f113c43e5e1afeb8c37d85ca84cb86.intermediate cd7188d35a616f284dc9ac8639ade3299cf0fc9f.intermediate 495a14fbfc50f21816e79f0c02d42da5ca93538d.intermediate make: *** [node] Error 2 Do not report this issue to Homebrew/brew or Homebrew/homebrew-core! Error: You are using macOS 11. We (and Apple) do not provide support for this old version. It is expected behaviour that some formulae will fail to build in this old version. It is expected behaviour that Homebrew will be buggy and slow. Do not create any issues about this on Homebrew's GitHub repositories. Do not create any issues even if you think this message is unrelated. Any opened issues will be immediately closed without response. Do not ask for help from Homebrew or its maintainers on social media. You may ask for help in Homebrew's discussions but are unlikely to receive a response. Try to figure out the problem yourself and submit a fix as a pull request. We will review it but may or may not accept it. Do not report this issue: you are running in an unsupported configuration.
```

## 未更新系统和Brew的用户请停止Brew自动更新
由于默认设置可能会导致 Homebrew 自动更新，在解决版本兼容问题后禁用自动更新，以避免再次更新到不兼容的版本。通过设置环境变量来管理这个设置：
```bash
export HOMEBREW_NO_AUTO_UPDATE=1
```
在 shell 配置文件（比如 .bash_profile 或 .zshrc）中添加上述行，然后重新加载配置：
```bash
source ~/.bash_profile  # .bash shell
source ~/.zshrc # .zsh shell
```

## 换用MacPorts
* Download XCOde and Command Line Tools 确保安装了Xcode和命令行工具
* Download by GitHub and change to stable version 用命令行GitHub下载并切换稳定源
  ```bash
  mkdir -p /opt/mports
  cd /opt/mports
  git clone https://github.com/macports/macports-base.git
  cd macports-base
  git checkout v2.9.3 # Change to stable version 换到稳定版
  ```
* Build and Install MacPorts: MacPorts uses autoconf and makefiles for installation. These commands will build and install MacPorts to /opt/local. You can add --prefix to ./configure to relocate MacPorts to another directory if needed.
  ```bash
  cd /opt/mports/macports-base
  ./configure --enable-readline
  make
  sudo make install
  make distclean
  ```
* MacPorts requires that some environment variables be set in the shell. When MacPorts is installed using the macOS package installer, a “postflight” script is run after installation that automatically adds or modifies a shell configuration file in your home directory, ensuring that it defines variables according to the rules described in the following section. 
  
  MacPorts需要设定一些环境变量，在MacPorts使用图形化安装包安装后一个叫`postflight`的脚本会自动运行以配置或修改shell设置，确保macOS定义了合规的环境变量。使用GitHub源代码安装MacPorts的需要手动修改环境变量
  ```bash
    open /etc
    sudo vim /etc/profile
  ```
  加入以下内容
  ```bash
    export PATH=/opt/local/bin:$PATH
    export PATH=/opt/local/sbin:$PATH
  ```
  To verify that the file containing the MacPorts variables is in effect, type env in the terminal to verify the current environment settings after the file has been created. 
  在命令行打`env`来验证当前的环境设定。

## 冒险回退老版本HomeBrew | Take risk to using older versions of HomeBrew
### 访问HomeBrew GitHub仓库
[Homebrew项目官方GitHub仓库](https://github.com/Homebrew/brew)

Click `Commits` or `History` on the page to check the commitment history.

点击 Commits 或 History 产看提交历史
### 搜索支持macOS的版本 | 直接抄答案
最早支持BigSur的HomeBrew是2.6.0，参考：[Homebrew官方网站公告](https://brew.sh/2020/12/01/homebrew-2.6.0/)；

后续信息非常有限，什么时候HomeBrew不再支持Big Sur 或者macOS 11 并没有明确的表示。但是根据 [HomeBrew 3.5.0官方声明](https://brew.sh/2022/06/06/homebrew-3.5.0/#post)最低要求OS X EI Capitan (10.11). 可以看出彼时Big Sur还是受支持的，这个时间点是2022年6月6日。

最好就是回退到这个版本

### 回退版本
#### 定位Brew安装目录

通常 Homebrew 的安装目录在 `/usr/local/Homebrew`（macOS Intel），或者 `/opt/homebrew`（macOS ARM）。你可以通过输入 `brew --prefix` 命令来确认具体的安装位置。

使用 `cd` 命令进入 Homebrew 的安装目录

#### 检查所有可用标签

```bash
git fetch --tags
git tag
```

找到 3.5.0 或相近的版本。

#### 切换到特定版本

```bash
git checkout 3.5.0
```



#### 测试

```bash
brew doctor
```

我在这一步失败了，是因为整个Homebrew仓库的git问题。有时间会将必要包全部迁移到MacPorts后删除干净Brew再安装特定版本。这应该是做Big Sur钉子户的最佳解决方案，
