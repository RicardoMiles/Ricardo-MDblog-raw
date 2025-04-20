---
title: Reflection on C++ Templates Declaration Everywhere
date: 2025-04-19 19:34:28
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "Fixing Compilation Errors in `.cpp` File and thinking Why I Needs Extra Template Declarations before Every Functions"
---

## My Specific Problem

I defined a template class and template functions in `MyVector.h` and then implemented them in `MyVector.cpp`. I only wrote `template<typename T>` once, before the class definition in `MyVector.h` and again before the first function implementation in `MyVector.cpp`. This caused compilation to fail.

Later, I added `template<typename T>` before **each** function implementation in the implementation file, and included `#include "MyVector.cpp"` — then the code compiled successfully. Details as follows:

- The code organisation was problematic, which forced me to write `template<typename T>` before every function implementation.
  - For scattered functions, if they use generic types like templates, we must declare `template<typename T>` before each function.
  - If we're working with a templated class, the `template<typename T>` declaration is placed before the class definition, and member functions may not need additional template declarations **depending** on whether they are defined inside or outside the class. Since in my case they are implemented in a `.cpp` file, i.e., **outside** the class, I need to add `template<typename T>` before every function.
- Including different content caused the compilation to fail.
  - Directly using `#include "MyVector.cpp"` and compiling with `g++ main.cpp MyVector.cpp -o myProgram` works fine.
  - But including only `#include "MyVector.h"` and compiling with `g++ main.cpp MyVector.cpp -o myProgram` results in a linker error (`Undefined symbols for architecture arm64`).

## Why `#include "MyVector.cpp"` Is Generally Discouraged

In C++, `.cpp` files are normally **source files**, containing implementation code, which are compiled and linked with other object files to create the executable. `.h` files, on the other hand, are **header files** that declare interfaces (classes, functions, etc.) for use across multiple source files.

