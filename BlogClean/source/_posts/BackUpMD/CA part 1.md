# CA part 1

[toc]

## Lecture 1 from Nand2

### 1. 布尔运算的基本操作：AND、OR、NOT

- **AND（与运算）**：符号是 `∧` 或 `&&`。当且仅当所有输入都为真时，输出才为真。否则输出为假。
  - 例如：A ∧ B 只有在 A 和 B 都为真时才为真。
- **OR（或运算）**：符号是 `∨` 或 `||`。当至少有一个输入为真时，输出为真。如果所有输入都为假，输出才为假。
  - 例如：A ∨ B 只要 A 或 B 中有一个为真，输出就为真。
- **NOT（非运算）**：符号是 `¬` 或 `!`。将输入的真值反转，即真变假，假变真。
  - 例如：¬A 如果 A 为真，则 ¬A 为假。

### 2. 真值表展示输入和输出的关系

真值表用来展示布尔运算中所有可能输入组合的输出结果。以下是 AND、OR 和 NOT 运算的真值表：

- **AND (A ∧ B) 真值表**：

  | A    | B    | A ∧ B |
  | ---- | ---- | ----- |
  | 0    | 0    | 0     |
  | 0    | 1    | 0     |
  | 1    | 0    | 0     |
  | 1    | 1    | 1     |

- **OR (A ∨ B) 真值表**：

  | A    | B    | A ∨ B |
  | ---- | ---- | ----- |
  | 0    | 0    | 0     |
  | 0    | 1    | 1     |
  | 1    | 0    | 1     |
  | 1    | 1    | 1     |

- **NOT (¬A) 真值表**：

  | A    | ¬A   |
  | ---- | ---- |
  | 0    | 1    |
  | 1    | 0    |

### 3. 布尔表达式的简化和等价性

简化布尔表达式和证明等价性可以通过以下方法：

- **代数法则**：应用布尔代数的基本法则（见下文）。
- **卡诺图（Karnaugh Map, K-map）**：图形化的方法简化布尔表达式，适用于多变量。
- **合并同类项**：利用分配律、结合律等将表达式简化。

### 4. 布尔代数的基本法则

布尔代数的基本法则如下：式：

- #### **交换律**（Commutative Laws）：

  - A∨B=B∨A
  - A∧B=B∧A

- #### **结合律**（Associative Laws）：

  - (A∨B)∨C=A∨(B∨C)
  - (A∧B)∧C=A∧(B∧C)

- #### **分配律**（Distributive Laws）：

  - A∨(B∧C)=(A∨B)∧(A∨C)
  - A∧(B∨C)=(A∧B)∨(A∧C)

- #### **幂等律**（Idempotent Laws）：

  - A∨A=A
  - A∧A=A

- #### **零律和一律**（Identity Laws）：

  - A∨0=A
  - A∨1=1
  - A∧0=0
  - A∧1=A

- #### **双重否定律**（Double Negation Law）：

  - ¬(¬A)=A

- #### **德摩根定律**（De Morgan's Laws）：

  - ¬(A∨B)=¬A∧¬B
  - ¬(A∧B)=¬A∨¬B

- #### **吸收律**（Absorption Laws）：

  - A∨(A∧B)=A
  - A∧(A∨B)=A

- #### **补元律**（Complement Laws）：

  - A∨¬A=1
  - A∧¬A=0

