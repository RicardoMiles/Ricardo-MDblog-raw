---
title: 'DSA Beginner: Array Supplement 代码随想录-数组补充'
date: 2025-01-07 15:26:46
tags:
 - CS Learning
 - CPP
 - Java
 - LeetCode
 - Vocabulary
 - English Learning
 - SLA
 - Data-Struct
 - Algorithm
categories:
 - Coding
excerpt: "Supplementary Materials for Learn Algorithm with Carl.《代码随想录》数组部分额外延伸和主动学习。"
---

# 代码随想录学习log和产生疑问

## Note

* 数组是存放在连续内存上的相同类型数据的集合。

* 数组内存空间的地址是连续的
* 正因为数组在内存空间上是连续的，所以我们在删除或者添加一个元素到数组时，难免要移动其他元素的地址。例如，删除索引为3的元素，那么4号元素以及之后所有元素的下表都改为：当前值-1。
* C++中二维数组是连续分布的。
* 使用C++的话要注意vector和array的区别，vector的底层实现是array，严格来说，vector是容器，不是数组。
* 数组的元素是不能删的，只能覆盖。
* C++中二维数组正在地址空间上是连续的，先第一行`row 0` 的`0`号元素开始连续一直到这一行结束，然后第二行`row1`的`0`号元素地址接着第一行`n`号元素（第一行最后一个）元素的后面。

## Question

* 我有点忘记C语言里面关于字符串是数组语法糖的相关内容了，注意复习下Syntax Sugar。

  * In C, strings are actually arrays of characters that end with a null terminator `\0`.

    ```c
    char str1[] = "hello";   // Assign 6 char automatically(including'\0')
    char str2[6] = "hello";  // Mannually designate size ensuring space for'\0'
    char str3[] = {'h','e','l','l','o','\0'};  // Equivalent Code (No Syntax Sugar)
    ```

* Carl讲了C++中数组、多维数组的内存空间分布，但是没有说清楚Java（一方面因为教程C++为主，另外一方面pdf版可能落后）。所以，Java的多维数组内存怎么管理的，怎么弄的

  * Java 中的多维数组不是连续内存块

  * Java 的多维数组其实是**数组的数组(Array of arrays)**，Multidimensional arrays themselves store pointer&reference to three array

  * 内存管理上，每一行是独立分配的 `int[]`

  * 访问时：`matrix[i][j]` 其实是两次解引用

  * 支持不规则（jagged）结构

    ```java
    // Jagged Array in JAVA
    int[][] jagged = new int[3][];
    jagged[0] = new int[2];
    jagged[1] = new int[4];
    jagged[2] = new int[1];
    ```

* 那么到底vector和array啥区别 -> 见补充笔记

* 那么具体vector怎么用array来达成底层实现的 -> 见补充笔记

# Supplementary materials for Array 

## What is an array

An **array** in C++ is a collection of elements of the **same data type** stored in **contiguous memory locations.** Arrays have the following properties:

* **Fixed Size**: The size must be known at compile-time.

* **Indexing**: Elements are accessed via indices starting from 0.

* **Homogeneous Elements**: All elements must be of the same type.

### **SLA part**

* **Continuous** deals with **time or sequence** (uninterrupted flow or action).

* **Contiguous** deals with **space** (touching or adjacent physical objects).

* **Homogeneous** Same or similar **throughout**, all parts being alike

* **Throughout** From start to end completely

  

### **Syntax Example**

```cpp
int arr[5] = {1, 2, 3, 4, 5}; // An integer array with 5 elements
char helloArray[6] = "hello";
char helloArray[6] = {'h','e','l','l','o','\0'};
double doubleArray[3] = {3.14, 4.19, 5.18};
```

## Array and Vector

What is the Difference Between Array and Vector in C++?

