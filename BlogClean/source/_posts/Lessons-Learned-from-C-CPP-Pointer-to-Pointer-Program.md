---
title: Lessons Learned from C&C++ Pointer to Pointer Program
date: 2025-04-21 14:52:50
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "Debugging Log from a Pointer to Pointer practice, learned how to allocate Pointers to Pointer on heap."

---

## Original Code

```cpp
/*
Exercise 4: Pointer to Pointer
Implement a program to:
1. Declare a pointer-to-pointer (e.g., int** ptr).
2. Dynamically allocate memory for an integer and assign a value through the pointer-to-pointer.
3. Print the value and address.
*/

#include <iostream>

using namespace std;

int main(){
    int** ptrToPtr = nullptr;
    int* ptr = new int;
    ptrToPtr = &ptr;
    *(*(ptrToPtr)) = 9527;
    cout << "The value should be 9527, and it is\n" << *(*(ptrToPtr)) <<
    "\nThe address of the dynamically allocated int is\n" << *(ptrToPtr) <<
    "\nIt is implementation of pointer to pointer by\n" << 
    "int** ptrToPtr = nullptr;\nint* ptr = new int;\nptrToPtr = &ptr;\n*(*(ptrToPtr)) = 9527;" << endl;
    delete ptr;
    ptr = nullptr;
    delete ptrToPtr;
    ptrToPtr = nullptr;
    return 0;
}
```

## **Incorrect `delete` of Stack-Allocated Pointer-to-Pointer**

### **Error:**

I wrote:

```c++
delete ptrToPtr;
```

But `ptrToPtr` was **not allocated with `new`**, so deleting it causes **undefined behaviour and a crash**.

### **Lesson:**

- `ptrToPtr` is a **pointer to a pointer**. Specifically, it points to `ptr`.

- `ptr` is dynamically allocated with `new int;`, so it's safe to `delete ptr;`.

- BUT `ptrToPtr` is **not** dynamically allocated. It just points to a local variable `ptr`, which lives on the stack.

- Calling `delete ptrToPtr;` tries to free stack memory, which causes **undefined behaviour**, hence the runtime error.

- Only call `delete` on pointers that were allocated using `new`.

- In this case, `ptrToPtr` was just pointing to a local (stack-allocated) variable `ptr`, so:

  - `delete ptrToPtr;` is **invalid**, because `ptrToPtr` points to stack memory

  - `delete ptr;` is **correct**, because `ptr` points to heap memory.

### **Correct Way:**

```cpp
delete ptr;
// DO NOT do this:
// delete ptrToPtr;

ptr = nullptr;
ptrToPtr = nullptr;
```

## How to Declare a Pointer to a Pointer on the Heap

To **declare and allocate a pointer-to-pointer on the heap**, we need to use `new`  operatior **twice**—once for the outer pointer(`ptrToPtr`) and once for the inner pointer(`ptr`). Here's how it works:

```cpp
#include <iostream>
using namespace std;

int main() {
    // Step 1: allocate memory for a pointer (int*) on the heap
    int** ptrToPtr = new int*;

    // Step 2: allocate memory for an integer (int) on the heap
    *ptrToPtr = new int;

    // Step 3: clean up memory in reverse order
    delete *ptrToPtr;  // delete inner int
    *ptrToPtr = nullptr;
    delete ptrToPtr;   // delete outer pointer
    ptrToPtr = nullptr;
    return 0;
}

```

* `ptrToPtr` points to a pointer on the heap (`new int*`).

* `*ptrToPtr` is a pointer to an int, which also lives on the heap (`new int`).

* This setup is entirely heap-allocated.

*  We **must delete** both: first the inner `int`, then the outer `int*`.

## Final Corrected Code

```cpp
#include <iostream>

using namespace std;

int main(){
    int** ptrToPtr = new int*;
    *ptrToPtr = new int;
    *(*(ptrToPtr)) = 9527;
    cout << "The value should be 9527, and it is\n" << *(*(ptrToPtr)) <<
    "\nThe address of the dynamically allocated int is\n" << *(ptrToPtr) <<
    "\nIt is implementation of pointer to pointer by\n" << 
    "int** ptrToPtr = new int*;\n*ptrToPtr = new int;\n*(*(ptrToPtr)) = 9527;" << endl;
    delete *ptrToPtr;
    *ptrToPtr = nullptr;
    delete ptrToPtr;
    ptrToPtr = nullptr;
    return 0;
}
```

## Key Takeaways for Future Code:

**1. Stack vs Heap Memory**

- Stack memory is automatically managed. You **must not** delete it manually.

  ```
  cpp
  
  
  复制编辑
  int* ptr; // lives on the stack (DO NOT delete)
  ```

- Heap memory is manually allocated and must be freed.

  ```
  cpp
  
  
  复制编辑
  int* ptr = new int; // lives on the heap (MUST delete)
  ```

**2. Ownership of Memory**

- You should only `delete` memory you explicitly allocated with `new`.
- Never delete something just because you have a pointer to it.

**3. Correct Usage of Pointer to Pointer**

- You can use a pointer-to-pointer to access and modify dynamically allocated memory indirectly.
- But you **shouldn’t confuse the indirection with ownership**—having `int**` doesn’t mean you own that memory unless you used `new` on that level.
