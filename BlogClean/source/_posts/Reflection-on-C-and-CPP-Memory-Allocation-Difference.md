---
title: Reflection on C and C++ Memory Allocation Difference
date: 2025-04-20 23:04:00
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "`new`&`delete` v.s. `malloc()`&`realloc()`, thinking and learning from the underlying implementation of C++ memory allocation."
---

When I was coding in C at uni,  I was always confused about how to manage memory manually. Although I used `malloc()` and `realloc()`, I’m a bit rusty on how they work now. And you know, what's learned from textbook and slides always feels shallow  – even back then, I didn’t deeply and thoroughly understand those things.

So I’ve decided to work it out and strengthen my comprehension and memory by logging this brainstorming and learning process — and, by the way, augmenting it by implementing C++'s `delete` and `new` using lower-level C techniques.

## What is `malloc()` ，`calloc()` and `realloc()`



## Stack vs Heap in C and C++

### Stack

- A region of memory that stores **local variables** and **function call information**.
- Managed **automatically** by the compiler.

**Key properties:**

- Fast allocation and deallocation (LIFO – last-in, first-out)
- Memory is freed **automatically** when the function returns
- Limited in size (usually a few megabytes)
- No need to call `free()` or `delete`

**Examples:**

C

```cpp
void func() {
    int x = 10;  // 'x' is stored on the stack
}
```

C++

``` cpp
void func() {
    int x = 10;         // stack variable
    std::string name;   // still on the stack, but with constructor/destructor
}
```

### Heap

- A region of memory used for **dynamic allocation**.
- Managed **manually** by the programmer.

**Key properties:**

- Allocated using functions like `malloc()`/`calloc()` (in C) or `new` (in C++)
- Must be **manually deallocated** using `free()` (in C) or `delete` (in C++)
- Memory stays allocated until explicitly freed
- Useful when size or lifetime of data is not known at compile time

- A region of memory used for **dynamic allocation**.
- Managed **manually** by the programmer.

**Examples:**

C

```c
#include <stdlib.h>

void func() {
    int *p = (int *)malloc(sizeof(int));  // heap allocation
    *p = 42;
    free(p);                              // free the heap memory
}
```

C++

```c++
void func() {
    int *p = new int;     // allocate on heap
    *p = 42;
    delete p;             // deallocate memory

    std::string* name = new std::string("Alice");
    delete name;          // always match new with delete
}
```

| Feature          | Stack                     | Heap                                |
| ---------------- | ------------------------- | ----------------------------------- |
| Lifetime         | Automatically managed     | Manually managed                    |
| Allocation Speed | Fast                      | Slower                              |
| Memory Size      | Limited (few MBs)         | Much larger (system dependent)      |
| Syntax in C      | Just declare              | `malloc()`, `calloc()`, `free()`    |
| Syntax in C++    | Just declare              | `new`, `delete`                     |
| Use Case         | Temporary local variables | Dynamic data (e.g. arrays, objects) |

## In C++: `malloc()`/ `free()` vs `new`/`delete`



## My Implementation of `new` and `delete`



## 
