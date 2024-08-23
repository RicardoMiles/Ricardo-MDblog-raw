---
title: Shell光速入门
date: 2024-08-23 04:18:26
tags:
---
# Basic notes
## First Line 
The first line of shell script should always be as followed:

```bash
#!/bin/bash
```

When the ideal shell is not bash, we could substitute the bash in first line into zsh or any other shell.

## Read
`read` could accept user input, `$` could follow a variable name

```bash
read name
echo "Hello,$name"
```

## Pass parameter to script
`$0` means the name of currently executed script

`$#` means the amount of passed parameters

`$?` 上一命令的推出状态码。0通常表示没有错误，非0表示有错误

`$!` means the PID of the last 后台 process

`$@` means the parameters passed to script

`$*` means the parameters passed to script

`$$` means the PID of current process

# The diference between `$*` and `$@`


## Comment
Comments starts by `#` in shell 
# Two method to execute a script
## `./` need authorised permission
There must be an extra command for `./`.

```bash
chmod u+x game.sh
./game.sh
```

## `bash` command do not need extra permission
```bash
bash game.sh
```
The bash command could ignore permission problem

# Mapping env by export or `.bashrc`
Export command works just in current shell window;

But edit the `.bashrc` file would permanently maintai the env variable.

After editing `.bashrc` file, we should use source command to make it work

```bash
source .bashrc
```