- #### Absorption Laws 推导

  * 吸收律 1： A∨(A∧B)=AA ∨ (A ∧ B) = AA∨(A∧B)=A

  1. 首先，我们知道 A∨(A∧B)A ∨ (A ∧ B)A∨(A∧B) 可以分成两部分来看：
     - AAA
     - A∧BA ∧ BA∧B
  2. 如果 AAA 是真（1），无论 BBB 是什么值，表达式 A∧BA ∧ BA∧B 都会是 AAA：
     - 如果 A=1A = 1A=1，A∨(A∧B)=1∨(1∧B)=1∨B=1A ∨ (A ∧ B) = 1 ∨ (1 ∧ B) = 1 ∨ B = 1A∨(A∧B)=1∨(1∧B)=1∨B=1
     - 因为 1∨B=11 ∨ B = 11∨B=1 对于任何 BBB 都成立。
  3. 如果 AAA 是假（0），那么 A∧BA ∧ BA∧B 就会是 000：
     - 如果 A=0A = 0A=0，A∨(A∧B)=0∨(0∧B)=0∨0=0A ∨ (A ∧ B) = 0 ∨ (0 ∧ B) = 0 ∨ 0 = 0A∨(A∧B)=0∨(0∧B)=0∨0=0
     - 因为 0∨0=00 ∨ 0 = 00∨0=0 对于任何 BBB 都成立。

  因此，无论 AAA 是真还是假，A∨(A∧B)=AA ∨ (A ∧ B) = AA∨(A∧B)=A。

  * 吸收律 2： A∧(A∨B)=AA ∧ (A ∨ B) = AA∧(A∨B)=A

  1. 首先，我们知道 A∧(A∨B)A ∧ (A ∨ B)A∧(A∨B) 可以分成两部分来看：
     - AAA
     - A∨BA ∨ BA∨B
  2. 如果 AAA 是假（0），无论 BBB 是什么值，表达式 A∨BA ∨ BA∨B 都会是 BBB：
     - 如果 A=0A = 0A=0，A∧(A∨B)=0∧(0∨B)=0∧B=0A ∧ (A ∨ B) = 0 ∧ (0 ∨ B) = 0 ∧ B = 0A∧(A∨B)=0∧(0∨B)=0∧B=0
     - 因为 0∧B=00 ∧ B = 00∧B=0 对于任何 BBB 都成立。
  3. 如果 AAA 是真（1），那么 A∨BA ∨ BA∨B 就会是 111：
     - 如果 A=1A = 1A=1，A∧(A∨B)=1∧(1∨B)=1∧1=1A ∧ (A ∨ B) = 1 ∧ (1 ∨ B) = 1 ∧ 1 = 1A∧(A∨B)=1∧(1∨B)=1∧1=1
     - 因为 1∧1=11 ∧ 1 = 11∧1=1 对于任何 BBB 都成立。

  因此，无论 AAA 是真还是假，A∧(A∨B)=AA ∧ (A ∨ B) = AA∧(A∨B)=A。

- **交换律**：

  - ![image-20240724210724301](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240724210724301.png)

- **结合律**：

  ![image-20240724210735406](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240724210735406.png)

- **分配律**：

  ![image-20240724210755110](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240724210755110.png)

- **幂等律**：

  ![image-20240724210802427](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240724210802427.png)

- **零律和一律**：

  ![image-20240724210811075](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240724210811075.png)

- **双重否定律**：

  ![image-20240724210820376](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240724210820376.png)

- **德摩根定律**：

  ![image-20240724210833164](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240724210833164.png)

- **吸收律**：

  ![image-20240724210841089](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240724210841089.png)

- **补元律**：

  ![image-20240724210850084](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240724210850084.png)

这些法则可以帮助我们简化和操控布尔表达式，证明两个表达式是否等价，以及在设计逻辑电路时优化电路的实现。

### 



## From Kira version lecture week 1

### Propositions 命题

Propositions  are 非true就false的表述。命题是一个要么真要么假的陈述。

例如，对于一个定义了边a、b和c的三角形，我们有以下命题：

- 边a与边b的长度相同 → x
- 边b与边c的长度相同 → y
- 边c与边a的长度相同 → z

这些可以用命题变量（propositional variables）来替换，命题变量表示每个命题的真值。我们可以给这些变量任何名字，但为了方便和效率，通常使用字母（x,y,z）。

**问题：**
这是什么类型的三角形？

**非命题：**
边a + 边b

**命题：**
它是一个等边三角形
边a = 边b = 边c

![image-20240724212255075](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240724212255075.png)

¬ should only precede  a variable



真值表：

