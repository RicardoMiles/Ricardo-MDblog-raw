---
title: Reflection on Scope Rules and Dangling Pointer
date: 2025-03-26 17:15:31
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "Reflection on pointer reassignment bug. Related with Scope Rules in C++, Dangling Pointer concept and `sizeof()`/`size()` function."

---

Reflection on pointer reassignment bug. Related with Scope Rules in C++, Dangling Pointer concept and `sizeof()` / `size()` function.

## The Root Error

```cpp
#include <iostream>
using namespace std;

int main(){ 
    int* numbers = new int[5];
    int entries = 0;
    bool resized = false;
    
    // Constantly ask users to enter a number
    // Store it to our array
    while(true){
        cout << "Number: ";
        cin >> numbers[entries];
        // check whether it is a valid number or not
        // if cin.fail() returns True means
        // users enter something can't be converted to a number
        // we're gonna break out of this loop
        if(cin.fail()){
            break;
        }
        // otherwise we're going to increase entries by 1
        entries++;
        // Resize the array when it is full
        if(entries == 5){
            // Create a temp array (twice the size)
            // Copy all the elements
            // Have "numbers" pointer point to the new array
            int arraySize = sizeof(numbers)/sizeof(numbers[0]);
            cout << "The arraySize = " << arraySize << endl;
            int extendedSize = 2 * arraySize;
            int* temp = new int[10];
            for(int i = 0; i < arraySize; i++){
                temp[i] = numbers[i];
            }
            delete[] numbers;
            int* numbers = &(temp[0]);
            resized = true;
        }
    }

    // loop to print user-entered numbers so far
    for (int i = 0; i < entries; i++){
        cout << numbers[i] << endl;
    }
    
    if(resized){
        delete[] numbers;
    }

    return 0; 
}
```

When I compiled the code and make it run, bugs emerges like below:

```shell
PureCppExercise % ./ResizeArray                      
Number: 1
Number: 2
Number: 3
Number: 4
Number: 5
The arraySize = 2
Number: 6
Number: 7
Number: _
-392708096
46369
0
0
0
6
7
ResizeArray(98894,0x1e6263840) malloc: *** error for object 0x6000029cc000: pointer being freed was not allocated
ResizeArray(98894,0x1e6263840) malloc: *** set a breakpoint in malloc_error_break to debug
zsh: abort      ./ResizeArray
```

There are at 3 issues

* Failure in malloc operation `*** error for object 0x6000029cc000: pointer being freed was not allocated`
* The `arraySize` calculation is improper.
* Junction values showed in output

Related concept and mechanism questions I had

* Scope Rules in C++ from compiler's POV
* Dangling Pointer
* The difference between destroying a pointer and destroying the memory block a pointer points to.
* The calculation method variation on Fixed Array and Dynamic Array
  * Why `sizeof(arrayVariableName)/sizeof(arrayVariableName[0])` works for fixed-size arrays but not for dynamic arrays
  *  Why the size information of dynamic arrays is lost at runtime
  * Why `sizeof()` behaves differently for fixed-size arrays and dynamic arrays

## Outside Scope Issue

```cpp
delete[] numbers;
int* numbers = &(temp[0]);
resized = true;
```

It led to a change in its scope. 

* **I redefined a `numbers` in those 3 lines. It is impossible to free this inner one.**
* The redefined `numbers` pointer(inner one) **shadows** the outer `numbers`.
* When the inner `numbers`active, the outer one still alive, but hide away.
* The inner one binding with `temp` will die outside of if condition.
*  When `if` block finishes execution (the `if` block inside the `while` loop), there is still an `numbers`. (Original one but had been freed already inside `if` block)
* The deallocation error is due to `delete` operator couldn't free a memory block that never be allocated : **Both** original memory block outer `numbers` points to **AND** memory block inner `numbers` points to **don't exist anymore.**
  * The memory block that original outer pointer pointed to had been freed inside the `if` block, it was bind with a memory without allocation, it became dangling pointer. When we execute the last `delete` operation narrowly before `return 0;`, the address it points to & the memory it bind with has no allocation. 
  * Inner `numbers` pointer is a local pointer variable to `if` block, it has already died after execution of `if` condition. When we execute the last `delete` operation narrowly before `return 0;`, there is no inner `numbers` anymore.

Since the lifetime of a pointer variable depends on its scope, I should just avoid redefining the `numbers` pointer. When I `delete[] numbers`, only the original memory block `numbers` pointed to was being freed, original `numbers` pointer itself was still alive. **I don't need to redefine an existing pointer.**

The outer `numbers` pointer is local variable of `main()` function, which means it is the so-called "global variable" to `if` block.

So, fix `int* numbers = &(temp[0])` by `numbers = temp[0]`  or `numbers = temp`. 

### Scope Rules in C++  (Shadowing Mechanics)

In C++, scopes are nested. When we define a variable with the same name in a nested scope, this inner variable **shadows** the outer variable. This means that within the nested scope, any reference to the variable name will refer to the inner variable, not the outer one.

### Compiler's Actions

1. **Variable Definition**:
   - The compiler records each variable's definition location and scope.
   - When entering the `if` block, it records a new definition for `numbers` with a scope limited to the `if` block.
2. **Variable Reference**:
   - Within the `if` block, any reference to `numbers` is resolved to the inner scope's variable.
   - Outside the `if` block, references to `numbers` resolve to the outer scope's variable.
3. **Scope End**:
   - When the `if` block ends, the inner scope's `numbers` is destroyed, but the outer scope's `numbers` remains.

## Size Calculation Variation

