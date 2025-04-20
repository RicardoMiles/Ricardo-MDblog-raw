---
title: Lessons Learned from My Implementation of C++ Vector
date: 2025-04-20 14:59:43
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "Debugging Log from My Implementation of C++ Vector by Using Array."


---

Debugging Log of C++ Vector implementation using Array.

## Original Code

**MyVector.h**

```cpp
#ifndef ADVANCED_MYVECTOR_H
#define ADVANCED_MYVECTOR_H

#include <cstddef>
using namespace std;

template<typename T>
// Right now T could be any type variable
class MyVector{
public:
   MyVector();
   MyVector(size_t size);
   MyVector(size_t size, T initialValue);
   void push_back(T element);
   void pop_back();
   void insert(size_t index,T element);
   T& at(int index);
   size_t size();
   size_t capacity(); 
   void erase(size_t index);
   void clear();
   bool empty() const;
   bool isFull() const;
   void resizeArray();
private:
    T* arrayHead;
    size_t arraySize = 0;
    size_t arrayCapacity = 0;
};

#endif
```

**MyVector.cpp**

```cpp
#include "MyVector.h"
#include <stdexcept>

template<typename T>

MyVector::MyVector(){
    this->arrayHead = new T[5];
    this->arrayCapacity = 5;
    this->arraySize = 0;
}

MyVector::MyVector(size_t size){
    this->arrayHead = new T[size];
    this->arraySize = 0;
    this->arrayCapacity = size;
}

MyVector::MyVector(size_t size, T initialValue){
    this->arrayHead = new T[size];
    this->arraySize = size;
    this->arrayCapacity = size;
    for(size_t i = 0; i < arraySize ; i++){
        arrayHead[i] = initialValue;
    }
}

void MyVector::push_back(T element){
    if(this->isFull()){
        this->resizeArray();
    }
    this->arrayHead[this->arraySize] = element;
    this->arraySize ++;
}

void MyVector::pop_back(){
    this->arraySize --;
}

void MyVector::insert(size_t index,T element){
    if(index >= arraySize){
        throw invalid_argument("Outbound insertion! ");
    }
    if(this->isFull()){
        this->resizeArray();
    }
    if(index == this->arraySize){
        this->arrayHead[index] = element;
        this->arraySize++; 
    }else{
        T* tempHead = new T[this->arrayCapacity];
        for(size_t i = 0; i < index; i++){
            tempHead[i] = (this->arrayHead)[i];
        }
        tempHead[index] = element;
        for(size_t i= index + 1; i< (this->arraySize+1); i++){
            tempHead[i] = (this->arrayHead)[i];
        }
        delete this->arrayHead;
        this->arrayHead = tempHead;
        this->arraySize++;
    }
}

T& MyVector::at(int index){
    if(index >= (this->arraySize)){
        throw invalid_argument("Outbound Vector");
    }
    return this->arrayHead[index];
}

size_t MyVector::size(){
    return this->arraySize;
}

size_t MyVector::capacity(){
    return this->arrayCapacity;
}

void MyVector::clear(){
    delete this->arrayHead;
    this->arrayHead = nullptr;
    this->arraySize = 0;
    this->arrayCapacity = 0;
}

bool MyVector::empty() const{
    if((this->arraySize) == 0){
        return true;
    }else{
        return false;
    }
}

bool MyVector::isFull() const{
    if(this->arraySize == this->arrayCapacity){
        return true;
    }else{
        return false;
    }
}

void MyVector::resizeArray(){
    T* tempHead = new T[2*(this->arrayCapacity)];
    for(size_t i =0;i < this->arrayCapacity;i++){
        tempHead[i] = (this->arrayHead)[i];
    }
    delete this->arrayHead;
    this->arrayHead = tempHead;
    this->arraySize = arrayCapacity;
    this->arrayCapacity = 2*(this->arrayCapacity);
}

void MyVector::erase(size_t index){
    if(index >= this->arraySize){
        throw invalid_argument("Outbound vector");
    }
    if(index == ((this->arraySize)-1)){
        this->arraySize = this->arraySize -1;
    }else{
        T* tempHead = new T[this->arrayCapacity];
        for(size_t i = 0; i < index; i++){
            tempHead[i] = (this->arrayHead)[i];
        }
        for(size_t i= index; i< (this->arraySize-1); i++){
            tempHead[i] = (this->arrayHead)[i+1];
        }
        delete this->arrayHead;
        this->arrayHead = tempHead;
        this->arraySize = this->arraySize -1;
    }
}
```

