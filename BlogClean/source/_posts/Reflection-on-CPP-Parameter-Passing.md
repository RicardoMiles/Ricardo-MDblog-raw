---
title: Reflection on C++ Parameter Passing
date: 2025-04-11 10:40:32
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "Deeper learning and key-point retold driven by Mosh's course code snippet."

---

```cpp
Rectangle::Rectangle(const Rectangle& source){    
    this->width = source.width;    
    this->height = source.height;    
    this->color = source.color;  
} 
```

This is a snippet from Mosh's C++ course, I doubted that: 

* Why we have to use `-> ` to acess `this` (pointer points to current object) 's member, while we can use dot operator `.` to access `source` 's member.
* What is the esstential of passing parameter by reference
* What are the differences between - Passing parameters directly by variable / Passing parameters by referencing / Passing parameters by pointers

Great question! Let’s break this down step-by-step to clarify why `->` is used for `this` while the dot operator (`.`) is used for `source` in this copy constructor.

## **Access Way Question**

This is a **copy constructor** for a `Rectangle` class in C++. It takes a **constant reference** to another `Rectangle` object (`source`) and copies its member variables (`width`, `height`, `color`) into the current object being constructed. The keyword `this` is a pointer to the current object.

Here’s the code again for reference:
```cpp
Rectangle::Rectangle(const Rectangle& source) {
    this->width = source.width;
    this->height = source.height;  
    this->color = source.color;
}
```

### Why `this` Uses `->`?
- **`this` is a pointer**: In C++, `this` is a special keyword that represents a pointer to the current object. Since it’s a pointer (of type `Rectangle*` in this case), we use the arrow operator `->` to access the members of the object it points to.
- **Arrow operator (`->`)**: The `->` operator is used to dereference a pointer and access a member of the object it points to. So, `this->width` means "access the `width` member of the object that `this` points to." We can also use a complicated OG style to do this `(*this).width`, which is equivalent to arrow operator access.
- **Why not `.` with `this`?**: The dot operator (`.`) is used for objects or references, not pointers. If we tried `this.width`, it would be a syntax error because `this` is a pointer (address), not an object itself.

### Why `source` Uses `.`?
- **`source` is a reference**: The parameter `source` is declared as `const Rectangle& source`, meaning it’s a reference to a `Rectangle` object (not a pointer). **In C++, a reference acts like an alias for the object it refers to,** so we can use the dot operator (`.`) to access its members directly.
- **Dot operator (`.`)**: The `.` operator is used to access members of an object or a reference to an object. So, `source.width` means "access the `width` member of the `source` object."
- **Why not `->` with `source`?**: If we tried `source->width`, it would be incorrect because `source` is not a pointer—it’s a reference. The `->` operator is only for pointers.

### Conclusion & Extension
- **`this`**: A pointer (`Rectangle*`), so use `->`.
- **`source`**: A reference (`const Rectangle&`), so use `.`.
- This distinction comes from how C++ handles pointers versus references. Hope that clears it up! Let me know if we have more questions.

## **Refrence's Feature in C++**

In C++, a reference (e.g., Rectangle&) is a way to create an **alias** for an existing object. **It’s not a separate object or a copy**—it’s just another name for the **same object in memory**. When we use a reference, we’re directly manipulating the original object, as if we were using its original name.

When we pass an object by reference (using &), we’re passing an **alias** to the original object, not a copy. The function works directly with the original object.

```cpp
Rectangle::Rectangle(const Rectangle& source) {
    width = source.width;
    height = source.height;
    color = source.color;
}
```

Here, `source` is a reference (`const Rectangle&`). It’s an alias for whatever `Rectangle` object is passed in, so accessing `source.width` is exactly the same as accessing the original object’s width.

- **No copy is created**: The function uses the original object directly via the reference. No duplication happens, so there’s no call to the copy constructor for the parameter itself.
- **Original can be modified**: If the reference isn’t const, changes to the parameter affect the original object.
- **Performance benefit**: Passing by reference is more efficient because it avoids copying the object, especially for large or complex objects.
- **Use case**: Pass by reference when we want to avoid copying (for efficiency) or when the function needs to modify the original object.

In our copy constructor:

- The `const` ensures source can’t be modified inside the constructor.
- It’s still a reference, so no copy of source is made when passing it—just an alias to the original object.

A reference acts as an alias because, at the language level, C++ ensures that any operation on the reference (e.g., reading or writing) is performed directly on the object it refers to. Unlike a pointer, which stores an address and requires dereferencing, a reference is designed to be **transparent**—we use it like the object itself, with the dot operator (`.`), and the compiler handles the rest.

But how does this work under the hood? 

## What Exactly the Implementation of Reference

At a high level, references are a C++ abstraction, but at a low level (in the compiled machine code), they are typically implemented **using pointers** or **direct memory access**. Here’s a detailed look:

