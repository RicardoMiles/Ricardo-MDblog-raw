# 15天Cpp冲刺

## Day 1

```c++
int a = 10;        // 整数变量，存了10
double b = 3.14;   // 小数变量，存了3.14
string name = "Tom";  // 字符串变量，存了"Tom"
```

### Output&Input : C v.s. CPP

C

```c
int a;
printf("请输入一个整数：");
scanf("%d", &a);  // 使用格式符 %d，且必须提供变量的地址 &a
printf("你输入的整数是：%d\n", a);  // 输出整数时，依然要使用格式符
```

CPP

```c++
int a;
cin >> a;  // 输入一个整数
cout << "你输入的数字是：" << a << endl;  // 输出这个整数
```

更生动的例子

```c++
#include <iostream>
using namespace std;

int main() {
    int num1, num2;

    // 提示用户输入第一个数字
    cout << "请输入第一个数字：";
    cin >> num1;  // 接收用户输入的数字

    // 提示用户输入第二个数字
    cout << "请输入第二个数字：";
    cin >> num2;  // 接收用户输入的第二个数字

    // 计算两个数字的和
    int sum = num1 + num2;

    // 输出计算结果
    cout << "这两个数字的和是：" << sum << endl;

    return 0;
}

```

**C (`scanf`)**：

- 使用`scanf`时，程序必须清楚地知道输入的变量类型，使用错误的格式符可能导致不可预料的行为。例如，如果你误用了格式符号，编译器可能不会发出警告。
- `scanf`必须使用地址符号`&`，因为它需要知道输入的变量存储在哪里。

**C++ (`cin`)**：

- `cin`不需要格式符，自动根据变量类型接收输入，较少出错。
- `cin`不需要传递变量的地址，直接通过变量的名称接收输入。

### Buffer

A buffer is a temporary storage area used for managing data transfer efficiently. In input operations, data from the keyboard is first stored in the input buffer before the program reads it. One common issue is that leftover data, like a newline character (`\n`), can remain in the buffer and affect subsequent input operations. In C++, we can handle this by using `cin.ignore()` to skip unwanted characters, while in C, we often use functions like `getchar()` to clear the buffer. 



当你通过键盘输入数据时，键盘不会一次一个字符直接交给程序，而是先将你输入的所有字符存储到缓冲区里，直到你按下**回车键（Enter）**。按下回车键后，操作系统会把这些输入传递给程序，而这些输入包括你输入的字符和你按下的**回车符号（`\n`）**。



假设你在程序中使用了`scanf("%d", &num)`来读取一个整数，场景如下：

1. 你输入了`42`，然后按下**回车键**，缓冲区中会存储：`42\n`。
2. `scanf`只会读取`42`，因为它只期望读取一个整数类型的数据。它会处理`42`，但不会自动处理缓冲区中的`\n`（换行符）。
3. 因此，**换行符还留在缓冲区中**，如果接下来程序再次进行输入操作，就可能会直接读取到这个换行符，导致不期望的行为。

假设我们有以下C代码：

```c
int num;
scanf("%d", &num);  // 读取整数
```

1. 当用户在终端输入`42`并按下回车键，缓冲区中会存储：`42\n`。
2. `scanf`只会读取`42`，但**不会**处理换行符`\n`。
3. 如果程序接下来再读取其他输入，缓冲区中的`\n`可能会导致意外行为，例如直接读取到换行符而不是用户的新输入。

为了避免缓冲区中的多余数据（例如换行符`\n`）影响后续的输入操作，通常需要在读取完数据后清除或忽略这些多余的数据。

在C++中，可以使用`cin.ignore()`来跳过缓冲区中的多余字符：

```cpp
int num;
cin >> num;
cin.ignore();  // 忽略换行符

```

C语言版本：输入两个数并输出它们的和

```c
#include <stdio.h>

int main() {
    int a, b;
    printf("请输入第一个数字：");
    scanf("%d", &a);  // 需要格式符 %d 和地址符 &
    printf("请输入第二个数字：");
    scanf("%d", &b);  // 需要格式符 %d 和地址符 &

    printf("两个数字的和是：%d\n", a + b);  // 需要再次使用 %d 格式符
    return 0;
}

```

CPP version

```cpp
#include <iostream>
using namespace std;

int main() {
    int a, b;
    cout << "请输入第一个数字：";
    cin >> a;  // 无需格式符或地址符
    cout << "请输入第二个数字：";
    cin >> b;  // 无需格式符或地址符

    cout << "两个数字的和是：" << a + b << endl;  // 无需格式符
    return 0;
}

```

### Compile

```bash
g++ myprogram.cpp -o myprogram.exe
```



###  File storage

在C++中，源代码文件通常保存为 `.cpp` 后缀，而不是 `.c`。虽然C++兼容C语言代码，但使用不同的文件扩展名有助于区分代码类型：

- **C文件**：通常保存为 `.c`。
- **C++文件**：通常保存为 `.cpp`。

编写C++代码时，请确保文件保存为`.cpp`格式。



### HeadFile

C++和C语言的头文件有一些不同，特别是在C++中使用了标准模板库（STL）和新的命名空间规范。

#### **C语言中的头文件**

- 在C语言中，常见的标准库头文件包括：
  - `stdio.h`：用于输入输出操作（如`printf`和`scanf`）。
  - `stdlib.h`：用于动态内存分配、随机数等。
  - `math.h`：用于数学函数（如`sin`、`cos`等）。

#### **C++中的头文件**

- 在C++中，我们有许多与C类似的头文件，但也有一些不同点：

  - 输入输出流

    ：在C++中，输入输出使用的是

    ```
    iostream
    ```

    ，不再使用

    ```
    stdio.h
    ```

    。

    - 头文件：`#include <iostream>`
    - 输入：`cin`，输出：`cout`

  - 不需要`.h`后缀

    ：C++的头文件通常不带

    ```
    .h
    ```

    ，例如：

    - `#include <cmath>`：代替C语言中的`math.h`
    - `#include <cstdlib>`：代替C语言中的`stdlib.h`

  - 标准模板库（STL）

    ：C++引入了标准模板库（STL），用于数据结构和算法的头文件：

    - `#include <vector>`：用于动态数组（vector容器）。
    - `#include <string>`：用于字符串操作。
    - `#include <map>`：用于键值对映射的map容器。