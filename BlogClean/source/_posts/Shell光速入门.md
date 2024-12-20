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

## The diference between `$*` and `$@`

**`$@`**：

- 当不带引号使用时，`$@` 和 `$*` 表现相同，都会将所有参数作为一个单独的字符串列表处理，每个参数之间用空格分隔。
- **当带引号使用时**，`"$@"` 会将每个参数作为独立的字符串处理，也就是说，保留每个参数的边界。例如，如果传递给脚本的参数是 `arg1`, `arg2`, `arg3`，那么 `"$@"` 会将它们视为 `"arg1" "arg2" "arg3"`。

**`$\*`**：

- 当不带引号使用时，`$*` 和 `$@` 表现相同。
- **当带引号使用时**，`"$*"` 会将所有参数合并成一个单一的字符串，参数之间用第一个字符定义的分隔符连接（通常是空格）。例如，传递给脚本的参数是 `arg1`, `arg2`, `arg3`，那么 `"$*"` 会将它们视为 `"arg1 arg2 arg3"`。

### Example

假设有三个参数：`arg1`、`arg2`、`arg3`。

- 使用 `"$@"`：

  ```bash
  for arg in "$@"; do
    echo "$arg"
  done
  ```

  Output:

  ```bash
  arg1
  arg2
  arg3
  ```

- 使用 `"$*"`：

  ```bash
  for arg in "$*"; do
    echo "$arg"
  done
  ```

  Output:

  ```bash
  arg1 arg2 arg3
  ```

### Summary

- **`"$@"`**：每个参数作为一个独立的字符串处理，适用于逐个处理每个参数的情况。
- **`"$\*"`**：将所有参数合并为一个单一的字符串，通常在你想要将所有参数作为一个整体处理时使用。

在实际使用中，如果需要逐个处理参数，通常推荐使用 `"$@"`，以确保参数的完整性和独立性。

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

