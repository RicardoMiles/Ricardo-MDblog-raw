# 十日CPP补缺

下面是一个为期两周的C++学习计划，针对我已有的C语言基础，并且为LeetCode刷题做准备。计划中强调与C语言的对比，并包含大量练习和习题：

### 第1周

#### 第1天：C++基础语法与数据类型

- **学习内容**：C++中的变量类型（int, double, string等）、基本输入输出（`cin`, `cout`）与C语言的`printf`, `scanf`的区别
- **对比**：C++的输入输出流与C语言的标准I/O函数对比
- **练习**：
  - 简单输入输出练习（例如：计算两个数的和）
  - LeetCode Easy 题目：Two Sum

#### 第2天：引用与指针

- **学习内容**：C++的引用（`&`），指针与C语言的不同，指针与引用的用法
- **对比**：C++中引用的概念与C语言中只用指针操作内存的不同
- **练习**：
  - 编写使用引用和指针交换两个变量值的程序
  - LeetCode Easy 题目：Reverse Linked List

#### 第3天：函数与函数重载

- **学习内容**：C++中的函数、函数重载、默认参数
- **对比**：函数重载与C语言中没有重载的单一函数名的区别
- **练习**：
  - 编写多个重载函数，处理不同的数据类型
  - LeetCode Easy 题目：Valid Parentheses

#### 第4天：面向对象编程概念 - 类与对象

- **学习内容**：C++中的类和对象，成员变量、成员函数、构造函数与析构函数
- **对比**：C语言没有类的概念，通过结构体模拟类的简单用法
- **练习**：
  - 编写简单的类，如`Rectangle`类，包含计算面积和周长的成员函数
  - LeetCode Easy 题目：Merge Two Sorted Lists

#### 第5天：继承与多态

- **学习内容**：继承、多态（虚函数）、抽象类
- **对比**：C语言没有内置的面向对象支持，通过函数指针实现多态
- **练习**：
  - 创建一个基类`Animal`和派生类`Dog`与`Cat`，实现虚函数`makeSound()`
  - LeetCode Medium 题目：Add Two Numbers

#### 第6天：C++ STL介绍

- **学习内容**：C++标准模板库（STL）中的vector、list、map等常用容器
- **对比**：STL容器与C语言中的数组和手动管理的链表对比
- **练习**：
  - 使用`vector`实现一个简单的动态数组，比较与C语言手动管理内存的区别
  - LeetCode Medium 题目：Longest Substring Without Repeating Characters

#### 第7天：总结与复习

- **复习内容**：前六天学习的所有知识点
- **练习**：
  - 复习前面写的代码，优化和改进
  - LeetCode综合练习（前几天练习的题目都重做一次）

### 第2周

#### 第8天：模板与泛型编程

- **学习内容**：模板函数与模板类
- **对比**：C语言中没有模板功能，更多地依赖于宏定义
- **练习**：
  - 编写模板函数计算不同数据类型的最大值
  - LeetCode Medium 题目：Generate Parentheses

#### 第9天：异常处理

- **学习内容**：C++的异常处理机制（`try-catch`块），与C语言中的错误处理方式（返回值、`errno`等）
- **对比**：C++提供了更结构化的错误处理机制，而C语言使用错误代码
- **练习**：
  - 编写一个抛出和捕获异常的程序
  - LeetCode Medium 题目：Container With Most Water

#### 第10天：智能指针与内存管理

- **学习内容**：C++的智能指针（`shared_ptr`, `unique_ptr`），与C语言的手动内存管理（`malloc/free`）对比
- **对比**：C++中智能指针的自动内存管理与C语言中必须手动管理内存的区别
- **练习**：
  - 使用`shared_ptr`和`unique_ptr`管理动态内存
  - LeetCode Medium 题目：Linked List Cycle

#### 第11天：Lambda表达式与函数对象

- **学习内容**：C++中的Lambda表达式与函数对象
- **对比**：C语言没有Lambda表达式，只能通过函数指针和普通函数实现类似功能
- **练习**：
  - 编写一个使用Lambda表达式进行排序的程序
  - LeetCode Medium 题目：Partition Equal Subset Sum

#### 第12天：STL高级 - 算法与迭代器

- **学习内容**：STL中的常用算法（`sort`, `find`等）与迭代器的使用
- **对比**：STL算法与C语言中通过循环手动实现算法的不同
- **练习**：
  - 使用STL算法对数组和容器进行操作
  - LeetCode Hard 题目：Sliding Window Maximum

#### 第13天：并发编程基础

- **学习内容**：C++11中的多线程与并发编程
- **对比**：C语言中的pthread库与C++11内置的多线程支持
- **练习**：
  - 编写一个多线程程序，计算大数组的并行求和
  - LeetCode Hard 题目：LRU Cache

#### 第14天：总结与LeetCode实战

- **复习内容**：复习第二周的所有知识点
- **练习**：
  - 复习前几天的LeetCode题目，并挑战一些新的LeetCode Hard难度题目
  - LeetCode Hard 题目：Merge k Sorted Lists

通过这两周的学习和大量练习，我将掌握C++的核心知识，并且能够将其运用到LeetCode题目中。