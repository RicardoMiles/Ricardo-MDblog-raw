# **My C Programming Weakness Summary**

## 🚩 **Problem List**

### 1. **Basic Conceptual Questions**

- Incomplete understanding of ASCII table and character-to-integer relationships.
- Confusion about integer division vs. floating-point division (`/` and `%` operators).
- Struggled with logical operators (`&&`, `||`) and operator precedence.

### 2. **Multi-File Compilation & Linking**

- Not familiar with multi-file compilation (`gcc` compile & link steps).
- Encountered `undefined reference` errors due to missing function declarations or mismatched names (e.g., `int2string` vs. `in2string`).

### 3. **Function Design & Parameter Passing**

- Issues with function declaration vs. definition mismatches.
- Incorrect parameter passing (e.g., missing `size` in functions).
- Unclear about returning arrays from functions and the need to use pointers or dynamic memory allocation (`malloc`, `calloc`, `free`).

### 4. **Pointers, Arrays, and Memory Management**

- Mixed up pointer and array concepts (`int*` vs. `int[]`).
- Unsure about pointer dereferencing (`*ptr`) and array indexing.
- Lack of confidence in memory safety (null pointer checks, freeing memory).
- Incorrect assumptions that struct members (pointers) automatically have allocated memory.

### 5. **String Manipulation & Standard Library Functions**

- Not confident with string length calculation (`strlen` or manual count).
- Confusion about filtering characters (e.g., keeping only letters).
- Problems with reversing strings and understanding `fgets`, `strcspn`, `tolower`, and other standard library functions.

### 6. **Control Flow & Loop Logic**

- For-loop variable shadowing (inner `i` overwriting outer `i`).
- Logical sequence between functions unclear (how output of one feeds input of another).
- Design flaws in data structures (e.g., misunderstanding between 1D vs. 2D arrays or pointer arrays).

### 7. **Preprocessor and Compilation Concepts**

- Unclear about `#define`, macro constants, and why array sizes must be known at compile time.
- Confusion about the differences between `#define`, `const`, and `enum`.
- Issues with Makefile basics, `make` commands, and error messages like `No targets specified`, `undefined reference to main`, and `Clock skew detected`.

### 8. **Debugging and Error Interpretation**

- Not understanding `assert` usage and what “assertion failed” means.
- Difficulty reading and interpreting compiler and runtime errors (like `segmentation fault`).
- Unsure why `scanf` with strings doesn't need `&`.
- Confusion about error messages like `array subscript is not an integer`.

------

## ❌ **Weakness List (Knowledge Gaps)**

### 🔸 **Core Concepts**

- ASCII encoding (especially numbers, letters, symbols).
- Integer division, remainder, and floating-point operations.
- Logical operators and control flow logic.

### 🔸 **Compilation & Project Structure**

- Multi-file compilation and linking.
- Function declaration, definition, and call consistency.
- Makefile basics and compilation workflow.

### 🔸 **Memory Management**

- Dynamic memory allocation with `malloc`, `calloc`, `realloc`, and `free`.
- Understanding of memory safety, including null pointer checks and preventing leaks.
- Correct handling of struct pointers (especially struct members that are pointers).

### 🔸 **Pointers and Arrays**

- The relationship between arrays and pointers.
- Pointer arithmetic and dereferencing.
- Passing arrays and pointers between functions, especially 2D arrays.

### 🔸 **String Handling**

- String length calculation (`strlen`, manual counting).
- Filtering and reversing strings manually.
- Proper use of C standard string functions (`fgets`, `strcspn`, `tolower`, etc.).

### 🔸 **Testing and Debugging Skills**

- `assert` usage and test case design.
- Understanding common C errors like segmentation faults, invalid operands, and type mismatches.
- Reading and interpreting compiler warnings and error messages.

### 🔸 **Toolchain & Preprocessor Understanding**

- Use of `#define`, `const`, and `enum`.
- Awareness of compile-time constants.
- Makefile structure and basic commands (`make`, `clean`, targets).

### 🔸 **Loop and Scope Awareness**

- Variable scope, shadowing issues in nested loops.
- Correct variable naming and avoiding accidental overwrites.
- Function design with proper parameter planning (avoiding repeated global/local confusion).

------

## 🟢 **Summary of Focus Areas for Improvement**

> 1. Pointers and memory management (safe usage, allocation, freeing).
> 2. Multi-file compilation, Makefile, and linking.
> 3. String processing and standard library mastery.
> 4. Clear function design (parameters, return types, struct usage).
> 5. Better debugging and error analysis skills.
> 6. Basic Linux command-line familiarity (`cat`, `less`, `scp`).