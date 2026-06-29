---
title: Git-the-Shit-Done
date: 2026-06-29 19:12:51
tags:
---

Who the heck will show explicit API Key on GitLab repo in 2026? Exactly me...

But I promise, that is an accident due to too rigid policy of CICD access control. There is a VM server runs Ubuntu LTS 24.04 which is perfect specs for our team. Unfortunately, the firewall policy of this VM is hella strict. No internet access, no intra database server access. Basically a isolated offline machine has limited connection to some prepared internal sites. Even the pip is a back-up version of ourselves... Lots of python packaging missed. Tho I tried to explore all the 邪招s for bypassing policy to deploy stuff on the VM, the DevOps is still a pain in the arse for later on daily data extraction & processing.

Everyone learned computer science / data science or EE, whatever, knows putting large files and API Key in Git repo is never the best practice. But somehow, it helps deployment and application to run asap, isn't it? Idiot Ricardo put all the raw data and database in that remote private repo. Use `git push` and `git pull` to maintain the project. But he forgot remove or using gitignore feature to hide API Key...

### Stage0 - LFS and DevOps Strategies thinking
In order to make the unstable and non-robust project maintained in a real-time intra users env, he has the idea:
* For some data like logs, server side (VM local) always has priority and authority
* For some codebase change from local developing machine(macOS and Windows working laptop), files like codebase have absolute priority and authority

That idea was delved into more detailed level:
* When developing machine push, always neglect a specific group & set of files with the log function.
* The ignoring mechanism shouldn't be implemented by `.gitignore` as it has been tracked and pushed earlier
    * Log files on server side should be always tracked and pushed into repo
    * `.gitignore` is necessary to be tracked in this repo due to cross-platform programming language and virtual environment
* When server pull something from repo, it should be a protective pull. I expect server add & commit & push all the data modification first, then pull code base modification from remote origin.

After analysing my idea, what I need is actually a local version of `.gitignore` module or function that doesn't affected existing `.gitignore` file on dev machines. That will helps dev machines always to throw away fake log during debugging and build version iteration. Also, I need a protective pull overwrites the ordinary `git pull` provided by git itself. Based on `git pull` but more advanced and refined for my VM codebase.


### Stage1 - API Removal but More Than Removal
I confess...

The API flaws is the most idiot thing I've done in past few months before the next week internal audit...

Even there is no audit, I shouldn't have push API. But realistically, at least it is safe bc it is a private deployed version of GitLab, which means it is our company dedicated GitLab. In addition, the repo is restricted to be a private project due to policy, so it is double guaranteed. Most of normal employees don't even have acess to dedicated version of company gitlab. Despite the HQ's admin and GitLab Application Owner, normal ITOps has no access to the repo created in our own team space either.

Due to the audit is started by HQ's ITOps, so I never expected a simple git push with files removal including API will help. All the commit history tracked the file with a 明文 API. Every auditor could see it easypeasy. SO THAT WAS THE WAY I LEARNED `git filter-repo`, why there are so many genius 前辈 on the planet playing with the code in binary world before AI Era. 人类群星闪耀时 has already been blinking blinking all those couple of decades, all the wisdom emerged has far exceeded the sum of past few centuries. 

The patch I did is literally as followed
```bash
# 1. Installation 
brew install git-filter-repo

# 2. Create temporary file for replacement rules 
echo 'leakedAPI==>PLACEHOLDER' > /tmp/replacements.txt

# 3. Execute Replacement (that will overwrite all commit including this string)
git filter-repo --replace-text /tmp/replacements.txt

# 4. Forcingly push to remote origin (All branches)
git remote add origin <OUT GITLAB HTTP>   # filter-repo will remove remote, re add neeed
git push --force --all
git push --force --tags
```

And that fixed



