# Software Part
## Hack CPU detail 
* Hack CPU is 16-bit word size, one instruction have 16 bits
* Manipulate Program counter to achieve loop
* A register is the unique register could load value directly
* Program counter hold the number of ROM address of next instruction would be executed by CPU
* Variable - store RAM address - mapping A register
* label - ROM address
* Execute instruction first, then PC changed. E.g. When the CPU is executing the second instruction, the PC currently is 1, after executing, it +1
* R0 - R15  are called virtual registers
* @var is sensible about Capitalized variable identifier
* Only the instruction without @ be followed by semiclone and jump instruction
* If [result of instruction] satisfies [condition], goto the ROM address currently contained in A register right now.
* change A's value and jump instruction could not appear in same line(same clock circle); every time you change A, Program Counter changes
* The jump instruction condition judges&cares the right side of assignment.
* 512*256 resolutiion screen of Hack, every word between 0x4000 - 0x5FFF controlled a set of 16 pixel on screen, the sequence is mirroring by the binary expression of memory.
    * e.g. RAM[0x4020] stores 0b 0000 0000 0000 0001, screen will show the most left pixel of this set as black
    * each word in 0x4000–0x5FFF controls not one pixel, but 16!
*  The @ command only works on values of up to 15 bits!

## Hack Assembly Syntax
* Binary Operation
    * Operands have to be 2 register
    * One of them have to be D register 
    * Assigning operation is not counted 
    * You can do multiple assignment, But A/M/D should be in the fixed sequence.
* @num  - load number to A register , at most 15 bit in Binary
* `A = -D` is also Unary Operation, because right side there is only one register
## Hack Assembly Trick
### Write 0xFFFF
Since it is not allowed to write 16-bit into register in Hack Assembly.(Insrtuction could at most assign 15 bits). So the best way to do it is

```
@0
D = !A
```

### Loop the whole screen
Loop each pixel on screen is executable given that Hack CPU is memory mapped. The address from 0x4000 to 0x5FFF is screen. The Hack CPU manipulate the input and output directly by manipulate the memory.

```
// Pseudocode:
// While True:
//     For every i between 0x4000 and 0x5FFF
//         if RAM[KBD] !=0:
//             Write 0x0000 to RAM[i]
//         Otherwise:
//             Write 0xFFFF to RAM[i]
//
// Infinite loop
```

Then put it into Assembly code

```
(bigloop)
// For all i between
    @SCREEN
    D = A
    @i
    M = D
    (smallloop)
        // If i = 0x6000;Jump to bigloop
        // A.K.A if the i reach the KBD, it is equivalent to loop over the last pixel of SCRREN
        // If 0x6000 - i == 0;Jump to bigloop 
        @i
        D = M
        @KBD
        D = D - A
        @bigloop
        D;JEQ

        // If RAM[KBD] != 0,jump to (writezero)
        @KBD
        D = M
        @writezeroes
        D;JNE

        // Otherwise, write 0XFFFF to RAM[i]
        D = 0 
        D = !D
        @i
        A = M 
        M = D
        @i
        M = M + 1
        @smallloop
        0;JMP

        //Write 0x0000 to RAM[i]
        (writezeroes)
        D = 0
        @i
        A = M
        M = D
        @i
        M = M +1
        @smallloop
        0;JMP

//Loop infinitely
@bigloop
0;JMP
```

### Practice of sum 
Goal: Sum all the integers from 0 to RAM[0] and put the result in RAM[1].

So, if RAM[0] == 3; then RAM[1] should be 0+1+2+3 = 6.

```
// let a variable to hold the current number
@currentNum
M = 0
// Set RAM[1] = 0, initialize the procedure
@R1
M = 0

// While currentNum <= RAM[0]
//      add currentNum to RAM[1]
//      increase the value of currentNum by 1
(loopstart)
    @currentNum
    D = M
    @R-1
    D = D - M
    @loopend
    D;JGT
    @currenNum
    M = M + 1
    @loopstart
    0;JMP
(loopend)
@loopend
0;JMP
```

### Calculate the pixel memory position by its number
Row `r` from the top displayed on screen

Column `c` from left displayed on screen


Both counting from 0

The pixel at Row `r` Column `c` is controlled by the `(c%16)`th bit from the right at address `0x4000 + 32r + (c/16)`

### Hack ISA
* Instruction length is always multiple word size
* Havard -> 2 separate memory bank, separate data and instruction
* Von ->  data and instructions stores at same memory
* Modern computer use Von ISA more
* PC A M -> special purpose registers
* D -> general purpose register

