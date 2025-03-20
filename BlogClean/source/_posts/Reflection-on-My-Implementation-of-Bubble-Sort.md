---
title: Reflection on My Implementation of Bubble Sort
date: 2025-03-10 16:36:42
tags:
 - CS Learning
 - CPP
 - LeetCode
 - Vocabulary
 - English Learning
 - SLA
 - Data-Struct
 - Algorithm
categories:
 - Coding
excerpt: "Reflection on my implementation of bubble sort algorithm in C++"

---

## My Recursive Version 

Analysis of my **Bubble Sort** implementation and the potential deviations in my understanding of the algorithm.

```cpp
void bubbleSort(int numbers[], int size){
    int unbalanced = 0;
    for(int i = 0; i < size - 1; i++){
        if(numbers[i] > numbers[i + 1]){
            swap(numbers, i, i + 1);
            unbalanced = unbalanced + 1;
        }
    }
    if(unbalanced != 0){
        bubbleSort(numbers, size);
    }
}
```

------

### **Core Principles of Bubble Sort**

1. **Gradually "Bubbling" the Largest Element to the End**:
   - Each pass through the array moves the largest unsorted element to its correct position.
   - The range of each pass should gradually decrease because the end portion of the array becomes sorted.
2. **Optimization**:
   - If no swaps occur during a pass, the array is already sorted, and the algorithm can terminate early.

------

### **Analysis of My Code**

#### **Strengths**

- I correctly implemented the **compare-and-swap** logic, which is the core of Bubble Sort.
- I used the `unbalanced` variable to track whether any swaps occurred, which is a valid way to determine if the array is already sorted. 

#### **Deviations**

1. **No Gradual Reduction in Pass Range**:

   - My code always traverses the entire array (`size - 1` comparisons) in each recursive call.
   - This results in redundant checks on the already sorted portion of the array, reducing efficiency.

2. **Suboptimal Recursion Termination**:

   - I used `unbalanced` to decide whether to make a recursive call, which is a good idea.
   - However, even if the array is already sorted, your code will still traverse the entire array once before realizing `unbalanced == 0` and terminating.

   - If no swaps occur during a pass, the array is already sorted, and the algorithm should terminate immediately.

------

### **Misunderstandings in My Approach**

1. **Understanding of Pass Range**:
   - I have thought that each pass needs to check the entire array, but in reality, the range should decrease because the end portion is already sorted. **I did not understand the largest elements has been sorted to the end of array by adjacent comparison.**
2. **Understanding of Recursion Termination**:
   - While my use of `unbalanced` is correct, it doesn't take advantage of the optimization that reduces the pass range.

------

### **Improvement**

Here’s the improved code:

```cpp
void bubbleSort(int numbers[], int size){
    int unbalanced = 0;
    for(int i = 0; i < size - 1; i++){
        if(numbers[i] > numbers[i + 1]){
            swap(numbers, i, i + 1);
            unbalanced = 1; // A swap occurred
        }
    }
    if(unbalanced){
        // Recursively sort the remaining portion
        bubbleSort(numbers, size - 1);
    }
}
```

------

### **Dynamic Execution of the Improved Code**

Let’s use the array `[5, 3, 8, 4, 6]` as an example:

#### **First Recursive Call**

- **Pass Range**: `0` to `4`.
- **Comparisons and Swaps**:
  - `5` and `3`: Swap → `[3, 5, 8, 4, 6]`.
  - `5` and `8`: No swap.
  - `8` and `4`: Swap → `[3, 5, 4, 8, 6]`.
  - `8` and `6`: Swap → `[3, 5, 4, 6, 8]`.
- **Recursive Call**: `bubbleSort(numbers, 4)`, sorting `[3, 5, 4, 6]`.

#### **Second Recursive Call**

- **Pass Range**: `0` to `3`.
- **Comparisons and Swaps**:
  - `3` and `5`: No swap.
  - `5` and `4`: Swap → `[3, 4, 5, 6, 8]`.
  - `5` and `6`: No swap.
- **Recursive Call**: `bubbleSort(numbers, 3)`, sorting `[3, 4, 5]`.

#### **Third Recursive Call**

- **Pass Range**: `0` to `2`.
- **Comparisons and Swaps**:
  - `3` and `4`: No swap.
  - `4` and `5`: No swap.
- **Termination**: No swaps occurred, so the array is already sorted.

## My Iterative Version**

Analyze my code and discuss its **correctness** and **time complexity** compared to the recursive implementation.