### 1. **References Are Not Objects**
- **A reference doesn’t have its own memory storage**. **It’s not a separate entity** like a variable or a pointer. Instead, it’s just a **name** for an existing object’s memory location.
- When we declare `Rectangle& ref = someRect;`, `ref` doesn’t get its own memory—**it’s bound to the memory of  the object** `someRect`.
- This is why we can’t have a “null reference” (unlike a null pointer) or reassign a reference to another object after initialisation. **Once a reference is bound to an object, it’s permanently tied to it.**
- **We can never reassign a reference to another object after initialisation**

### 2. **Compiler’s Role**
- The C++ compiler translates reference operations into direct memory accesses to the referred object. When we write `source.width`, the compiler knows `source` is an alias for a specific `Rectangle` object and generates code to access that object’s `width` member directly.
- In most cases, the compiler optimises references so they don’t add any runtime overhead( Runtime Overhead: Extra computing resources used during execution) compared to using the object directly.

### 3. **References as Pointers Under the Hood**
- In many implementations, references are **internally treated like pointers** by the compiler, but with syntactic sugar to make them easier to use. (**Easier than pointers LOL**)
- For example, when we pass `const Rectangle& source`, the compiler might pass the **memory address** of the `Rectangle` object (like a `const Rectangle*`). However, unlike a pointer, we don’t need to dereference it with `*` or `->`—the compiler automatically translates `source.width` to the equivalent of `(*source).width` or `source->width` in the generated code.
- The key difference is that references are **safer** and **more restricted** than pointers:
  - References can’t be null (they must be initialised to a valid object).
  - References can’t be reassigned to refer to another object.
  - References don’t require explicit dereferencing syntax.

### 4. **Memory Layout**
- Suppose we have a `Rectangle` object like this:
  ```cpp
  Rectangle r1{5, 5, "red"};
  ```
  In memory, `r1` might look like:
  ```bash
  [width: 5 | height: 5 | color: "red"]
  ^ Address: 0x1000 (example)
  ```
- When we pass `r1` as a reference:
  ```cpp
  Rectangle r2(r1); // Calls Rectangle::Rectangle(const Rectangle& source)
  ```
  The `source` reference is just another name for the memory at `0x1000`. Accessing `source.width` goes straight to `0x1000` to read the value `5`. No copy of the object is made—only the address is used internally.

### 5. **No Overhead for Passing**
- Passing a reference is as efficient as passing a pointer because it typically involves passing a memory address (4 or 8 bytes on most systems). This is why `const Rectangle&` is preferred over passing by value (which copies the entire object) in our copy constructor.
- For example:
  - By value: Copies `width`, `height`, `color` (potentially expensive, especially if `color` is a `std::string` with dynamic memory).
  - By reference: Passes a single address, no copying of the object’s data.

### 6. **Const References**
- In our constructor, `const Rectangle& source` adds a guarantee that the referred object won’t be modified. The compiler enforces this by preventing writes to `source`’s members (e.g., `source.width = 10;` would cause a compile-time error).

- Under the hood, the `const` qualifier might translate to a `const Rectangle*` in the generated code, ensuring the memory at that address isn’t altered.

  

Let’s imagine a simplified assembly-like view of our copy constructor with `const Rectangle& source`. Assume `Rectangle` has `width` (int), `height` (int), and `color` (string), and `r1` is at address `0x1000`.

1. **Calling the Constructor**:
   
   ```cpp
   Rectangle r2(r1);
   ```
   - The compiler passes `r1`’s address (`0x1000`) to the constructor, similar to a pointer.
   
2. **Inside the Constructor**:
   - `source` is effectively a name for address `0x1000`.
   - `source.width` translates to “read 4 bytes at `0x1000`” (assuming `width` is at offset 0).
   - `this->width = source.width;` translates to “write that value to the `width` field of the new object” (e.g., at `0x2000` if `r2` is there).

3. **Generated Code (Pseudo-Assembly)**:
   
   ```pseudocode
   ; Pass r1's address (0x1000) to constructor
   mov register, 0x1000
   ; Read source.width (at 0x1000)
   mov eax, [register + 0]
   ; Write to this->width (this at 0x2000)
   mov [this + 0], eax
   ; Repeat for height, color...
   ```
   The actual implementation of it will be slightly different depends on different compiler. 

### Edge Cases and Notes

1. **Reference initialisation**:
   - A reference must be initialised when declared:
     ```cpp
     Rectangle& ref = r1; // OK
     Rectangle& ref;      // Error: uninitialised
     ```
   - This ensures a reference always aliases a valid object.

2. **No Rebinding**:
   - Once bound, a reference can’t alias a different object:
     ```cpp
     Rectangle r1, r2;
     Rectangle& ref = r1;
     ref = r2; // Doesn’t rebind! Assigns r2’s values to r1
     ```