### Addressing Mode
* Immediate Addressing: Interpret oprand as data
* Direct Addressing: Interpret operand as the position of data
* Indirect Addressing : Interpret operand as the position of the pointer which points to the data
* E.g. @num -> immediate addressing
* E.g. @label ->direct addressing
* E.g.   Firstly, @5; then,M = 1;
* It depends give what to A register, @num give number to A, @label parse the address of label and give address to A, @num then manipulate M, give A the address of pointer, A is the pointer of M

### Pipeline and stall
Stall aka bubble, three harzard leads to stall
* Data hazard
* Conditional hazard
* Structural hazard

All the rest of pipline will stall until the conflict instruction executed.

Pipeline of Hack C-instructions fetch-exectute 
* 4 stages of  it: Fetch; Decode; Execute; Writeback
* we can set the clock speed to the propagation delay of the slowest stage, rather than of the entire fetch-execute cycle!

### Compiler - Lexing
* Use an assembler to turn assembly into machine code.
* Lexing converts source code text into a list of tokens
* Parsing analyze the structure of tokens, also known as analyze syntax
* IR - Intermediate representation
* Hack assembler has only two step: parsing and lexing
* On lexing stage, labels are recorded in symbol table; but, label itself will not be converted to token
* Your lexer will also handle labels, which would normally be part of semantic analysis
* 对于每一行： 
    * 移除所有注释和空白。
    * 如果该行为空，则跳过。
    * 如果该行是一个标签，将其添加到符号表中，并记录当前行对应的 ROM 地址。
    * 否则，将该行分解为标记并输出到一个临时文件中。

### Assember - demand
Assembler todo list: 
* 为每一个变量分配一个对应的RAM地址，从16开始。
* 用RAM地址替换变量
* 为每个标签分配一个ROM中的地址，这个ROM地址和标签出现的机器代码行相对应
* 用ROM地址替换标签
* 完成上述步骤，才将@语句替换成A指令
* 由Symbol Table 来完成上述操作，在汇编过程中，跟踪程序使用的所有标签和便来年个的地址
* Filling the symbol table 和 lexing 以及parsing同步进行

