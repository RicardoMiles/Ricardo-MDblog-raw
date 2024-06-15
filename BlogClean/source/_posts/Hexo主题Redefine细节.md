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