## **Template Class Member Functions Must Be Defined as Templates**

### **Error:**

I defined a **template class**, but the **member function definitions** outside the class (in the `.cpp` file) are missing the `template<typename T>` prefix and the `MyVector<T>::` scope qualifier.

### **Lesson:**

- For every member function of a template class, I must prefix the definition with:

  ```cpp
  template<typename T>
  MyVector<T>::functionName() {
      // ...
  }
  ```

- This applies to **all** member functions.

### **Correct Way:**

```cpp
template<typename T>
MyVector<T>::MyVector() {
    // ...
}
```

------

## **Incorrect Use of `delete` for Arrays**

### **Error:**

I wrote:

```cpp
delete this->arrayHead;
```

But this is used for deleting a **single object**, not an array.

### **Lesson:**

- When deleting a dynamically allocated array, I **must use `delete[]`**, not `delete`.

### **Correct Way:**

```cpp
delete[] this->arrayHead;
```

------

## **`resizeArray` Should Not Modify `arraySize`**

### **Error:**

```cpp
this->arraySize = arrayCapacity;
```

This changes the logical size of the array during a resize, which is incorrect.

### **Lesson:**

- `resizeArray` only increases **capacity**, not the actual number of stored elements (`arraySize`).
- **Never modify `arraySize` in a resize function.**

------

## **Logic Error in `insert` Function**

### **Error:**

```cpp
if (index == this->arraySize)
```

This block never runs, because earlier I have:

```cpp
if (index >= arraySize)
```

which already excludes the `==` case.

### **Lesson:**

- I must **restructure the conditional logic** to properly handle inserting at the end.

------

## **`pop_back` Does Not Check for Empty Array**

### **Error:**

In `pop_back`, I decrease `arraySize` unconditionally.

### **Lesson:**

