---
title: Operators You Cannot Overload in C++
date: 2025-04-01 00:17:33
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: Cheatsheet and mnemonic for operator overload limitation in C++.

---

There are operators couldn't be overloaded in C++. I read lots of tutorials said same info like that, but I just curious about why they can't be overloaded. The reason under the hood will make more sense for me to remember. 

| Operator                    | Name                             | Why It Can't Be Overloaded                                |
| --------------------------- | -------------------------------- | --------------------------------------------------------- |
| `.`                         | Member access                    | Needs to be resolved at **compile time**                  |
| `::`                        | Scope resolution                 | Affects how code is parsed — **must be compile-time**     |
| `?:`                        | Ternary conditional              | Not a real function call, has control flow behaviour      |
| `sizeof`                    | Size of a type/object            | Must be known **at compile time**, before any code runs   |
| `typeid`                    | Type information                 | Tied to compiler’s internal **type system**               |
| `alignof`, `noexcept`, etc. | Compile-time reflection/meta-ops | Not functions, handled by the **compiler's syntax rules** |

------

## So what do these all have in common?

👉 **They're all resolved entirely by the compiler at compile time**
They are **not function calls**, not runtime logic. The compiler must understand them **before** any of your object’s custom code could even exist.

## Operator Breakdown

------

### 1. `.` — **Member Access Operator**

```cpp
book.title;
```

- If you could overload `.`, then the compiler would have no idea what `book.title` even means until runtime.
- But **compilers must resolve member names early**, so `.` can’t be overloaded.

✅ Alternative you *can* overload: `->` (used in smart pointers)

------

### 2. `::` — **Scope Resolution Operator**

```cpp
std::cout
```

- It tells the compiler “look inside this namespace or class”.
- This is **essential for parsing** — can’t be handed off to your code.

------

### 3. `?:` — **Ternary Conditional Operator**

```cpp
condition ? a : b;
```

- This is **not a binary or unary operator** — it’s a special control structure.
- It chooses between **two expressions**, and its structure is too rigid for overloading.

------

### 4. `sizeof` — **Sizeof Operator**

```cpp
sizeof(Book)
```

- It calculates how much memory something takes.
- That value is needed **before the program runs** — it’s part of how memory layout is compiled.

------

### 5. `typeid` — **Type Info Operator**

```cpp
typeid(obj).name()
```

- Used in **Runtime Type Information (RTTI)**.
- Its result is tied to the compiler’s internal understanding of types — not something your class should modify.

------

## How to Remember Them (Intuitively)

> ❗ If an operator **must be evaluated at compile time**, and cannot behave differently per object — then it cannot be overloaded.

A useful memory aid:

🔒 "**Dotty Size-Typed Scope Question**"
That is:

```cpp
.       // dot
sizeof  // size
typeid  // typed
::      // scope
?:      // question (ternary)
```

Easy to recite. These are "frozen" operators — handled by the **compiler itself**, not by our objects.

## Operators We Can Overload (Most of Them)

These are **runtime** operators that make sense to give custom behaviour:

- Arithmetic: `+ - * / %`
- Comparison: `== != < > <= >=`
- Logical: `&& || !`
- Bitwise: `& | ^ ~ << >>`
- Assignment: `= += -= *= /=`
- Indexing: `[]`
- Function call: `()`
- Pointer access: `->`
- Increment/Decrement: `++ --`
