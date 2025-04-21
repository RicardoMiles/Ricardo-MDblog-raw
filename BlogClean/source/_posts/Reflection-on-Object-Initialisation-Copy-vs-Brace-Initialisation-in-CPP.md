---
title: 'Reflection on Object Initialisation: Copy vs. Brace Initialisation in C++'
date: 2025-04-11 09:54:22
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "I noticed that Mosh's practice of object initialisation is little bit different from my practice (a JAVA style practice)."
---

The two syntaxes I’ve noticed appear to relate to object instantiation in programming, the difference between two ways of creating an object with a constructor in  C++ driven my curiosity.

Given that two different syntax of Mosh's practice and the one I followed before.

Mosh's Practice

```c++
ClassName objectName{DataType constructorParameter};
```

The one I followed before

```cpp
ClassName objectName = ClassName(DataType constructorParameter);
```

These are two different syntaxes for creating an object and invoking a constructor. It is the log that I explored the differences.

## Copy Initialisation

### 1. `ClassName objectName = ClassName(DataType constructorParameter);`

This syntax involves **copy initialisation** (or **direct initialisation** with an explicit constructor call) in C++. Here’s what happens:

- **Explicit constructor call**: `ClassName(DataType constructorParameter)` creates a temporary object of `ClassName` by invoking the constructor that takes a parameter of type `DataType`.
- **Assignment or copy**: The temporary object is then used to initialise `objectName`. In older C++ standards (pre-C++11), this could involve the copy constructor to copy the temporary object into `objectName`. However, modern compilers (C++11 and later) often optimise this via **copy elision** (e.g., Return Value Optimisation **RVO**), meaning no actual copy is made, and the temporary is constructed directly into `objectName`.
- **Behavior**: This is equivalent to writing `ClassName objectName = someValue;`, where the right-hand side is a temporary object. It’s a valid way to initialise an object but can look verbose.

**Example in C++**:

```cpp
#include <iostream>
#include <string>

class ClassName {
public:
    ClassName(std::string param) {
        std::cout << "Constructor called with: " << param << std::endl;
    }
};

int main() {
    ClassName objectName = ClassName("Hello"); // Copy initialisation
    return 0;
}
```

- **Output**: `Constructor called with: Hello`
- The constructor is called once, and `objectName` is initialised. Modern compilers avoid unnecessary copies.

**Key Points**:
- This syntax explicitly creates a temporary object and assigns it to `objectName`.
- It may invoke the copy constructor (though optimised away in most cases).
- It’s less common in modern C++ because there are cleaner alternatives (like the next syntax).
- In languages like Java or C#, this syntax isn’t used exactly this way. For example, Java uses `ClassName objectName = new ClassName(param);`, which is similar but involves the `new` keyword.

## List Initialisation & Brace Initialisation

### `ClassName objectName{DataType constructorParameter};`

This syntax uses **list initialisation** (or **brace initialisation**) in C++, introduced in C++11. It’s often referred to as **uniform initialisation** because **it provides a consistent way to initialise objects, arrays, and other types.**

- **Direct constructor call**: The constructor of `ClassName` that matches the parameter `DataType` is called directly to initialise `objectName`. The braces `{}` indicate that the arguments inside are used to initialise the object.
- **No temporary**: Unlike the first syntax pattern I followd before, this doesn’t create a temporary object that’s then copied. It directly constructs `objectName` with the provided parameter.
- **Narrowing conversion prevention**: List initialisation is stricter about type safety. It prevents implicit narrowing conversions (e.g., passing a `double` to an `int` constructor without explicit casting will lead to narrowing conversion, **which means risk of data loss or implicit cast out of expectation**).
- **Modern preference**: This is the preferred way to initialise objects in modern C++ (C++11 and later) because it’s concise, clear, and avoids unnecessary copies or ambiguities.

**Example in C++**:

```cpp
#include <iostream>
#include <string>

class ClassName {
public:
    ClassName(std::string param) {
        std::cout << "Constructor called with: " << param << std::endl;
    }
};

int main() {
    ClassName objectName{"Hello"}; // List initialisation
    return 0;
}
```

- **Output**: `Constructor called with: Hello`
- The constructor is called directly to initialise `objectName`.

**Key Points**:
- This syntax directly initialises `objectName` without creating a temporary object.
- It’s more concise and modern, aligning with C++’s uniform initialisation goals.
- It prevents narrowing conversions, making it safer.

## Key Differences List

| **Syntax Type**      | Copy initialisation (or direct with copy elision)            | List/brace initialisation                      |
| -------------------- | ------------------------------------------------------------ | ---------------------------------------------- |
| **Temporary Object** | Creates a temporary object (often optimised away)            | No temporary; direct initialisation            |
| **Performance**      | May involve copy constructor (pre-C++11 or without optimisation) | More efficient; no copy implied                |
| **Type Safety**      | Allows implicit conversions                                  | Prevents narrowing conversions                 |
| **Modernity**        | Older style, less preferred in modern C++                    | Modern C++ (C++11+), preferred                 |
| **Readability**      | Verbose, explicit temporary object creation                  | Concise, clear intent                          |
| **Use Case**         | Common in legacy code or when explicit copy is needed        | Standard for new code, versatile for all types |

### Additional Notes

- If the constructor is marked `explicit`, both syntaxes still work, but brace initialisation is stricter about matching types.
- Brace initialisation can also initialise aggregates (e.g., structs) or call default constructors (`ClassName objectName{};`).

- **Ambiguity (Most Vexing Parse)**:
  - In the first syntax, something like `ClassName objectName(ClassName());` could be misinterpreted as a function declaration (the “most vexing parse” issue in C++). Brace initialisation avoids this problem entirely (e.g., `ClassName objectName{};` is always an object, single line with `ClassName objectName();` could be misinterpreted  as a function declaration ).

  

## Conclusion of Reflection

`ClassName objectName{constructorParameter};`  is better practice for:

- Clarity and conciseness.
- Type safety (no narrowing conversions).
- Modern standards compliance (C++11 and later).
- Avoiding unnecessary copies or ambiguities.
