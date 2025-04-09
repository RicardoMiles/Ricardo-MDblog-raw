---
title: 'Reflection on Duplicate Symbols: A C++ Include Mishap'
date: 2025-04-09 16:28:41
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "Learning #include rules for linking files from Compilation Error: NEVER #include a `.cpp` file"
---

I was coding away on a simple C++ project—a `TextBox` class with getter and setter function, nothing fancy. I compile it, expecting a clean run, and the terminal spits out a cryptic error:

```bash
duplicate symbol 'TextBox::setValue(...)' in:
    /private/var/folders/.../main-c63a49.o
    /private/var/folders/.../TextBox-4357e3.o
duplicate symbol 'TextBox::getValue()' in:
    /private/var/folders/.../main-c63a49.o
    /private/var/folders/.../TextBox-4357e3.o
ld: 2 duplicate symbols
clang++: error: linker command failed with exit code 1
```

Duplicate symbols? Linker errors? What did I do wrong? If this sounds familiar, buckle up—I’m about to share the debugging experience that taught me a golden rule of C++: **never `#include` a `.cpp` file**.

## The Problem: A Rookie Mistake

My project was straightforward. I had three files:
- `TextBox.h`: The header declaring my `TextBox` class.
- `TextBox.cpp`: The implementation of the class methods.
- `main.cpp`: A simple test program to create a `TextBox` object and call its methods.

In `main.cpp`, I wrote:

```cpp
#include "TextBox.cpp"

int main() {
    TextBox textbox;
    textbox.setValue("");
    return 0;
}
```

```cpp
#include "TextBox.cpp"

int main() {
    TextBox textbox;
    try {
        textbox.setValue(""); // This throws an exception, but that’s another story
    } catch (const std::invalid_argument& e) {
        std::cout << "Error: " << e.what() << std::endl;
    }
    return 0;
}
```

 `TextBox.h` looks like 

```cpp
#ifndef TEXTBOX_H
#define ATEXTBOX_H

#include <string>
#include <iostream>

class TextBox {
public:
    std::string getValue();
    void setValue(std::string value);
private:
    std::string value;
};

#endif
```

And `TextBox.cpp` held the implementation:

```cpp
#include "TextBox.h"
#include <iostream>
#include <string>

using namespace std;

string TextBox::getValue() {
    return this->value;
}

void TextBox::setValue(string value) {
    if (value == "") {
        throw invalid_argument("Empty value for textbox!");
    }
    this->value = value;
}
```

## The First Fix Try with Include Guard

Firstly, I thought it may be due to the manually inputted include guard didn't like CLION-style. So I do the following try:

My `main.cpp`  and `TextBox.cpp` stayed the same.

I changed  `TextBox.h` 's include guard':

```cpp
#ifndef ADVANCED_TEXTBOX_H
#define ADVANCED_TEXTBOX_H

#include <string>
#include <iostream>

class TextBox {
public:
    std::string getValue();
    void setValue(std::string value);
private:
    std::string value;
};

#endif
```

With this setup, I compiled it again: `g++ TextBox.cpp main.cpp -o myProgram`. Still errors! 

## **Final Try and True Reason**

I fixed the bug by changing hash-include part in `main.cpp` file, I changed  `#include "TextBox.cpp"` into `#include "TextBox.h"`.

In C++, header files (`.h`) are for declarations, and source files (`.cpp`) are for definitions. Our  `#include` the header to tell other files what’s available, then let the linker combine the implementations.

By including `TextBox.cpp` in `main.cpp`, I was telling the compiler to dump the entire implementation—`getValue()` and `setValue()`—into `main.cpp`. Then, the compiler also compiled `TextBox.cpp` separately. This created two object files (`main.o` and `TextBox.o`), both containing the same function definitions. When the linker tried to stitch them together, it found duplicates and threw a tantrum.

## Extra Lessons: Include Guards Rules

I picked up a few bonus lessons along the way:

**Include Guard Matters ??? It doesn't matter**: That `#ifndef TEXTBOX_H` and `#define TEXTBOX_H` in my header? It’s an include guard, ensuring the file isn’t processed multiple times in one compilation. The name doesn’t matter much—as long as it’s unique across the project and matches within the file. I could’ve used `FOO`, but `ADVANCED_TEXTBOX_H` that ties it to my file with a CLION style reducing collision risks.

## Conclusion

 **Always separate declarations (in `.h`) from implementations (in `.cpp`), and never `#include` a `.cpp` file.** It’s a simple rule, but violating it sent me down a rabbit hole of duplicate symbols and linker woes.