3. **Temporary Objects**:

   * A **temporary object** in C++ is an unnamed object created as a result of an expression, typically with a short lifetime. 

     ```cpp
     Rectangle(1, 1, "blue")  // Creates a temporary Rectangle object
     ```

   - In C++, **non-const lvalue references** (e.g., `Rectangle&`) can only bind to **lvalues**—objects that have a name and persist beyond a single expression. Temporaries, however, are **rvalues**—they’re fleeting, unnamed objects that typically don’t have a persistent identity.
     
     Here’s the key rule:
     
     - A **non-const lvalue reference** (`Rectangle&`) **cannot bind to an rvalue** (like a temporary).
     - A **const lvalue reference** (`const Rectangle&`) **can bind to an rvalue**, and it extends the temporary’s lifetime to match the reference’s scope.
     
   - References can bind to temporaries if declared as `const`:
     
     ```cpp
     void func(const Rectangle& r);
     func(Rectangle(1, 1, "blue")); // OK: temporary Rectangle
     ```

## Passing Parameters by Value v.s. Reference v.s. Pointer

| Aspect                  | Pass by Value             | Pass by Reference               | Pass by Pointer                 |
| ----------------------- | ------------------------- | ------------------------------- | ------------------------------- |
| **Syntax (Parameter)**  | Rectangle obj             | Rectangle& obj                  | Rectangle* obj                  |
| **Syntax (Access)**     | obj.width (dot)           | obj.width (dot)                 | obj->width (arrow)              |
| **Copying**             | Full copy of object       | No copy—just a reference        | No copy—just an address         |
| **Performance**         | Slow for large objects    | Fast (no copying)               | Fast (no copying)               |
| **Memory Usage**        | High (duplicate object)   | Low (reference, ~address)       | Low (pointer, ~address)         |
| **Modification**        | Affects copy only         | Affects original (unless const) | Affects original (unless const) |
| **Pass Syntax**         | someFunction(r)           | someFunction(r)                 | someFunction(&r)                |
| **Nullability**         | Always valid (copy made)  | Always valid (bound to object)  | Can be nullptr (needs check)    |
| **Use in Constructors** | Rarely used (inefficient) | Common (const Rectangle&)       | Possible but less common        |

### 1. Passing by Value (Object Itself)

When we pass an object by value, a complete copy of the object is made and passed to the function.

```cpp
void someFunction(Rectangle obj) {    
    obj.width = 10;  // Modifies the copy, not the original 
} 
Rectangle r(5, 5, "red"); 
someFunction(r); 
// r is unchanged: width = 5, height = 5, color = "red"
```

#### Key Characteristics

- **Copy created**: The entire object is duplicated using the copy constructor.
- **Original unaffected**: Changes inside the function only affect the copy.
- **Performance**: Expensive for large objects due to copying overhead.
- **Syntax**: Uses the dot operator (.) to access members (e.g., obj.width).

------

### 2. Passing by Reference

When we pass by reference, we pass an alias to the original object, not a copy.

```cpp
void someFunction(Rectangle& obj) {    
    obj.width = 10;  // Modifies the original 
} 
Rectangle r(5, 5, "red"); 
someFunction(r); 
// r is changed: width = 10, height = 5, color = "red"
```

With `const`

```cpp
void someFunction(const Rectangle& obj) {    
    obj.width = 10;  // Error: const prevents modification 
}
```

#### Key Characteristics

- **No copy**: The function works directly with the original object via the reference.
- **Original modifiable**: Unless const is used, changes affect the original.
- **Performance**: Efficient—no copying overhead.
- **Syntax**: Uses the dot operator (`.`) because a reference acts like the object itself (e.g., `obj.width`).

------

### 3. Passing by Pointer

When we pass by pointer, we pass the memory address of the object. The function works with that address and must dereference it to access the object.

```cpp
void someFunction(Rectangle* obj) {    
    obj->width = 10;  // Modifies the original via the pointer 
} 
Rectangle r(5, 5, "red"); 
someFunction(&r);  
// Pass the address of r 
// r is changed: 
// width = 10, height = 5, color = "red"
```

with `const`

```cpp
void someFunction(const Rectangle* obj) {    
    obj->width = 10;  // Error: const prevents modification }
```

#### Key Characteristics

- **No copy**: Only the address (a small value, typically 4 or 8 bytes) is passed, not the object itself.
- **Original modifiable**: The pointer allows modification of the original object unless const is used.
- **Performance**: Efficient—no copying of the object, just a pointer.
- **Syntax**: Uses the arrow operator (`->`) to access members (e.g., `obj->width`) because obj is a pointer. Alternatively, we could dereference with * and use the dot operator (e.g., `(*obj).width`), but -> is more common.
- **Explicit address**: Caller must pass the address using & (e.g., `someFunction(&r)`).
- **Nullable**: Pointers can be nullptr, so we might need to check for validity.

## **Why Use `const Rectangle&` in the Copy Constructor?**

In our example:

```cpp
Rectangle::Rectangle(const Rectangle& source)
```

- **Efficiency**: Passing by reference avoids making an unnecessary copy of the Rectangle object being passed in.
- **Safety**: The const ensures the constructor doesn’t accidentally modify the source object, which is only meant to be copied from.
- **Correctness**: If it were Rectangle source (by value), the copy constructor would be called to create the parameter source, leading to infinite 