I got 2 from the calculation of  a 5-size dynamic array, which is very weird.

### Why `sizeof()` works for fixed-size arrays but not for dynamic arrays

* **For fixed-size arrays** (e.g., `int numbers[5];`), `sizeof(arrayVariableName)` gives the total size of the array in bytes, and `sizeof(arrayVariableName[0])` gives the size of one element in the array. **By dividing the total size by the size of one element, we get the number of elements in the array.** This works because the size of fixed-size arrays is determined at compile time, and the compiler knows the total size of the array.

* **For dynamic arrays** (e.g., `int* numbers = new int[5];`), `numbers` is a pointer, and `sizeof(numbers)` returns the size of the pointer itself (usually 4 or 8 bytes), not the size of the array it points to. Therefore, `sizeof(numbers)/sizeof(numbers[0])` does not correctly calculate the size of the array.

### Why the size information of dynamic arrays is lost at runtime

* Because when we allocate a dynamic array using `new`, we get a pointe  to the first element of the array as return.
* This pointer **does not store any information about the size** of the array. 
* Therefore, once the array is allocated, its size information is no longer tracked unless we manually save this information. 
* **In brief, it's due to the feature of `new` operator that returns only the first element's address!**

### Why `sizeof()` behaves differently for fixed-size arrays and dynamic arrays

**My question: I thought both fixed-size arrays and dynamic arrays are indeed treated as pointers, but why `sizeof()` function returns different value when they are same size?**

From the compiler's perspective, both fixed-size arrays and dynamic arrays are indeed treated as pointers in many contexts, but their behavior and semantics differ. **For fixed-size arrays**, the array name typically decays to a pointer to the first element of the array in most contexts, **but in the `sizeof` operation, the array name does not decay to a pointer.** Instead, it represents the entire array. Therefore, `sizeof(arrayVariableName)` gives the size of the entire array.

**For dynamic arrays**, `numbers` is a pointer, and `sizeof(numbers)` returns the size of the pointer itself, not the size of the array it points to. This is because the size information of dynamic arrays is lost at runtime, and the compiler cannot know the actual size of the array that the pointer points to.

## Pointer Persistence v.s. Memory Deallocation

Deleting the memory block a pointer refers to (using `delete` or `delete[]`) does **not** destroy the pointer variable itself. The pointer still exists, but the memory it points to has been deallocated. Accessing this memory after it’s been freed results in **undefined behaviour**.

**Lifetime of the pointer variable:**

* The lifetime of a pointer variable depends on its scope.
* If it is a **local variable**, it will be destroyed when it goes out of scope.
* If it is a **global variable** or a **member variable** of a class, its lifetime is determined by the lifetime of its enclosing context.

**SOP for pointer working with dynamic allocated stuff on heap**

* `new` operator to allocate the momory, bind the address with pointer variable
* ……
* `delete` + `pointer_variable_name` to deallocate the memory pointer points to 
* Assign `nullptr` to the pointer varaible for avoiding dangling pointer.

## Dangling Pointer

A dangling pointer refers to a pointer that continues to reference a memory location that has already been deallocated or no longer valid.

1. **Memory Deallocation**: When the memory that a pointer points to is freed using `delete` (in C++) or `free` (in C), the pointer still holds the address of the freed memory. **MY SITUATION**
2. **Local Variable Out of Scope**: When a pointer points to a local variable, and the scope of that local variable ends, the pointer becomes dangling.
3. **Returning Address of Local Variable**: When a function returns the address of a local variable, the local variable is destroyed when the function ends, making the returned pointer invalid

The dangling pointer in my program led to deallocation failure crash.

## Why Garbage Values

Although I avoid using the `arraySize` by substituting it with 10, the `for` loop still uses `arraySize` as edging case. (Which is incorrect calculation resulted by misunderstanding of `sizeof()` function). Using  `2` means the rest of 10-size `temp` will be filled in by garbage values automatically. 

I had already use the correct way to track the size of dynamic array, but I didn't realised its function. The `entries` is the actual size I should use for edge case of for loop.

## Final Fix

```cpp
#include <iostream>
using namespace std;

int main() {
    int capbility = 5;
    int* numbers = new int[capbility];
    int entries = 0;   // Use a variable to track the entry point

    while (true) {
        // Ask for number from user, then store in numbers
        cout << "Number: ";
        cin >> numbers[entries];

        // Check whether it is a valid number or not
        if (cin.fail()) {
            cin.clear(); // Clear the error state
            cin.ignore(numeric_limits<streamsize>::max(), '\n'); // Ignore the invalid input
            break;
        }

        // Otherwise, we're going to increase entries by 1
        entries++;

        // Resize the array when it is full
        if (entries == capbility) {
            // Create a temp array (twice the size)
            // Copy all the elements
            // Have "numbers" pointer point to the new array
            cout << "The arraySize = " << capbility << endl;
            int extendedSize = 2 * capbility;
            int* temp = new int[10];
            for (int i = 0; i < capbility; i++) {
                temp[i] = numbers[i];
            }
            delete[] numbers;
            numbers = temp; // Update the pointer to the new array
            capbility = extendedSize;
        }
    }

    // Loop to print user-entered numbers so far
    for (int i = 0; i < entries; i++) {
        cout << numbers[i] << endl;
    }

    // Free the allocated memory
    delete[] numbers;

    return 0;
}

```

* Use `capbility` to give full access to infinite dynamic allocation and avoiding magic number.
* Fix the incorrect logic to update `numbers` pointer and its deallocation process.
* Avoid using `sizeof()` function to track the size of dynamic allocated array.