1. **Multiple Definition Errors**:
   - `#include "MyVector.cpp"` is equivalent to copying the entire content of `MyVector.cpp` into `main.cpp`.
   - When I compile with `g++ main.cpp MyVector.cpp -o myProgram`, `MyVector.cpp` is compiled twice:
     - Once because it is included in `main.cpp` via `#include`.
     - Again because it is explicitly passed in the compilation command.
   - This can cause template function implementations to be defined multiple times. The linker may then report errors (e.g., "multiple definition of..."), especially when templates are instantiated. This is similar to an error I encountered in another blog post [C++ Include Reflection](https://ricardopotter.github.io/RicardoBlog/2025/04/09/Reflection-on-Duplicate-Symbols-A-C-Include-Mishap/) — the compiler just didn't throw an error this time because of template class.
2. **Violation of the Separation of Compilation Principle**:
   - The standard C++ practice is to place declarations in `.h` files and implementations in `.cpp` files (for non-template code), and use `#include` to share interfaces.
   - Including `MyVector.cpp` directly bypasses the header file, breaks encapsulation and maintainability. Other developers may get confused because `.cpp` files are not expected to be directly included.
3. **Lack of Header Guards**:
   - Header files typically use `#ifndef`/`#define`/`#endif` (or `#pragma once`) to prevent multiple inclusion.
   - `.cpp` files usually don't have such guards. If `MyVector.cpp` is included more than once (directly or indirectly), it may result in multiple definitions or compilation errors.

## Why the Usual Include Rules Fail Here

In my code, `MyVector` is a template class, and templates require special handling at compile time.

- **Template class implementations must be visible at the point of use**:
  - C++ templates are instantiated at compile time. When `main.cpp` uses `MyVector<int>`, the compiler needs to see the full implementation of `MyVector<int>` (including constructor, member functions, etc.) to generate the actual code.
  - In my case, `main.cpp` only sees the declaration (interface) of the template class via `#include "MyVector.h"`. But the implementation (definition) in `MyVector.cpp` is not visible during compilation of `main.cpp`.
  - When `MyVector.cpp` is compiled, the compiler doesn't generate code for `MyVector<int>` because there is no explicit instantiation for that type.
  - Therefore, during linking, the linker cannot find the definitions of `MyVector<int>`'s member functions (like `at`, `push_back`, etc.), resulting in `Undefined symbols` errors.
- **Why does `#include "MyVector.cpp"` seem to work?**
  - When I include `MyVector.cpp` in `main.cpp`, the content of `MyVector.cpp` (including the template class implementation) is inserted directly into `main.cpp`. This allows the compiler to see the full implementation of `MyVector<int>` during compilation and generate correct code.
  - In addition, the compile command `g++ main.cpp MyVector.cpp -o myProgram` compiles `MyVector.cpp` again, but since template class definitions usually don’t generate duplicated symbols (they're instantiated on-demand), the linker doesn’t complain. This is just a lucky coincidence, not a best practice.
  - Moreover, including `.cpp` files like `#include "MyVector.cpp"` is considered bad practice. It breaks modularity and may cause issues in larger projects.

## Solutions to My Problem

### 1. Put Template Declarations and Implementations in the Header File (Recommended)

Since `MyVector` is a template class, the simplest and most recommended approach is to put both the declaration and the implementation in the `MyVector.h` file. This avoids the complexity of separated compilation and ensures that the compiler always sees the full implementation when instantiating the template.

**MyVector.h**:

```cpp
#ifndef ADVANCED_MYVECTOR_H
#define ADVANCED_MYVECTOR_H

template<typename T>
class MyVector {
public:
    void someFunction(T value) {
        // implementation
    }
    // other member functions
private:
    // ...
};

#endif
```

**main.cpp**:

```cpp
#include "MyVector.h"

int main() {
    MyVector<int> vec;
    vec.someFunction(42);
    return 0;
}
```

**Compile Command**:

```bash
g++ main.cpp -o myProgram
```

This approach:

- Avoids the problem of `#include "MyVector.cpp"`.
- Ensures template implementation is visible to the compiler.
- Follows common best practices for C++ templates.

### 2. If I Have to Insist on Separating `.h` and `.cpp`

If we really want to put the template implementation in `MyVector.cpp`, make sure to:

- Add `template<typename T>` before each member function definition.
- Ensure the implementation is visible to the compiler during template instantiation.

**MyVector.h**:

```cpp
#ifndef MYVECTOR_H
#define MYVECTOR_H

template<typename T>
class MyVector {
public:
    void someFunction(T value);
};

#endif
```

**MyVector.cpp**:

```cpp
#include "MyVector.h"

template<typename T>
void MyVector<T>::someFunction(T value) {
    // implementation
}
```

**main.cpp**:

```cpp
#include "MyVector.h"

int main() {
    MyVector<int> vec;
    vec.someFunction(42);
    return 0;
}
```

**Still Fails With This Compile Command**:

```bash
g++ main.cpp MyVector.cpp -o myProgram
```

But this still leads to linker errors, because when compiling `main.cpp`, the compiler only sees the declaration in `MyVector.h`, and not the implementation in `MyVector.cpp`. To solve this, there are two possible approaches:

- Add Explicit Instantiation in `MyVector.cpp`

  ```cpp
  #include "MyVector.h"
  
  template<typename T>
  void MyVector<T>::someFunction(T value) {
      // implementation
  }
  
  template class MyVector<int>; // Explicit instantiation
  // The drawback is that the template will only work for explicitly instantiated types (e.g., `int`), losing the generic flexibility of templates.
  ```

- Use `#include "MyVector.cpp"` to make the compiler aware of the template function implementations

  This is what I did to make it compile, but it is **not recommended**, because the compile command also includes `MyVector.cpp`, which causes it to be compiled twice. This only hides the real problem.

  ```bash
  g++ main.cpp MyVector.cpp -o myProgram
  ```

## Conclusion

* When  we're working with a templated class, make sure to put both declaration and implementation in `ClassName.h` files
* Still stick to the rule that include `.h` but compile the `.cpp` as a general rule