| A    | B    | C    | ?    |
| ---- | ---- | ---- | ---- |
| 0    | 0    | 0    | 1    |
| 0    | 0    | 1    | 1    |
| 0    | 1    | 0    | 1    |
| 0    | 1    | 1    | 0    |
| 1    | 0    | 0    | 1    |
| 1    | 0    | 1    | 1    |
| 1    | 1    | 0    | 0    |
| 1    | 1    | 1    | 0    |

### 析取范式（DNF）Disjunction Normal Form的构建步骤：

1. **查看真值表中输出为1的行**：
   - 行1（A=0, B=0, C=0）
   - 行2（A=0, B=0, C=1）
   - 行3（A=0, B=1, C=0）
   - 行5（A=1, B=0, C=0）
   - 行6（A=1, B=0, C=1）
2. **对每一行构建合取项**：
   - 对于每一行，将所有输入变量用与（∧）连接。如果某个输入变量在该行中为0，则在该变量前加上取反（¬）。
3. **每行的合取项**：
   - 行1： ¬A∧¬B∧¬C
   - 行2： ¬A∧¬B∧C
   - 行3： ¬A∧B∧¬C
   - 行5： A∧¬B∧¬C
   - 行6： A∧¬B∧C
4. **用或（∨）将所有这些合取项连接起来**：

(¬A∧¬B∧¬C)∨(¬A∧¬B∧C)∨(¬A∧B∧¬C)∨(A∧¬B∧¬C)∨(A∧¬B∧C)

### 合取范式（CNF）Conjunction Normal Form的构建步骤：

1. **查看真值表**：
   - 观察真值表中输出为0的行。
2. **对每一行构建析取项**：
   - 对于输出为0的每一行，将所有输入变量用析取（∨）连接。
   - 如果某个输入变量在该行中为1，则在该变量前加上取反（¬）。
3. **析取项的合取**：
   - 用与（∧）将所有这些析取项连接起来。

#### 示例讲解：

对于给定的真值表，我们有以下输出为0的行：

| A    | B    | C    | ?    |
| ---- | ---- | ---- | ---- |
| 0    | 1    | 1    | 0    |
| 1    | 1    | 0    | 0    |
| 1    | 1    | 1    | 0    |

我们可以构建以下析取项：

- 第一行（A=0, B=1, C=1）： ¬A∨B∨C
- 第二行（A=1, B=1, C=0）： A∨B∨¬C
- 第三行（A=1, B=1, C=1）： A∨B∨C

将这些析取项用与（∧）连接起来，我们得到：

(¬A∨B∨C)∧(A∨B∨¬C)∧(A∨B∨C)

### 德摩根定律

¬(A ∧ B) ≡ ¬A ∨ ¬B
¬(A ∨ B) ≡ ¬A ∧ ¬B

### 分配律 Distributivity Law

(A ∧ B) ∨ (A ∧ C) ≡ A ∧ (B ∨ C)
(A ∨ B) ∧ (A ∨ C) ≡ A ∨ (B ∧ C)

## From Kira version Week 2

### Binary numbers

* **Denotation method:**  0b11或  101<sub>2</sub>

* 用十六进制表示长二进制数；对应关系如下,每个十六进制位可以代表四个二进制位

![image-20240731001134985](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240731001134985.png)

* OCTAL NUMBERS 八进制

* HEXADECIMAL NUMBERS 十六进制

* DECIMAL NUMBER 十进制

* BINARY NUMBER 二进制

* Octal can also be considered a shorthand form of binary! Each octal digit represents a 3-bit  binary number (a 3-bit binary number has a range of 23 = 8).八进制也可以用来化简长二进制数

  ![image-20240731001711021](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240731001711021.png)

* 这张幻灯片讨论了数字在不同进制（基数）系统中的表示和值。它展示了如何通过数学公式计算任意进制系统中的数字值，并通过实例说明同一个数字在不同进制下的含义和对应的十进制值。

  

### **BASE N VALUE****N进制数值**

#### 第一段

> **What about for a number system with base N, that uses N possible digits?**
>
> 对于使用 N 位的 N 进制数字系统如何理解

> **We can calculate the value of a number in base N using the following formula:**
>
> 我们可以使用以下公式计算 N 进制中数字的值：