------

### **My original Non-Recursive Implementation**

```cpp
void bubbleSort(int numbers[], int size){
    for(int sizei = size; sizei > 1; sizei = sizei - 1){
        for(int i = 0; i < sizei - 1; i++){
            if(numbers[i] > numbers[i + 1]){
                swap(numbers, i, i + 1);
            }
        }
    }
}
```

------

### **How It Works**

1. **Outer Loop (`sizei`)**:
   - Controls the range of the inner loop.
   - Starts with the full array size (`sizei = size`) and decreases by 1 after each pass (`sizei = sizei - 1`).
   - Ensures that the largest unsorted element is "bubbled" to the correct position in each pass.
2. **Inner Loop (`i`)**:
   - Compares adjacent elements in the current range (`0` to `sizei - 1`).
   - Swaps them if they are out of order.
3. **Termination**:
   - The outer loop stops when `sizei` becomes 1, meaning the entire array is sorted.

------

### **Correctness**

1. It correctly implements the **compare-and-swap** logic.
2. The outer loop ensures that the largest unsorted element is moved to its correct position in each pass.
3. The inner loop gradually reduces the range of comparisons, avoiding redundant checks on the already sorted portion of the array.

------

### **Time Complexity of My Code**

#### **Worst Case**

- The worst-case time complexity of Bubble Sort is **O(n<sup>2</sup>)**
- This occurs when the array is in **reverse order**, and every pair of adjacent elements needs to be swapped.
- In my implementation:
  - The outer loop runs **n−1** times.
  - The inner loop runs **n−1**, **n−2**, ..., 1 times.
  - Total comparisons: **(n−1)+(n−2)+⋯+1** = **<sup>n(n-1)</sup>/<sub>2</sub>**,  which is **O(n<sup>2</sup>)**.

#### **Best Case**

- The best-case time complexity of Bubble Sort is **O(n)**.
- This occurs when the array is **already sorted**, and no swaps are needed.
- In my implementation:
  - The outer loop still runs **n−1**times.
  - The inner loop performs **n−1, n−2, ..., 1** comparisons, but no swaps occur.
  - Total comparisons: **(n−1)+(n−2)+⋯+1** = **<sup>n(n-1)</sup>/<sub>2</sub>**,  which is still **O(n<sup>2</sup>)**.

#### **Optimized Bubble Sort**

- Bubble Sort can be optimized to achieve **O(n)** in the best case by **terminating early** if no swaps occur during a pass.
- My implementation does not include this optimization, so it always performs **O(n<sup>2</sup>)** comparisons, even in the best case.

------

### **Recursive vs. Non-Recursive Implementation**

#### **Recursive Implementation**

- **Time Complexity**:
  - Worst case: **O(n<sup>2</sup>)** .
  - Best case: **O(n)** (if optimized to terminate early when no swaps occur).
- **Space Complexity**:
  - Recursive calls use additional stack space, leading to **O(n)** space complexity in the worst case.

#### **Non-Recursive Implementation **

- **Time Complexity**:
  - Worst case: **O(n<sup>2</sup>)** 
  - Best case: **O(n)**
- **Space Complexity**:
  - Uses constant extra space **O(1)**, as it does not rely on recursion.

------

### **How to Optimize My Non-Recursive Implementation**

Adding a **flag** like my recursive method to check if any swaps occurred during a pass. If no swaps occur, the array is already sorted, and the algorithm can terminate early. 

```cpp
void bubbleSort(int numbers[], int size){
    bool swapped;
    for(int sizei = size; sizei > 1; sizei = sizei - 1){
        swapped = false; // Reset the flag
        for(int i = 0; i < sizei - 1; i++){
            if(numbers[i] > numbers[i + 1]){
                swap(numbers, i, i + 1);
                swapped = true; // Set the flag if a swap occurs
            }
        }
        if(!swapped){
            break; // Terminate early if no swaps occurred
        }
    }
}
```

#### **Optimized Complexity**

- **Best Case**: **O(n)** - (if the array is already sorted).
- **Worst Case**: **O(n<sup>2</sup>)** - (if the array is in reverse order).

------

## **Final Thoughts**

- My non-recursive implementation is **correct** but can be **optimized** to achieve better performance in the best case. ( Because I forgot to add the flag like my recursive way when I try to implement bubble sort by iterative way. ) - **lack of early termination**
- **My Misunderstandings**: Largest has always been sorted to the last elements at each loop, I did not realise that.

