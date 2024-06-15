---
title: Github仓库身份验证指北 | Github PAT authentication
date: 2024-01-30 01:58:49
categories:
  - Coding

tags: 
- Handy-Trick
- Git
- Github
excerpt: Github身份验证方式更迭导致命令行"git push"命令的前置后续流程发生变化，仓库访问权限的认证方式并不同于命令行显示的提示 | When pushing to GitHub from the command line. you'll be prompted for a username and password. but the password should be generated PAT rather than your account password. Personal Access Tokens took the place of password authentication on Github in 2021.
---
GitHub 在 2021 年 8 月 13 日之后移除了对密码认证的支持，改为使用个人访问令牌（Personal Access Tokens，PAT）来进行身份验证。所以必须使用个人访问令牌替代Github的用户密码进行身份验证以避免报错。

# 使用PAT命令行访问 | Commandline authentication by PAT

## 生成个人访问令牌（PAT）| Generate PAT

1. 进入 GitHub 网站，登录你的账号。
2. 进入你的用户设置页面。
3. 选择 "Developer settings"。
4. 选择 "Personal access tokens" -> "Tokens (classic)"。
5. 点击 "Generate new token"。
6. 给你的令牌起个名字，选择适当的权限（scopes），例如 `repo`。
7. 点击 "Generate token"。
8. **保存好你的令牌**，因为这将是唯一能看到它的机会。

## 使用令牌进行身份验证 | Token Authentication process

在命令行中尝试推送到 GitHub 仓库时，会提示输入用户名和密码。使用你的 GitHub 用户名作为用户名，使用刚才生成的个人访问令牌作为密码。

例如：

```bash
git push https://github.com/<your-GitHub-username>/<your-repo-name>.git # Your remote repo link | GitHub远程仓库地址
Username: RicardoMiles
Password: <your-personal-access-token>
```

## 配置 Git 记住访问令牌 | Configure Git to Remember Token

为了避免每次都要输入访问令牌，可以配置 Git 记住你的访问令牌：

```bash
git config --global credential.helper store
```

然后，再次推送到 GitHub 时，Git 会提示输入用户名和访问令牌，输入一次后，Git 会将它们存储在本地配置文件中，以后就不需要再输入了。

# 使用 HTTPS 方式进行身份验证 | Use the Token Directly in the URL

也可以直接在 Git 命令中包含访问令牌：

```bash
git remote set-url origin https://<your-personal-access-token>@github.com/<your-github-accountname>/<your-repo-name>.git
```

但是，注意不要在公开场合（例如共享的代码仓库或脚本）中暴露访问令牌。

# 使用 SSH 进行身份验证 | Use SSH for Authentication

如果不希望使用个人访问令牌，还可以使用 SSH 密钥进行身份验证：

1. 生成 SSH 密钥：

   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. 添加 SSH 密钥到 ssh-agent：

   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

3. 将 SSH 公钥添加到 GitHub： 复制公钥内容：

   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```

   登录 GitHub，进入 "Settings" -> "SSH and GPG keys" -> "New SSH key"，粘贴公钥内容。

4. 更改远程仓库 URL 使用 SSH：

   ```bash
   git remote set-url origin git@github.com:<your-GitHub-username>/<your-repo-name>.git
   ```

通过以上步骤，应该能够成功使用个人访问令牌或 SSH 密钥进行身份验证，并将代码推送到 GitHub。