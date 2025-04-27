# Chat老师advanced查漏补缺

## 🐧 **【Linux 基本命令学习清单】 (Linux Basic Command Checklist)**

### 1. **文件和目录管理 (File and Directory Management)**

- `ls`: List files
- `pwd`: Show current directory
- `cd`: Change directory
- `mkdir`: Create a new directory
- `rm`: Remove file or directory
- `cp`: Copy files
- `mv`: Move or rename files

### 2. **查看文件内容 (View File Content)**

- `cat`: Show the content of a file
- `less`: View file page by page
- `head`: Show the first 10 lines
- `tail`: Show the last 10 lines

### 3. **权限管理 (Permission Management)**

- `chmod`: Change file permissions
- `chown`: Change file owner
- `whoami`: Show current user

### 4. **进程管理 (Process Management)**

- `ps`: Show running processes
- `top`: Real-time process viewer
- `kill`: Stop a process

### 5. **包管理 (Package Management, Ubuntu/Debian)**

- `apt update`: Update package list
- `apt install <package>`: Install package
- `apt remove <package>`: Remove package

------

## 💻 **【C 字符串操作手写练习题】 (C String Manipulation Handwritten Exercises)**

### **Exercise 1: Reverse a String**

> Write a function to reverse a given string.

```c
void reverse_string(char *str);
```

------

### **Exercise 2: Check if a String is a Palindrome**

> Write a function to check if a string reads the same forwards and backwards.

```c
int is_palindrome(const char *str);
```

------

### **Exercise 3: Count Character Occurrences**

> Count how many times a character appears in a string.

```c
int count_char(const char *str, char target);
```

------

### **Exercise 4: Remove All Spaces from a String**

> Remove all whitespace characters from the given string.

```c
void remove_spaces(char *str);
```

------

## 📋 **【C 标准库函数使用总结表】 (C Standard Library Functions Summary Table)**

| Function            | Purpose                        | Header File  | Example Use                                 |
| ------------------- | ------------------------------ | ------------ | ------------------------------------------- |
| `strlen`            | Get string length              | `<string.h>` | `strlen("hello");`                          |
| `strcpy`            | Copy string                    | `<string.h>` | `strcpy(dest, src);`                        |
| `strcat`            | Concatenate strings            | `<string.h>` | `strcat(dest, src);`                        |
| `strcmp`            | Compare strings                | `<string.h>` | `strcmp(s1, s2);`                           |
| `sprintf`           | Format string into buffer      | `<stdio.h>`  | `sprintf(buffer, "%d", number);`            |
| `atoi`, `atof`      | String to int/float conversion | `<stdlib.h>` | `atoi("123"); atof("3.14");`                |
| `strchr`, `strrchr` | Find character in string       | `<string.h>` | `strchr(str, 'a');`                         |
| `strstr`            | Find substring in string       | `<string.h>` | `strstr(haystack, needle);`                 |
| `memcpy`, `memset`  | Memory operations              | `<string.h>` | `memcpy(dest, src, n); memset(dest, 0, n);` |

------

Would you like example solutions for the exercises? Or do you prefer hints first so you can try solving them yourself? 😊