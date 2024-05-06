<html>
    <header class="header"> 
        <a href="https://ricardopotter.github.io">
        Ricardo-MDblog-raw 博客草稿箱
            <style>.header{
                height:100px；
            }</style>
        </a>
    </header>
</html>

<style>
        .header{
            height:100px；
        }
</style>

The raw material of Ricardo's blog content, MD file based.

[TOC]
<html>
    <body>
        <br>
        <p>Resources文件夹全部都是草稿媒体文件；<br>Blog文件夹是基于<strong>Hexo</strong>框架搭建的博客模板源文件，亦是我博客的草稿箱状态；</p>
        <p><a href="https://ricardopotter.github.io">博客直链 Blog link</a></p>
        <p></p>
    </body>
</html>


## 发布流程 Tutorial For Updating-flow

### 新建文章

New blog update.

```bash
hexo new "TitleForBlog" 
```
### 发布前流程

Regular preps for updates.

```bash
hexo g         #生成页面       Generate updated blog
hexo s         #启动预览       Preview locally
```
### 异常处理

Error handling in case web browsers' cache still alive.

```bash
hexo clean     #清除缓存       Clean cache
hexo g
```
### 发布
部署到承载了GitPage静态网页的GitHub仓库。
Post new version of static blog. Deploy the updates of blog to its GitPage‘s repo.
```bash
hexo g    
hexo d         #部署          Deploy to linked gitHub repo 
```

## 常用命令 Basic Hexo Command 
```bash
hexo new "name"             # New blog article
hexo new page "name"        # New page
hexo g                      # Generate with latest updates 
hexo d                      # Deploy to related repo
hexo g -d                   # Generate and deploy to related repo
hexo s                      # Start a local preview
hexo clean                  # Cleanup cache
hexo help                   # Official help
```

## 环境搭建 Enviroment for Hexo

Hexo is based on Node.js and npm, npm is basically contained in Node.js. So install Node.js first.

直接下载Node.js
```bash
brew install node # macOS
```

```PowerShell
choco install npm # Windows
```



Check `npm` `Git` `Node.js` have been installed in local machine
```bash
git --version
npm -v
node -v
```

## 主页隐藏全文教学 Home page hide blog details settings

### 方法一

用文本编辑器打开 `/Blog/themes` 目录下的`_config.yml`文件，找到这段代码，如果没有则新建，一些主题并不支持这种方法：

```js
# Automatically Excerpt. Not recommend.
# Please use <!-- more --> in the post to control excerpt accurately.
auto_excerpt:
  enable: false
  length: 150
```
把 enable 的 false 改成 true ，然后 length 是设定文章预览的文本长度,修改完成。

### 方法二

编辑.md文件时，在内容中加上 `<!--more-->`，首页和列表页展示的文章内容为 `<!--more-->` 之前的部分。

### 方法三
在文章的 `front-matter` 中添加 `description`以提供文章摘录
使用这种方式生成的描述信息在文章的详情页是不再显示的。

### 区别
本博客多数采用方法三；
第一种修改 _config.yml 文件的效果是会格式化你文章的样式，直接把文字挤在一起显示，最后会有 …。
而第二种加上 `<!--more-->`展示出来的就是你原本文章的样式，最后不会有…。