公式：
$$
\sum_{i=0}^{D-1} x_i \cdot N^i
$$


#### 公式说明

- **公式解释**：
  - 表示对于一个由 D位x<sub>i</sub>组成的序列，i 的位置从 0 到 D-1。D digits x<sub>i</sub>
  - 每个位上数字的取值小于 N进制的N。
- **直观理解**：
  - 这个公式是计算 N 进制数字的总值。对每一个数字乘以它在该进制中对应的位置权重，然后求和。

#### 第二段

> **What’s the value of 101?**
>
> 101 的值是什么？

> **A number can represent several values until we define the base/representation:**
>
> 一个数字在未定义进制或表示方式之前可以代表多个值：

#### 表格解释

| **Representation** | **Notation**   | **Decimal value** |
| ------------------ | -------------- | ----------------- |
| **Decimal**        | 101₁₀          | 101               |
| **Binary**         | 101₂ or 0b101  | 5                 |
| **Hexadecimal**    | 101₁₆ or 0x101 | 257               |
| **Octal**          | 101₈ or 0o101  | 65                |

- Representation（表示方式）
  - **Decimal（十进制）**：标准的十进制，101 在此表示为 101。
  - **Binary（二进制）**：使用 0 和 1 组成的二进制数，101 在此表示为 5。
  - **Hexadecimal（十六进制）**：使用 0 到 F 的符号表示，101 在此表示为 257。
  - **Octal（八进制）**：使用 0 到 7 的符号表示，101 在此表示为 65。

- **十进制（Decimal）**：

  - **Notation**: `101₁₀`
  - **Decimal value**: 101
  - 十进制 101 的计算方式：
    - 1×102+0×101+1×100=100+0+1=1011 \times 10^2 + 0 \times 10^1 + 1 \times 10^0 = 100 + 0 + 1 = 1011×102+0×101+1×100=100+0+1=101

- **二进制（Binary）**：

  - **Notation**: `101₂` 或 `0b101`
  - **Decimal value**: 5
  - 二进制 101 的计算方式：
    - 1×22+0×21+1×20=4+0+1=51 \times 2^2 + 0 \times 2^1 + 1 \times 2^0 = 4 + 0 + 1 = 51×22+0×21+1×20=4+0+1=5

- **十六进制（Hexadecimal）**：

  - **Notation**: `101₁₆` 或 `0x101`
  - **Decimal value**: 257
  - 十六进制 101 的计算方式：
    - 1×162+0×161+1×160=256+0+1=2571 \times 16^2 + 0 \times 16^1 + 1 \times 16^0 = 256 + 0 + 1 = 2571×162+0×161+1×160=256+0+1=257

- **八进制（Octal）**：

  - **Notation**: `101₈` 或 `0o101`
  - **Decimal value**: 65
  - 八进制 101 的计算方式：
    - 1×82+0×81+1×80=64+0+1=651 \times 8^2 + 0 \times 8^1 + 1 \times 8^0 = 64 + 0 + 1 = 651×82+0×81+1×80=64+0+1=65

- D位N进制的取值范围

  从0到N的D次方

  ![image-20240731002939698](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240731002939698.png)

* **Computers** are **finite machines** that **use a fixed word size to represent numbers**. **Word size** is a  common hardware term used for **specifying the number of bits that computers use for  representing a basic chunk of information.**
* an unsigned int is stored using 4 bytes (byte = 8 bits) then this can store 2<sup>4×8</sup> values i.e. the binary equivalent of the decimal integers 0 to 4,294,967,295



### Half adder

**半加器（Half Adder）** 是一种用于二进制加法的基本数字电路，它可以对两个单个位进行加法运算。与全加器不同的是，半加器不处理进位输入，仅对两个输入位执行加法操作。

#### 半加器的功能

半加器接收两个输入：

1. **A**：第一个二进制数位。
2. **B**：第二个二进制数位。

输出两个信号：

1. **Sum**：加法结果的低位。
2. **Carry**：加法结果的进位。

#### 半加器的真值表

半加器的真值表如下：

