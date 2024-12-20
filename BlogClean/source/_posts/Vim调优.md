---
title: Vim调优（个人向）
date: 2024-03-15 00:15:03
categories:
  - Coding
tags: 
- Handy-Trick
- Vim
excerpt: Vim的个人偏好调教，优化至更适合熟悉图形化用户界面的用户使用 | Handy trick of vim preference and settings.
---
### ***1. vim调优***

#### ***1.1  缘起动因***
【太长可以不看】简要概括，`Windows`版Vim/gVim由于默认配置中的`backup`特性，产生大量备份文件造成git仓库管理异常脏乱。
<details>
  <summary>点击查看详情</summary>

通过简简单单的修改.gitignore文件来忽略大量的`.un~`和`*.*~`文件，仅仅只能维持remote仓库的整洁，并且由于备份文件扩展名是在原扩展名基础上加"~"，因此防不甚防，`.gitignore`很难全部覆盖。

并且本地的文件结构也显得异常脏乱，鉴于Vim本身自带的编辑保护机制已经很健全，并且使用git管理，有多个可回滚目标，因此选择关闭`Vim`的`backup`特性。自此开始了一场挠头不断的折腾之旅。
</details>

#### ***1.2  关闭Vim 自动备份功能***

需要调整`.vimrc`文件，在`Windows`上显示为`_vimrc`文件或者`.vimrc`文件，两者有其一即可,会冲突。以笔者Win11`22H2`的两部机型操作来说，不存在差异，随便改动一个就可以，但是**`.vimrc`位置**很有讲究。`Vim`本身并没有在PATH生成这个文件，默认的vimrc和用户级别vimrc并不冲突，用户vimrc堆叠覆盖在默认vimrc上，该文件就是用作vim的配置的，可以理解成很多软件的.config文件。

- 确定`.vimrc/_vimrc`位置
    - 	直接进Vim，在Vim中执行命令`echo $HOME`来显示Vim配置文件所在位置
    -   手动搜索：GUI界面的文件管理器中打开 C:\Users\你的本机用户名 路径，该路径下一般存着本机的`.vimrc/_vimrc`;或者在该路径打开命令台输入指令`ls | grep "vimrc"`模糊搜索`.vimrc/_vimrc`二者之一。
    -   插播下，Windows的power shell命令台不支持grep命令，内置指令又很复杂，可通过Scoop或者Choco等包管理软件，管理员模式的powershell下几秒钟装一个grep包一劳永逸`choco install grep`。
    -   有就直接改，没有就创一个文件，命令都是一样的`vim _vimrc`,以下内容添加进去就达成了关闭自动同步特性。
        ```vim
        set nobackup
        set nowritebackup
        ```
- Vim下加载配置     
    - 	直接命令行一行进入Vim
        ```bash
        vim
        ```  
    -   vim主界面直接输入
        ```bash
        :source $MYVIMRC
        ```
        ![vimLoadVimrc](/images/vim_load_vimrc.png)

退出后使用`Vim`创建或者编辑任意文件验证，解决。


#### ***1.3  解决Vim 退格删除键无法删除的问题***
随着自动备份问题的解决，验证`Vim`日常使用的时候，一个更严重的问题产生了：使用`Vim`编辑文件在i模式编辑模式下无法使用退格键`Backspace`删除非本次编辑生成的内容，并且无法删除换行符。`Delete`也仅仅只能删除一个字符。

根据检索排查，发现新的`_vimrc/.vimrc`文件覆盖了系统自带的默认属性，使得一些`Vim`默认的其他特性消失了，比如对于退格`backspace` 的定义(而这恰恰就是退格失效的原因)，比如默认语法高亮都消失了。

- 因此再次编辑`_vimrc`,过程不再赘述，添加这行代码。
    ```bash
    set backspace=indent,eol,start
    ```
- 目前`_vimrc`文件内容总体如下
    ```bash
    set nobackup
    set nowritebackup
    set backspace=indent,eol,start
    ```