- If `arraySize` is already 0, decrementing it will wrap around (since it's unsigned), causing **undefined behaviour**.

### **Fix:**

Add a safety check:

```cpp
if (this->arraySize > 0) {
    this->arraySize--;
}
```

------

## **`at` Function Should Also Check for Negative Indexes**

### **Error:**

my `at` function checks:

```cpp
if (index >= arraySize)
```

But doesn't handle **negative indices** (`index < 0`), which can happen if `index` is an `int`.

### **Lesson:**

- While standard `std::vector::at()` doesn’t always check negatives (depends on overload), for safety, I should.

### **Suggested Check:**

```cpp
if (index < 0 || index >= arraySize) {
    throw invalid_argument("Invalid Index");
}
```

------

## **Use `size_t` Type Parameter in `at` Function**

### **Error:**

my `at` function checks:

```cpp
T& MyVector<T>::at(index index){
    if(index >= (this->arraySize)){
        throw invalid_argument("Outbound Vector");
    }
    return this->arrayHead[index];
}
```

But it may not work when comparing int type `index`  with an size_t type `arraySize`.

### **Lesson:**

- Always use `size_t` when it refers to a large number in C++

### **Fix**

```cpp
template<typename T>
T& MyVector<T>::at(size_t index){
    if(index >= (this->arraySize)){
        throw invalid_argument("Outbound Vector");
    }
    if(index < 0){
        throw invalid_argument("Invalid Index");
    }
    return this->arrayHead[index];
}
```

---

## **Avoid `using namespace std;` in Header Files**

### **Error:**

In `MyVector.h`, I have:

```cpp
using namespace std;
```

### **Lesson:**

- This is **bad practice** in headers—it imports `std` into **all files** that include my header.
- This **pollutes the global namespace** and may cause **name conflicts**.

### **Fix:**

- **Remove `using namespace std;`** from headers.
- Use `std::` explicitly (e.g., `std::size_t`, `std::string`).

------

```cpp
// Copy Constructor
template<typename T>
MyVector<T>::MyVector(const MyVector<T>& other) {
    this->arraySize = other.arraySize;
    this->arrayCapacity = other.arrayCapacity;
    this->arrayHead = new T[this->arrayCapacity];
    for (size_t i = 0; i < this->arraySize; ++i) {
        this->arrayHead[i] = other.arrayHead[i];
    }
}

// Assignment Operator
template<typename T>
MyVector<T>& MyVector<T>::operator=(const MyVector<T>& other) {
    if (this == &other) return *this;

    delete[] this->arrayHead;

    this->arraySize = other.arraySize;
    this->arrayCapacity = other.arrayCapacity;
    this->arrayHead = new T[this->arrayCapacity];
    for (size_t i = 0; i < this->arraySize; ++i) {
        this->arrayHead[i] = other.arrayHead[i];
    }

    return *this;
}
```

------

## **Robust Resize Logic: Avoid Zero-Capacity Allocations**

### **Problem:**

If `arrayCapacity` is zero when `resizeArray()` is called (e.g., after `clear()`), I will attempt to allocate a zero-length array.

### **Fix:**

Add a condition:

```cpp
if (this->arrayCapacity == 0) {
    this->arrayCapacity = 1;
}
```

Then proceed to double it normally.

---

## **Avoid Magic Number in Default Constructor**

### **Problem:**

```cpp
MyVector<T>::MyVector(){
    this->arrayHead = new T[5];
    this->arrayCapacity = 5;
    this->arraySize = 0;
}
```

* 5 is a magic number in my code
* I will use 5 twice because in resize function, if it is an empty vector after clear operation

### **Fix：**

* Use hash define to avoid magic number

```cpp
#define VEC_MIN_SIZE 5
```

---

## **Missing Copy Constructor and Assignment Operator**

### **Problem:**

my class manages **dynamic memory (`arrayHead`)**, so it needs:

- A **copy constructor**
- A **copy assignment operator**

### **Lesson:**

- Without them, the compiler generates **shallow copies**, which leads to **double deletions** or **dangling pointers**.

### **Fix:**

Implement the Rule of Three:

```cpp
// Copy Constructor
template<typename T>
MyVector<T>::MyVector(const MyVector<T>& other) {
    this->arraySize = other.arraySize;
    this->arrayCapacity = other.arrayCapacity;
    this->arrayHead = new T[this->arrayCapacity];
    for (size_t i = 0; i < this->arraySize; ++i) {
        this->arrayHead[i] = other.arrayHead[i];
    }
}

// Assignment Operator
template<typename T>
MyVector<T>& MyVector<T>::operator=(const MyVector<T>& other) {
    if (this == &other) return *this;

    delete[] this->arrayHead;

    this->arraySize = other.arraySize;
    this->arrayCapacity = other.arrayCapacity;
    this->arrayHead = new T[this->arrayCapacity];
    for (size_t i = 0; i < this->arraySize; ++i) {
        this->arrayHead[i] = other.arrayHead[i];
    }

    return *this;
}
```

## Final Corrected Code

**MyVector.cpp**

```cpp
#include "MyVector.h"
#include <cstddef>
#include <stdexcept>

#define VEC_MIN_CAP 5

template<typename T>
MyVector<T>::MyVector(){
    this->arrayHead = new T[VEC_MIN_CAP];
    this->arrayCapacity = VEC_MIN_CAP;
    this->arraySize = 0;
}

template<typename T>
MyVector<T>::MyVector(size_t size){
    this->arrayHead = new T[size];
    this->arraySize = 0;
    this->arrayCapacity = size;
}

template<typename T>
MyVector<T>::MyVector(size_t size, T initialValue){
    this->arrayHead = new T[size];
    this->arraySize = size;
    this->arrayCapacity = size;
    for(size_t i = 0; i < arraySize ; i++){
        arrayHead[i] = initialValue;
    }
}

// Copy Constructor
template<typename T>
MyVector<T>::MyVector(const MyVector<T>& other) {
    this->arraySize = other.arraySize;
    this->arrayCapacity = other.arrayCapacity;
    this->arrayHead = new T[this->arrayCapacity];
    for (size_t i = 0; i < this->arraySize; ++i) {
        this->arrayHead[i] = other.arrayHead[i];
    }
}

template<typename T>
void MyVector<T>::push_back(T element){
    if(this->isFull()){
        this->resizeArray();
    }
    this->arrayHead[this->arraySize] = element;
    this->arraySize ++;
}

template<typename T>
void MyVector<T>::pop_back(){
    if (this->arraySize > 0) {
        this->arraySize--;
    }else{
        throw invalid_argument("Empty Vector! Nothing available to pop back");
    }
}

template<typename T>
void MyVector<T>::insert(size_t index,T element){
    if(index > arraySize){
        throw invalid_argument("Outbound insertion! ");
    }
    if(this->isFull()){
        this->resizeArray();
    }
    if(index == this->arraySize){
        this->arrayHead[index] = element;
        this->arraySize++; 
    }else{
        T* tempHead = new T[this->arrayCapacity];
        for(size_t i = 0; i < index; i++){
            tempHead[i] = (this->arrayHead)[i];
        }
        tempHead[index] = element;
        for(size_t i= index + 1; i< (this->arraySize+1); i++){
            tempHead[i] = (this->arrayHead)[i];
        }
        delete[] this->arrayHead;
        this->arrayHead = tempHead;
        this->arraySize++;
    }
}

template<typename T>
T& MyVector<T>::at(size_t index){
    if(index >= (this->arraySize)){
        throw invalid_argument("Outbound Vector");
    }
    if(index < 0){
        throw invalid_argument("Invalid Index");
    }
    return this->arrayHead[index];
}

template<typename T>
size_t MyVector<T>::size(){
    return this->arraySize;
}

template<typename T>
size_t MyVector<T>::capacity(){
    return this->arrayCapacity;
}

template<typename T>
void MyVector<T>::clear(){
    delete[] this->arrayHead;
    this->arrayHead = nullptr;
    this->arraySize = 0;
    this->arrayCapacity = 0;
}

template<typename T>
bool MyVector<T>::empty() const{
    if((this->arraySize) == 0){
        return true;
    }else{
        return false;
    }
}

template<typename T>
bool MyVector<T>::isFull() const{
    if(this->arraySize == this->arrayCapacity){
        return true;
    }else{
        return false;
    }
}

template<typename T>
void MyVector<T>::resizeArray(){
    if(this->arrayCapacity == 0){
        this->arrayHead = new T[VEC_MIN_CAP];
        this->arrayCapacity = VEC_MIN_CAP;
        this->arraySize = 0;
    }
    T* tempHead = new T[2*(this->arrayCapacity)];
    for(size_t i =0;i < this->arraySize;i++){
        tempHead[i] = (this->arrayHead)[i];
    }
    delete[] this->arrayHead;
    this->arrayHead = tempHead;
    this->arrayCapacity = 2*(this->arrayCapacity);
}

template<typename T>
void MyVector<T>::erase(size_t index){
    if(index >= this->arraySize){
        throw invalid_argument("Outbound vector");
    }
    if(index == ((this->arraySize)-1)){
        this->arraySize = this->arraySize -1;
    }else{
        T* tempHead = new T[this->arrayCapacity];
        for(size_t i = 0; i < index; i++){
            tempHead[i] = (this->arrayHead)[i];
        }
        for(size_t i= index; i< (this->arraySize-1); i++){
            tempHead[i] = (this->arrayHead)[i+1];
        }
        delete[] this->arrayHead;
        this->arrayHead = tempHead;
        this->arraySize = this->arraySize -1;
    }
}
```

## Key Takeaways for Future Code:

| **Mistake**                                                  | **Lesson**                                                   |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Template functions defined without `template<typename T>` and `MyVector<T>::` | Always define template member functions with the proper syntax. |
| Used `delete` for arrays                                     | Use `delete[]` to deallocate dynamic arrays safely.          |
| `resizeArray()` modified `arraySize`                         | Only update capacity, not logical size.                      |
| `insert()` logic blocked end-insertion                       | Adjust condition order to handle insertion at the end correctly. |
| `pop_back()` lacked empty check                              | Add a guard: don’t decrement `arraySize` if it's already 0.  |
| `at()` didn't check for negative index                       | Validate both `index < 0` and `index >= arraySize` to prevent UB. |
| `at()` used `int` index                                      | Use `size_t` for consistency and type safety with container sizes. |
| Used `using namespace std;` in header                        | Avoid this—use `std::` explicitly to prevent namespace pollution. |
| Missing Rule of Three                                        | Implement copy constructor and assignment operator for deep copying. |
| `resizeArray()` risked zero-capacity allocation              | Ensure minimum capacity before doubling; avoid zero-sized allocation. |
| Magic number in constructor (`5`)                            | Use a `#define` or `constexpr` to name constants clearly.    |
| `erase()` and `insert()` did manual shifting with fresh array | Try shifting in-place or reuse memory instead of reallocating every time. |

- **Template Syntax:** Template functions must repeat the `template<typename T>` prefix and use `MyVector<T>::` scope qualifier.
- **Memory Management:** Always pair `new[]` with `delete[]`, and ensure the Rule of Three (or Rule of Five in modern C++) is followed.
- **Safety First:** Always check boundary conditions like size or null pointers before modifying memory.
- **Clarity:** Avoid magic numbers, use descriptive constants, and prefer expressive error messages.
- **Design:** Separate concerns: resizing should never affect logical size. Avoid polluting headers or redoing work unnecessarily.