| A    | B    | Sum  | Carry |
| ---- | ---- | ---- | ----- |
| 0    | 0    | 0    | 0     |
| 0    | 1    | 1    | 0     |
| 1    | 0    | 1    | 0     |
| 1    | 1    | 0    | 1     |

#### 半加器的逻辑表达式

根据真值表，可以得出半加器的逻辑表达式：

- **Sum（和）** 的逻辑表达式：XOR gate
  $$
  Sum=A⊕B
  $$
  

- **Carry（进位）** 的逻辑表达式：AND gate
  $$
  Carry=A∧B
  $$
  ![在这里插入图片描述](https://i-blog.csdnimg.cn/blog_migrate/6b3f007ba076389c5f4428567f891413.png)

### Full Adder

全加器（**Full Adder**）是数字电路中一种用于二进制加法运算的组合逻辑电路。它能够实现对三个二进制位进行加法运算，并输出一个和（Sum）和一个进位（Carry）。这是在计算机和数字系统中执行二进制加法的基础组件之一。

#### 全加器的功能

全加器接收三个输入：

1. **A**：第一个二进制数位
2. **B**：第二个二进制数位
3. **C_in**：来自低位的进位输入（Carry-in）

输出两个信号：

1. **Sum**：加法结果的低位
2. **C_out**：加法结果的高位（进位输出）

#### 真值表

全加器的真值表如下：

| C_in | A    | B    | C_out | S    |
| ---- | ---- | ---- | ----- | ---- |
| 0    | 0    | 0    | 0     | 0    |
| 0    | 0    | 1    | 0     | 1    |
| 0    | 1    | 0    | 0     | 1    |
| 0    | 1    | 1    | 1     | 0    |
| 1    | 0    | 0    | 0     | 1    |
| 1    | 0    | 1    | 1     | 0    |
| 1    | 1    | 0    | 1     | 0    |
| 1    | 1    | 1    | 1     | 1    |

#### 逻辑表达式

从真值表可以得出全加器的逻辑表达式：

**Sum** 的逻辑表达式：
$$
Sum=A⊕B⊕Cin
$$
**C_out** 的逻辑表达式：
$$
C_out=(A∧B)+(B∧Cin)+(A∧Cin)
$$
![使用半加器设计全加器](https://static.deepinout.com/geekdocs/2023/01/20230110211951-3.jpg)

### 全加器可以由Half adder组成

一个full adder能够被 created  from 2 half adders 

the first would calculate A+B 

and the second would calculate S+C_in.

![使用半加器设计全加器](https://static.deepinout.com/geekdocs/2023/01/20230110211951-6.jpg)

### 从NAND门实现XOR门

![img](https://static.deepinout.com/geekdocs/2023/01/20230110211959-6.jpg)





### 从NAND门实现OR门

![从NAND门实现OR门](https://static.deepinout.com/geekdocs/2023/01/20230110211957-4.jpg)

### XOR用and or not

$$
A⊕B=(A∧¬B)∨(¬A∧B)
$$



### “波纹进位加法器”（Ripple Carry Adder）

这是一个波纹进位加法器，其中每个全加器的输出进位（C_out）信号都是下一个全加器的输入进位（C_in）信号。它之所以这样命名，是因为从最低有效位（LSB）生成的进位信号会影响到所有更高位的结果。

#### 理解

**波纹进位加法器（Ripple Carry Adder）** 是一种基本的二进制加法器，用于将两个二进制数相加。它由多个全加器（Full Adders）级联组成，每个全加器负责一位的加法运算。

#### 工作原理

1. **级联结构**：
   - 波纹进位加法器由多个全加器连接而成，通常每个位数对应一个全加器。
   - 第一个全加器处理最低有效位（LSB），每个全加器的进位输出（C_out）被传递给下一个高位全加器的进位输入（C_in）。
2. **进位信号的传播**：
   - 在计算中，如果某个位的加法产生了进位，这个进位会传递到下一个更高位的加法器中。
   - 因此，从最低有效位（LSB）生成的进位信号会“波纹”式地传递到更高的位，这就是它被称为“波纹进位”的原因。

#### 举例说明

假设我们有两个四位二进制数相加：

A=1011A = 1011A=1011 B=0110B = 0110B=0110

使用波纹进位加法器：

1. **最低有效位（LSB）**：
   - 加法：1 + 0，Sum = 1，Carry = 0
2. **次低位**：
   - 加法：1 + 1，Sum = 0，Carry = 1（进位传递到下一位）
3. **次高位**：
   - 加法：0 + 1 + 进位1，Sum = 0，Carry = 1（进位传递到下一位）
4. **最高位**：
   - 加法：1 + 0 + 进位1，Sum = 0，Carry = 1（进位传递到最终的输出进位）

最终结果：

Sum=1001\text{Sum} = 1001Sum=1001 进位输出=1\text{进位输出} = 1进位输出=1

#### 优缺点

- **优点**：
  - 设计简单，容易实现。
  - 适用于小规模加法运算。
- **缺点**：
  - 由于进位需要逐位传播，从最低位到最高位，因此计算速度较慢，尤其是在处理大规模的二进制数时。
-  (¬a ∧ ¬b ∧ c) ∨ (a ∧ ¬b ∧ ¬c) ∨ (a ∧ ¬b ∧ c)
- not B ^（ (¬a  ∧ c) ∨ (a ∧ ¬c) ∨ (a  ∧ c)）

### 二进制减法

A - B ≡ A + (-B)

减法相当于与一个负数的加法。

二进制表示方式来表示带符号的数值，幸运的是，有三种常用的表示方法存在：

- 符号-幅度表示法（Sign-magnitude）

- 反码表示法（1's complement）

- 补码表示法（2's complement）

- **符号-幅度表示法**：使用一个bit二进制位表示符号（正负），其余比特表示数值的大小。

  **反码表示法**：正数保持不变，负数通过对正数的每一位取反（即 0 变 1，1 变 0）来表示。

  **补码表示法**：是最常用的方法，负数通过对正数的每一位取反并加一来表示。

### 二进制原码 反码 补码

#### 反码

正数反码等于自己
负数等于它的正数按位取反 OR 负数等于自己除了符号位按位取反

#### 补码

正数等于自己

负数等于队自己的正数按位取反+1

#### 二进制减法B站全笔记

![img](https://i0.hdslb.com/bfs/note/f1f2189d72f622773155ff5950c745de8806cca5.png)

### 浮点数表示

(−1) <sup>S</sup> ⋅M⋅B<sup>E</sup>

其中，S = 符号，M = 尾数，B = 基数(N进制基数等于N)，E = 指数

| 符号S | 指数E | 尾数M       | 十进制结果            |
| ----- | ----- | ----------- | --------------------- |
| 1     | 0 1 0 | 0 0 0 0 0 1 | -1 · 1 · 2^2 = -4     |
| 0     | 1 0 0 | 0 1 0 0 1 1 | 1 · 5 · 2^-4 = 0.3125 |

* 单精度浮点数（float）使用 32 位，其中 1 位用于符号，8 位用于指数，23 位用于尾数。

* 双精度浮点数（double）使用 64 位，其中 1 位用于符号，11 位用于指数，52 位用于尾数。

### 定点数

**定点数**

使用整数时我们会丢失精度，因为我们无法表示非整数。定点表示法是表示小数的一种选项，它类似于二进制，除了部分位表示小数（仍然是2的幂次）。

| 记法  | 2^1  | 2^0  | 2^-1 | 2^-2 | 十进制结果                                |
| ----- | ---- | ---- | ---- | ---- | ----------------------------------------- |
| 00.01 | 0    | 0    | 0    | 1    | 2^-2 = 0.25                               |
| 01.01 | 0    | 1    | 0    | 1    | 2^0 + 2^-2 = 1 + 0.25 = 1.25              |
| 11.00 | 1    | 1    | 0    | 0    | 2^1 + 2^0 = 2 + 1 = 3                     |
| 10.11 | 1    | 0    | 1    | 1    | 2^1 + 2^-1 + 2^-2 = 2 + 0.5 + 0.25 = 2.75 |