| Feature           | Array                                                  | vector                                                       |
| ----------------- | ------------------------------------------------------ | ------------------------------------------------------------ |
| Size              | Fixed at compile-time                                  | Dynamic; can grow or shrink at runtime                       |
| Memory Allocation | Contiguous memory allocated statically or on the stack | Contiguous memory dynamically allocated on the heap          |
| Flexibility       | No resizing; size is fixed                             | Can resize dynamically using `.push_back()`, `.resize()`     |
| Operations        | Limited operations(e.g., no insert or erase)           | Rich STL funstionalities (e.g., push_back, pop_back)         |
| Performance       | Faster for fixed-size data due to no overhead          | Slightly slower due to dynamic allocation and management overhead |

### **SLA part**

* **Overhead**
  - Above your head (position)
  - **Extra business costs (finance, shown in above)**
  - Throwing arms above head (sports)

## Implement a Vector Using Array

We can simulate a vector’s behavior using arrays by manually handling resizing and dynamic memory allocation.

```cpp
#include <iostream>
#include <cstdlib> // For malloc and realloc

class MyVector{
  private:
  	int* arr; // Pointer to the array
    int capacity; // Total capacity of the array
    int size; // Current number of elements
  public:
  	MyVector() {
      arr = (int*)malloc(2 * sizeof(int)); // Initial capacity of 2
      capacity = 2;
      size = 0;
		}

    ~MyVector() {
        free(arr);  // Free the allocated memory
    }

    void push_back(int value) {
        if (size == capacity) {
            capacity *= 2;
            arr = (int*)realloc(arr, capacity * sizeof(int));
        }
        arr[size++] = value;
    }

    int get(int index) {
        if (index >= size || index < 0) {
            throw std::out_of_range("Index out of bounds");
        }
        return arr[index];
    }

    int getSize() {
        return size;
    }
};

int main() {
    MyVector vec;
    vec.push_back(10);
    vec.push_back(20);
    vec.push_back(30);

    for (int i = 0; i < vec.getSize(); ++i) {
        std::cout << vec.get(i) << " ";
    }
    return 0;
}
```

## Features of Array in C++

* **Contiguous Memory**: Stored in continuous memory blocks.
* **Fixed Size**: Declared at compile-time and cannot be resized.
* **Zero-based Indexing**: Access starts from index 0.
* **Fast Access**: Random access is O(1) due to indexing.
* **Multidimensional Support**: Can create 2D or multi-dimensional arrays.

```cpp
int matrix[3][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}}; // 2D array
```

## **Typical Algorithms  Related to Arrays**

 1. **Search**: Linear search (**O(n)**) and binary search (**O(log n)** for sorted arrays).
    * Linear Search in Array of int
    
    * Linear Search in a Vector (Using STL containers)
    
    * Case-Insensitive Linear Search in a String
    
    * Finding an Object in a List of Objects by Linear Search
    

​	2.	**Sorting**: QuickSort, MergeSort, BubbleSort, etc.

​	3.	**Sliding Window Technique**: For subarray problems (e.g., maximum sum of subarray of size k).

​	4.	**Prefix Sum**: To calculate cumulative sums efficiently.

​	5.	**Two Pointers Technique**: Often used for pair problems like finding two numbers that sum to a target.

​	6.	**Kadane’s Algorithm**: To find the maximum subarray sum (O(n)).

## Questions on LeetCode Related to Arrays

Here are popular LeetCode questions that involve arrays:

**Easy Level:**

​	•	**Two Sum** (Problem #1)

​	•	**Remove Duplicates from Sorted Array** (Problem #26)

​	•	**Maximum Subarray** (Problem #53)

**Medium Level:**

​	•	**3Sum** (Problem #15)

​	•	**Container With Most Water** (Problem #11)

​	•	**Subarray Sum Equals K** (Problem #560)

**Hard Level:**

​	•	**Trapping Rain Water** (Problem #42)

​	•	**Longest Consecutive Sequence** (Problem #128)

These problems cover array traversal, dynamic programming, prefix sums, and more.
