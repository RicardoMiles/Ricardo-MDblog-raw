---

title: Hexo主题Redefine细节
date: 2024-06-15 01:55:16
categories:
- Coding
tags: 
  - Handy-Trick
  - Hexo
  - Redefine theme
excerpt: 使用Redefine主题一些Front Matter头信息的差异细节以及首页自定义显示特性调校 | 

---

# 文章置顶

要实现顶置的文章，需在文章页添加 `sticky` 属性，`sticky` 值越大，顶置的文章越靠前，参考如下。

```markdown
---
title: Redefine 主题使用指南
date: 2022-9-28 11:45:14
tags: [Hexo]
categories: [Hexo]
sticky: 999
---
```

# 文章头图

在文章的front matter 中增加

```markdown
thumbnail: "链接"
```

# 文章摘要

## 自定义首页文章摘要

![Screen Shot 2022-12-20 at 4.42.04 PM](https://evan.beee.top/img/Screen%20Shot%202022-12-20%20at%204.42.04%20PM.png)

配置流程：

1. 在文章页的 [front matter](https://hexo.io/docs/front-matter.html) 添加 `excerpt:"摘要"` 属性，至此，就可以看到首页摘要更改了
   
   示例：
   
   ```markdown
   ---
   title: Excerpt Test
   date: 2022-12-20 12:12:12
   tags: Excerpt
   categories: Excerpt
   excerpt: "这是文章摘要 This is the excerpt of the post"
   ---
   ```

## 关闭某一文章摘要

如要关闭文章摘要

![Screen Shot 2022-12-23 at 11.21.21 AM](https://evan.beee.top/img/Screen%20Shot%202022-12-23%20at%2011.21.21%20AM.png)

配置流程：

在文章页的 [front matter](https://hexo.io/docs/front-matter.html) 添加 `excerpt: false` 属性，至此，就可以看到首页摘要消失了

示例：

```markdown
---
title: Excerpt Test
date: 2022-12-20 12:12:12
tags: Excerpt
categories: Excerpt
excerpt: false
---
```

# Gitalk 评论系统

截止到目前，最新版本的Redefine主题仍未修复关于Gitalk评论系统的bug。依靠更改整个Hexo项目以及主题的`_config.yml`中的Gitalk配置和`_config.redefine.yml`中的配置都无法解决Gitalk无法初始化的问题。

[BUG:Gitalk未在入口页面引入导致下一次访问带评论不能正常加载 · Issue #343](https://github.com/EvanNotFound/hexo-theme-redefine/issues/343)



# Update 更新

## Commandline update for redefine theme

* Maintained by npm | 用npm更新
  
  ```bash
  npm install hexo-theme-redefine@latest
  ```

* Maintained by Git | 用Git更新
  
  ```bash
  cd /themes
  git clone https://github.com/EvanNotFound/hexo-theme-redefine.git themes/redefine
  ```

## Maintain Configuration 迁移配置

有时候，更新完主题后，你的配置文件会有一些新的配置项，或者删除了一些配置项，或者对配置项名称进行了改动，这时候你需要将这些配置同步到你的配置文件中。

可以使用 VS Code 等编辑器的 `文件比对` 功能，将新旧配置文件进行对比，然后将新的配置项添加到你的配置文件中。

例如，以下分别是两个不同安装方法的 VS Code 文件对比教程：

* Git Installation
  
  在 VS Code 中，按住 `Ctrl`(windows) 或者 `Command`(macos) 键，
  
  选中旧配置文件(`_config.redefine.yml`)，
  
  再选中新配置文件(`themes/hexo-theme-redefine/_config.yml`)。
  
  然后点击 `比较选中的文件` 或者 `Compare Selected` 按钮，即可看到两个文件的对比结果，然后再进行迁移，缩进请严格按照旧配置文件的缩进来进行迁移。

* npm Installation
  
  在 VS Code 中，按住 `Ctrl`(windows) 或者 `Command`(macos) 键，
  
  选中旧配置文件(`_config.redefine.yml`)，
  
  再选中新配置文件(`node_modules/redefine/_config.yml`)。
  
  然后点击 `比较选中的文件` 或者 `Compare Selected` 按钮，即可看到两个文件的对比结果，然后再进行迁移，缩进请严格按照旧配置文件的缩进来进行迁移。