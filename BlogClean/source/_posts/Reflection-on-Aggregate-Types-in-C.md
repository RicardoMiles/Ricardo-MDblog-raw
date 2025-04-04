---
title: Reflection on Aggregate Types in C++
date: 2025-04-04 15:55:06
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "Learn Aggregate Types from Compilation Error."

---

In this blog post, I'll share my journey of debugging a C++ program involving aggregate types, including the errors I encountered and how I resolved them.

## The Initial Code

I started with a simple program exercise to define a `Point` struct and overload the equality operator and stream insertion operator. Here's the initial code:

```cpp
/*
Define a structure for representing a point.
- X
- Y
Overload the equality (==) and stream insertion operators («<)
for points.
*/

#include <iostream>

using namespace std;

struct Point {
    int x = 0;
    int y = 0; 
};

bool operator==(const Point& pointOne, const Point& pointTwo) {
    return (pointOne.x == pointTwo.x && pointOne.y == pointTwo.y);
}

ostream& operator<<(ostream& stream, const Point& point) {
    stream << "(" << point.x << "," << point.y << ")";
    return stream;
}

int main() {
    Point one = {6, 8};
    Point two = {6, 8};
    
    if (one == two) {
        cout << "Equal" << endl;
    }

    cout << one;

    return 0;
}
```

## The First Compilation Attempt and Error

I compiled the code using the following command:
```bash
g++ mosh_operator_overload_exercise.cpp -o MoshOperatorOverloadingTry
```

The compiler produced several warnings and errors:

1. **C++11 Extension Warning**:
   
   ```bash
   mosh_operator_overload_exercise.cpp:13:11: warning: default member initializer for non-static data member is a C++11 extension [-Wc++11-extensions]
   ```
   - **Explanation**: The default member initializers (`int x = 0;` and `int y = 0;`) are a C++11 feature. My compiler was using an older standard (C++98/03) by default.
   
3. **Initializer List Error**:
   
   ```bash
   mosh_operator_overload_exercise.cpp:27:11: error: non-aggregate type 'Point' cannot be initialized with an initializer list
   ```
   - **Explanation**: In C++98/03, we cannot use an initializer list to initialize non-aggregate types directly. This feature was introduced in C++11.

## Debugging and Second Try & Error

### Enable C++11 Standard

To use C++11 features, I specified the C++11 standard during compilation:
```bash
g++ -std=c++11 mosh_operator_overload_exercise.cpp -o MoshOperatorOverloadingTry
```

### Face Error with Aggregate Type

```bash
mosh_operator_overload_exercise.cpp:27:11: error: non-aggregate type 'Point' cannot be initialized with an initializer list
   27 |     Point one = {6,8};
      |           ^     ~~~~~
mosh_operator_overload_exercise.cpp:28:11: error: non-aggregate type 'Point' cannot be initialized with an initializer list
   28 |     Point two = {6,8};
      |           ^     ~~~~~
```

## Resolving the Issues with Final Try

I just tried to remove the default value settings in structure definition, then lucked into fixing that bug.

```cpp
#include <iostream>

using namespace std;

struct Point{
    int x;
    int y;
};

bool operator==(const Point& pointOne,const Point& pointTwo){
    return(pointOne.x == pointTwo.x && pointOne.y == pointTwo.y);
}

ostream& operator<<(ostream& stream,const Point& point){
    stream << "(" << point.x << "," << point.y << ")";
    return stream;
}

int main(){
    Point one = {6,8};
    Point two = {6,8};

    if(one == two){
        cout << "Equal" << endl;
    }

    cout << one;

    return 0;
}

```

So I am going to learn what is going on under the hood.

## What Are Aggregate Types?

Aggregate types in C++ are a special category of types that allow for initialization using an **initialiser list**. They are typically used for simple data structures like `struct` and `union`, and they adhere to a set of specific conditions.

## Conditions for Aggregate Types

An aggregate type must meet the following criteria:
1. **Class Type or Array**: It must be a class type (such as `struct` or `union`) or an array.
2. **No User-Defined Constructors**: It cannot have any user-defined constructors.
3. **Public Members**: All non-static members must be public.
4. **No Inheritance**: It cannot have any base classes.
5. **No Virtual Functions**: It cannot have any virtual functions.
6. **No Reference Members**: It cannot have any members that are references.
7. **No Members with User-Defined Default Constructors**: It cannot have any members that are class types with user-defined default constructors.

## **BUG ROOT**

```cpp
struct Point {
    int x = 0;  // C++11 feature
    int y = 0;  // C++11 feature
};
```
- In C++11, default member initialisers (e.g., `int x = 0;`) are allowed, **but they prevent the type from being an aggregate.** Aggregate types in C++11 cannot have default member initialisers. This is why my struct was not considered an aggregate type when I had default member initialisers, leading to the error when trying to use aggregate initialization.

## Examples of Aggregate Types

```cpp
struct Point {
    int x;
    int y;
};
```

- **Explanation**: This is an aggregate type because it meets all the criteria. It has no constructors, all members are public, and it has no inheritance, virtual functions, reference members, or members with user-defined default constructors.

```cpp
struct Point {
    int x;
    int y;
    Point(int x, int y) : x(x), y(y) {}  // User-defined constructor
};
```
- **Explanation**: This is not an aggregate type because it has a user-defined constructor.

```cpp
struct Point {
    private:
        int x;
        int y;
};
```
- **Explanation**: This is not an aggregate type because its members are private.

```cpp
struct Base {
    int x;
};

struct Derived : Base {
    int y;
};
```
- **Explanation**: `Derived` is not an aggregate type because it inherits from `Base`.

```cpp
struct Point {
    int x;
    int y;
    virtual void display() const {
        std::cout << "(" << x << ", " << y << ")" << std::endl;
    }
};
```
- **Explanation**: This is not an aggregate type because it has a virtual function.

```cpp
struct Point {
    int x;
    int& y;  // Reference member
};
```
- **Explanation**: This is not an aggregate type because it has a reference member.

```cpp
struct A {
    A() {}
};

struct B {
    A a;  // A has a user-defined default constructor
    int x;
};
```
- **Explanation**: `B` is not an aggregate type because its member `a` has a user-defined default constructor.

## Initialising Aggregate Types

**Aggregate types can be initialized using an initializer list.** 

```cpp
Point p = {1, 2};  // Legal initialization
```