#### ***1.4  解决Vim 无法和系统剪切板完全交互 单向粘贴无法复制***
既然走到这步，索性将win下`Vim`的另外一个痛点解决。即跑在Windows Terminal或者Powershell之下的命令行`Vim`都只能由外部向`Vim`内粘贴内容，但是`Vim`内代码却无法复制出去。也装过各种插件，其实没用✌。因此在摸爬滚打中将解决方案和摸索思路分享下。也许在我摸索的头几步大部分人类似的问题已经解决了。

- 首先确保系统本身和`Vim`版本都支持剪贴板Clipboard功能
    
    - 就我个人的情况而言，系统`Windows™` 11 `22H2`，自`Windows™`10大版本起甚至都支持剪切板历史了
    - 就我安装的Vim而言，win发行版的`Vim`不论是下载安装包手动安装，还是使用Scoop或者Chocolatey这类包管理软件进行命令行安装，都是带有`gVim`可视化版本的整个套件，必然支持剪切板，并且已经能读取命令台Power shell外部的系统剪切板，就是无法调用本地。
    - `Linux`用户有可能默认安装的老版本不支持Clipboard功能。最快的解决版本是用`apt`安装一个`gVim`
    -检查`Vim`支持该特性与否
        ```bash
        vim --version | grep "clipboard"
        ```
        ![VimFeatureClipboardSupport](/images/vim_feature_clipboard_support.png)
        - 如图所示输出结果为`+clipboard`,即为支持；如显示为`-clipboard`则表示不支持

- 调整`_vimrc/.vimrc`文件来确保`Vim`调用系统默认剪切板
    - 将下列命令加入`_vimrc/.vimrc`
        ```bash
        set clipboard=unnamedplus
        ```
    - 如果无效的话，建议删除。两种检验有效与否的方法。
        - 使用`Vim`自带的复制命令，显式使用`"*`寄存器复制,到外部的应用软件进行粘贴。笔者失败了。
        - 使用`Ctrl`+`C`的系统级快捷键复制命令太内Vim正在编辑的文本。笔者还是失败了
- 100%有效的方法：通过`Vim`配置文件`_vimrc/.vimrc`直接自定义命令映射，用`Windows`自带的Power shell命令行工具指令clip.exe来实现访问系统剪切板。
    - 将下列命令加入`_vimrc/.vimrc`以补足`Vim`向外复制的功能
        ```vim
        " 复制到系统剪贴板
        vnoremap <C-c> :w !clip<CR><CR>
        ```
    - 以备还有其他苦主，连`Windows`向`Vim`内粘贴也遇上问题，这里提供相对应的另一条命令
        ```vim
        " 从系统剪贴板粘贴
        nnoremap <C-v> :r !powershell Get-Clipboard<CR><CR>
        ```
    - 我本人至此`_vimrc`文件全貌，可见仓库`/src`文件夹
    
        [点击下载 "_vimrc"](downloads/your_file_name)

        ```vim
        set nobackup
        set nowritebackup
        set backspace=indent,eol,start
        set number
        vnoremap <C-c> :w !clip<CR><CR>
        ```


#### ***1.5  微调Vim参数***
- 我只是一个正式学习CS不满一年的绿手，非`Vim`重度使用者。但是在快速修改内容的同时，也有必要稍稍提升下`Vim`的基础使用体验，我的最终版本`_vimrc`添加了代码高亮、行数显示和必要时的鼠标启用特性。
    - 最终自用版本`_vimrc`
    - 代码高亮、行数显示、鼠标特性均已注释
        ```vim
        set nobackup
        set nowritebackup
        set backspace=indent,eol,start
        set number "行数显示
        syntax enable "代码高亮
        set mouse=a "鼠标特性支持
        vnoremap <C-c> :w !clip<CR><CR>
        ```

- 步入现代了，还有人再用`Vim`✌。原因有很多，初见时只觉得迂腐，稍微熟悉一点，才渐渐意识到Geek们口中无上限的`Vim`到底是多么重剑无锋，天下武功唯快不破的基调下这把倚天剑轻盈灵巧。在初学Coding的周芷“弱”们手中，这把武器谈不上最相称，副作用可能还不小；但是王重阳手中，倚天剑称得上举世无双。有极爱折腾的圣手，甚至出过`Vim`爆改IDE的教程。仅作一点感慨。