![image](https://github.com/user-attachments/assets/3c2c9f47-e8ae-4c58-836e-b065e62d779f)

### Identifier and symbol tables
* In Hack, identifiers are labels and and variables.
* Symbol table is a data structure mapping the names of identifiers to their meaning
* In Hack, we will have one symbol table for labels (mapping each label name to its ROM address) and one for variables (mapping each variable name to its RAM address).
* Both the label and variable tables start empty.

### Working mechanism of symbol table
In parsing, for each identifier we find, we check the symbol tables:
* If it’s in the label table, hooray — substitute in the ROM address.
* If it’s in the variable table, hooray — substitute in the RAM address.
* If it’s in neither table, it must be the first occurrence of some variable. So we add it to the variables table with the first unassigned RAM address.

### Compiler - Parsing
* The goal of parsing is to convert a list of tokens into a parse tree or concrete syntax tree (CST) which gives its BNF structure.

![image](https://github.com/user-attachments/assets/d80f873f-ef02-4048-adb5-ce878736a66c)

## LL parsing
* go through tokens from left to right
* build CST from the top down 
* Process
    * 如果⟨指令⟩以 '@' 标记开头：
        * 如果使用了一个新变量，分配 RAM 并将其添加到符号表中。
        * 如果使用了一个现有变量或标签，从符号表中检索相应的 RAM/ROM 地址。
        * 生成并输出相应的 A-指令。
    * 否则：
        * 将其分解为一个赋值、一个计算和一个条件。
        * 将这些分配到适当的 dest、comp 和 jump 值。
        * 生成并输出相应的 C-指令。

### BNF
* Programmers express grammars in Backus-Naur Form (BNF), and usually just understanding BNF is enough.
* A context-free grammar (or just grammar) is a way of quickly and rigorously specifying which strings in a language have valid syntax.
* 上下文无关文法：这是一种用于定义编程语言或自然语言语法的数学系统。与上下文相关的文法不同，上下文无关文法的规则不依赖于字符周围的上下文。
* Anything we define as part of the grammar must be enclosed in ⟨⟩s. We call these **non-terminal symbols**. Anything else (e.g. ‘lecturer’) is a **terminal symbol** or **token**.

![image](https://github.com/user-attachments/assets/a5fe5a92-37a9-4d67-af6d-f75aec592590)

* BNF allows recursion.
* The goal of parsing is to convert a list of tokens into a parse tree or concrete syntax tree (CST) which gives its BNF structure.

### EBNF for Hack assembly

![image](https://github.com/user-attachments/assets/b10968ad-02d3-4507-9325-8ab0e65f2887)

### Track scope
作用域 - 是一张又一张独立的symbol table



### VM syntax detail

* **Compilers for many languages can and do use the same IR.**
* Goals of VM
  * Implement function calls! (Next week...)
  * Proper compile-time memory allocation! (Next week...)
  * Multi-file compilation support for libraries. (Next week...)
* The Hack VM is an example of a stack machine
   * create
   * push
   * pop

	* Stacks are **LIFO**: “Last In, First Out”.
	* Hack **Assembly** use **physical memory** — every memory address is the exact logical signal sent to a physical latch on a physical chip, either ROM or RAM.
	* Hack **VM(IR)** use **virtual memory.**
	* push with the command **push [memory] [address].**
 * The **Hack VM has 8(!) separate virtual memory banks**, which our VM translator will map to different segments (continuous blocks) of the underlying RAM.
   * **local** is general-purpose storage for local variables. 
   * **constant** holds the constant i at each 15-bit address i. This “memory” is read-only and doesn’t correspond to any physical ROM or RAM.
 * The Hack VM represents a result of true by 0xFFFF, and false as 0x0000\
 * For operations that pop two values, **y is the first value popped and x is the second value.** E.g. push constant 3, push constant 1, sub will end with 2 on top of the stack rather than −2



### VM branching

* Syntax for goto:

  * **label LABEL NAME** declares a label at that point of the code. 
  * **goto LABEL NAME** jumps to that label from anywhere in the code.
  * **if-goto LABEL NAME** pops the stack and executes goto LABEL NAME if the result is non-zero (i.e. if it is not false).

* **if-goto** in the same way that we would use **D;JNE** in assembly. 

  The differences are: 

  * The value we compare to zero is the top of the stack instead of D. 
  * We have proper logical operators gt, eq, lt, and, or and not built into the language to replace the various jump conditions.

* ***this*** segment can only be used to access RAM[0x0800–0x3FFF]； For anything outside that, we must instead use the **that** memory segment.

* ***that*** maps range  0 to RAM[pointer 1]

* 在函数调用开始时，***local***段是空的，其内容将在函数返回时被丢弃。

* 在函数调用开始时，***argument***段将保存该调用的参数。此段不能被写入。

* ***static***段的内容在函数调用之间保持不变（它将用于稍后在高级语言中处理静态和全局变量）。

* ***temp*** 的行为与***local***相同，但被映射到更小的内存区域。它被设计为“工作空间”，供编译器在从高级语言编译单个指令时使用，而不需要干扰local的内容。



### Hack VM Tokens

![image](https://github.com/user-attachments/assets/fa42eecb-8618-4ef4-b1f3-5da32adaea20)

### Memory and the Stack

* base addrss和offset这组概念非常重要，local后的数字就是偏移量offset，没有一个local地址都是mapped to基地址加上offset

* Hack 虚拟机的每个八个虚拟内存段都连接有 64KB 的内存（以 32,768 个 16 位字组成）。另外，它还有一个可以无限增长的堆栈。Hack CPU 总共支持 64KB 的内存。因此，某些东西必须有所取舍。

* HACK assembly key word

  * 局部变量段（local）的基地址存储在 `RAM[1]` 中，即 `LCL`。

  * 参数段（argument）的基地址存储在 `RAM[2]` 中，即 `ARG`。

  * 指针段（pointer）被分配了长度为 2 的固定段，基地址为 3。所以：

  - `this` 的基地址（即 `pointer 0`）存储在 `RAM[3]` 中，即 `THIS`。
  - `that` 的基地址（即 `pointer 1`）存储在 `RAM[4]` 中，即 `THAT`。

  * 临时段（temp）被分配了长度为 8 的固定段，基地址为 5。

  * 静态段（static）被分配了长度为 240 的固定段，基地址为 16。

  - 如果编译文件 `Foo.vm`，则地址 `static 5` 应该映射到 Hack 汇编变量 `Foo.5`。（解释将在下周进行！）

  * 常量段（constant）不会出现在物理内存中。

* 堆栈顶部一个字（word）之后的地址存储在 `RAM[0]` 中，即 `SP`（SP 代表堆栈指针）。

  当我们将一个新值 `x` 压入堆栈时，我们将 `x` 写入 `RAM[SP]`，然后递增 `SP`。

  当我们将一个值从堆栈弹出并存入 `RAM[i]` 时，我们先递减 `SP`，然后将 `RAM[SP]` 的值复制到 `RAM[i]`。

* **堆栈指针（SP）**：堆栈顶部一个字之后的地址存储在 `RAM[0]` 中，这个位置称为堆栈指针（SP）。它指向堆栈的下一个空闲位置，表示下一个值应该放置在哪里。



### Extending VM by Function Call - Flow Control

* On function return: Program flow returns to the line after the original function call. The local variables x and y return to their old values. The argument variable n returns to its old values. The static variables times called and layers deep are unchanged

* Function call goal

  * 目标 1：程序流程。在函数调用时，我们应该跳转到函数的开始。在函数返回时，我们应该跳回到调用的地方。

  * 目标 2：内存分配。在函数调用时，我们应该为新的局部变量和参数变量分配内存。在函数返回时，我们应该释放这些内存。

  * 目标 3：程序状态。在函数调用时，我们应该保存所有现有的局部变量、参数变量和大多数寄存器值，并用新的值替换它们。在函数返回时，我们应该恢复它们，使其保持不变。

  * 目标 4：静态变量不应受到函数调用和返回的影响。

* 因为Hack VM层面才有stack，hack assembly层面没有stack，但还是用栈思想来设计functioncall的流程控制

* Function call时 store the address to stack, push the address to stack, then jump;On return, pop the return address from the stack, then jump to it



### Memory Allocation 

* 编译器需要： 每次调用函数时，为已知数量的已知大小的局部/参数变量找到空间。

* 假设每个变量占用一个字的存储空间，我们将参数存储在底部，然后是局部变量，然后是程序状态。（具体顺序其实并不重要。） 对第 i 个参数变量的引用变为对 `RAM[OSP + i]` 的引用。 对第 i 个局部变量的引用变为对 `RAM[OSP + 7 + i]` 的引用。

* 我们将需要压入栈中的程序状态部分（例如返回地址、旧的 OSP 值、旧的寄存器值）称为调用函数的调用帧（call frame），或简称为帧（frame）。在上一张幻灯片中，我们称其为“旧状态”。

  程序仍然可以使用栈的顶部部分作为在函数内部进行算术操作的工作存储空间。我们将这个子栈称为工作栈（working stack），并将整个栈（包括所有过去的调用帧）称为全局栈（global stack）

* 所有的算数都使用二进制补码 2‘s complement

* frame 帧

* call frame 调用帧

* push到stack上的旧的Program State被称为call frame

* global stack全局栈

* 函数内部仍可用的stack顶部的sub stack叫做working stack

* 调用子函数时当前的working stack 回合其余旧的state一起保存

* 不同阶段的SP - 假设function f 会用10 word的局部变量， 7 word参数变量和 5 word 当前程序状态

  * Call function

    将当前的SP存在一个register中，作为Old Stack Pointer - OSP；

    将SP value +=10，因为架设了call 一次用10个word局部变量

    再将SP value +=12（5 word program state 7word argument），依次将Program State 和arguments塞进stack

    然后跳转到function label

  * Function execute

    将  arguments,  local,  program state 自下而上存储

    对第 i 个参数变量的引用变为对 `RAM[OSP + i]` 的引用。

    对第 i 个局部变量的引用变为对 `RAM[OSP + 7 + i]` 的引用。（因为7个argument是预设的）

  * Function return 

    存储返回值 optional

    将SP重新设为OSP

    将之前的Program State复制到寄存器

    跳转到返回地址（从Stack里取出的）

    Optional对返回值进行操作

### Hack VM function call syntax

* The syntax to return from a function is `return`, which returns the top value of the stack.
* The syntax to call a function is `call name x`, where `name` is the function’s name and `x` is the number of arguments to use. This pops the top x values of the stack
* The syntax to define a function is `function name x`, where `name` is the function’s name and `x` is the size of the function’s local segment



### Function Declaration in VM to Assembly

假设我们的虚拟机翻译器遇到了代码行 `function myFunc 3`。在右侧，我们继续上张幻灯片的例子。我们生成的汇编代码必须：

1. **生成标签：**

   * 每当虚拟机翻译器遇到一个函数声明时，首先要生成一个标签（label），该标签用于标识函数的入口点。在汇编代码中，这个标签将是函数开始执行的位置。

   * 这个标签通常可以直接从函数名推导出来，这样就不需要额外的符号表来管理标签和函数名之间的映射

2. **设置栈指针（SP）：**

   * 函数执行时需要为局部变量分配内存空间。这里的指令将栈指针（SP）设置为局部变量段（LCL）加上局部变量的数量（3）。这一步为函数的局部变量分配了必要的栈空间。

3. **初始化局部变量：**

   * 在栈中为局部变量分配空间后，需要将这些变量初始化为零。这里具体提到初始化 `local 0`、`local 1` 和 `local 2`，因为函数声明中指定了 3 个局部变量。

4. **进入函数的实际代码：**

   * 完成标签生成、栈指针设置和局部变量初始化后，程序就可以进入实际的函数代码进行执行了。这个步骤相当于函数的主要功能部分开始运行。

### Function Return in VM to Assembly

**存储返回地址：**

- 在函数返回之前，程序需要知道要跳转到哪里，这就是返回地址。通常，返回地址会保存在调用函数时的栈中。为了便于后续操作，返回地址会暂时存储在一个寄存器中，例如 R13。

**复制返回值：**

- 函数的返回值通常存储在栈顶。当函数即将返回时，程序会将这个返回值复制到新的工作栈的位置，即当前 `ARG` 的位置。这是因为 `ARG` 是调用函数时的参数存储位置，当函数返回时，返回值将覆盖最初的参数位置。

**调整栈指针（SP）：**

- 接下来，将栈指针 `SP` 设置为新工作栈的顶部，即 `ARG + 1`。这意味着栈顶现在指向了返回值的上方，准备在返回后进行新的操作。

**恢复旧状态：**

- 在调用函数之前，程序会保存一些关键的状态信息（如 `THAT`、`THIS`、`ARG` 和 `LCL`）在栈中。在函数返回时，这些状态需要恢复，以确保返回后程序能继续正常运行。恢复的过程是从当前 `LCL` 值开始，向下遍历栈，依次恢复这些寄存器的值。

**跳转到返回地址：**

- 最后，程序跳转到返回地址，完成函数的返回操作。这一步同时丢弃了 `SP` 以上的所有栈内容，因为这些内容在函数返回后已经不再需要。



### First Attempt Note

·     **函数调用**: 在汇编语言中，你需要手动处理函数调用。通常，这包括将返回地址（通常是下一条指令的地址）放入 A 寄存器，然后使用 **D=A; @SP; A=M; M=D; @SP; M=M+1** 将其推入栈中，然后使用 **@****函数名** 和 **0;JMP** 来跳转到函数的开始位置。

·     **函数返回**: 在函数的末尾，你需要从栈中弹出返回地址并跳转回去。这通常是通过 **@SP; M=M-1; A=M; 0;JMP** 来完成的。

 

 

在函数调用时，`**LCL**`会被设置为当前的`**SP**`值，因为新的局部变量将从当前栈顶开始被分配。

- **SP**是栈指针，它指向栈顶的下一个位置，即下一个将要被推入的值的位置。
- 在函数调用时，**SP**会递增，因为我们要将返回地址（标签）、**LCL**、**ARG**、**THIS**和**THAT**推入栈中。
- 在函数返回时，SP会被重置回ARG + n的位置，其中n是函数返回值的数量（通常是1）

 

在函数调用时，`**ARG**`会被设置为`**SP - n - 5**`的位置，其中`**n**`是传递给函数的参数数量。”-5”是因为在推入参数之前，栈中已经包含了保存的`**LCL**`、`**ARG**`、`**THIS**`和`**THAT**`，以及返回地址。



* 当我们将一个新值x推入栈时，我们将x写入RAM[SP]，然后增加SP。

* 当我们从栈中弹出一个值到RAM[i]时，我们减少SP，然后复制RAM[SP]到RAM[i]

## From Nand 2 Tetris OG

### Stack

![image-20240810001621526 - 副本](https://github.com/user-attachments/assets/b61a6af4-e05e-4d76-87ed-1648713625c1)

### Function Call

![image](https://github.com/user-attachments/assets/7f3c4340-9b3a-4644-ba68-b09999226a86)

![image-20240810131433769](https://github.com/user-attachments/assets/121219c8-7702-4785-aa9d-189c19d260f4)

![image](https://github.com/user-attachments/assets/c277f286-9559-4883-9c80-ae3569de05d3)

* 注意看这个具体实现，包括了call 和 return
* Saved frame是一系列指针
* 执行完毕， the top of callee stack 也就是return value 会覆盖到 argument 0的位置，sp重置为 argument 0那个位置 +1，然后，属于callee function的东西全部就销毁了， LCL ARGS THIS THAT这些指针全部恢复原来值，那个saved frame被读档了

![image](https://github.com/user-attachments/assets/8ea80e1c-3bc9-4b3b-8187-d217616be39f)



![image](https://github.com/user-attachments/assets/96649795-ec13-40d2-a4ee-e624d3b8a042)

![image](https://github.com/user-attachments/assets/319304a6-9cf2-47ed-8042-2c8f0d9d268f)



![image](https://github.com/user-attachments/assets/6d727480-d31f-4060-b63f-cbf379db702e)

## Quiz Error Book

### Quiz 5
![image](https://github.com/user-attachments/assets/827b266c-6462-49c5-aacb-37379a6515c6)

![image](https://github.com/user-attachments/assets/7bb012ee-7b8f-427a-9dec-701d2969686f)

* Binary Operation must have two registers , so A could not add itself
* C-instruction could also do assignment, but only 0, 1, -1
* option F is definitely invalid because binary operation's operands should including D register

![image](https://github.com/user-attachments/assets/4140f26f-2f97-4a2a-b20f-754b1ff014fa)
```
@list_start
D = M
@49
D = D + A
A = D
```

### Quiz 6
![image](https://github.com/user-attachments/assets/7a4cb3f7-cf7a-4f8e-aa55-aabd34e5aa79)

![image](https://github.com/user-attachments/assets/aa38f61f-9032-4534-9a1e-9e51008a803f)

* 微架构是计算机硬件的物理设计——电路图和 PCB 布局。
* 指令集架构 (ISA) 是计算机响应机器代码指令的方式。
* 因此，字长、内存地址空间和支持的寻址模式都是 ISA 的属性。时钟速度、使用的晶体管数量和能效都是微架构的属性。
* C 指令有 3 个操作数：comp、jump 和 dest。
* In absence of stalls, a pipelined CPU average one clock cycle per instruction executed. 时钟周期是最快指令执行的市场，也许同步干别的但真正干完且能干完的只有且仅有一条最短的 instruction

### Quiz 7
* printf in C is a identifier just because it is defined by lib stdio.h
* A parse tree is the same thing as a CST, but not an AST.
* CST 拆解语法树的时候，没有括号不要多心去考虑结合变号问题，都会在BNF定义好的，唯一参考是BNF，照着BNF去拆

### Quiz 8

![image](https://github.com/user-attachments/assets/2944a6ae-777d-44ec-841c-e324f29bb81b)

![image](https://github.com/user-attachments/assets/b95fa631-4b03-4e86-b3df-524d949db5e5)

![image-20240811000511707](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240811000511707.png)

* 都是同一类型的VM 层面的stack计算问题
* sub操作是先push的减去后push的

![image-20240811000817827](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240811000817827.png)

* 一方面需要死记硬背
* 一方面需要理清重要的概念：This段是RAM[pointer 0]；that 段是 RAM[pointer 1]
* 

### Quiz 9


### Mock Theory







## Examinablity for Test 2
### week 5：
视频3中的图灵机定义不考察。

幻灯片中的其他内容（Church-Turing论文、图灵完备性和停机问题）考察，但仅限于幻灯片的内容深度。
### week 7：
视频3-4中提到的特定CPU的具体细节（如每条指令所需的周期数或从内存中检索数据所需的纳秒时间）不考察。但你需要记住所有CPU共有的关键定性细节（如L3缓存访问比L1缓存访问慢）。
### week 8：
Hack汇编语法考察，但不需要背诵定义——如果有相关问题，会提供EBNF的相关摘录。

视频2最后一张幻灯片（关于使用多个符号表处理高级语言中的作用域）仅在与week 11内容重叠时考察。
### week 9：
Hack VM语法考察，但不需要背诵定义——如果有相关问题，会提供EBNF的相关摘录。
### week 11：
不需要知道如何用Jack编程，不会问Jack语言的细节，也不会要求阅读、编写或调试Jack代码。但你需要理解将高级语言编译成Hack VM的基本原理，具体到Jack中探讨的程度。例如，你需要知道什么是方法，可能会被问到将方法编译成Hack VM的过程，但不会要求阅读、编写或调试Jack中的方法声明。

同样，Jack语法考察，但不需要背诵定义——如果有相关问题，会提供EBNF的相关摘录。

除了Memory.alloc、Memory.deAlloc和Sys.init（你需要知道）之外，任何需要的Hack“操作系统”细节（如Nisan和Schocken附录6中涵盖的）都会提供给你。