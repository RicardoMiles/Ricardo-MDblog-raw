---
title: Lessons learned from a Simple C++ Capitalisation Function
date: 2025-03-29 16:36:48
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
excerpt: "Why My Simple C++ String Capitalization Failed - And How to Fix Common Input Mistakes"
---

## Original Code

``` cpp
#include <iostream>
#include <string>

using namespace std;

string capitalise(string raw){
    if(raw[0] >= 'a' && raw[0] <= "z"){
        raw[0] += ('A' - 'a');
    }
    string capitalised = raw;
    return capitalised;
}

int main(){
    // Ask for character from user
    cout << "Please input string: " << endl;
    string rawString = "";
    rawString += cin;
    cout << endl;
    rawString = capitalise(rawString);
    cout << rawString << endl;
    return 0;
}
```

## **Character vs. String Literals (`'z'` vs `"z"`)**

### **Error:**

```cpp
if (raw[0] >= 'a' && raw[0] <= "z")  // Wrong: "z" is a string, not a char
```

### **Lesson:**

- **`'z'`** is a **character literal** (type `char`).
- **`"z"`** is a **string literal** (type `const char*`, a null-terminated array).
- **I can't compare a `char` (`raw[0]`) with a `const char*` (`"z"`).**
- **Fix:** Always use **single quotes (`' '`)** for characters and **double quotes (`" "`)** for strings.

### **Correct Way:**

```cpp
if (raw[0] >= 'a' && raw[0] <= 'z')  // Correct: compares chars
```

------

## **Reading Input Properly (`cin` vs `getline`)**

### **Error:**

```cpp
rawString += cin;  // Invalid: cannot append `cin` to a string
```

### **Lesson:**

- **`cin` is an input stream (`istream`), not a string.**
- **Operator `+=` does not work with streams.**
- **Ways to read input:**
  - **`cin >> str`** (reads until whitespace, **not full lines**).
  - **`getline(cin, str)`** (reads **entire line**, including spaces).

### **Correct Way:**

```cpp
string rawString;
getline(cin, rawString);  // Reads entire line
```

------

## **Handling Empty Strings Safely**

### **Error:**

Original code did **not check if `raw` was empty** before accessing `raw[0]`.

### **Lesson:**

- **Accessing `raw[0]` on an empty string is undefined behavior.**
- **Always check `!str.empty()` before accessing `str[0]`.**

### **Correct Way:**

```cpp
if (!raw.empty() && raw[0] >= 'a' && raw[0] <= 'z') {
    raw[0] += ('A' - 'a');  // Safely capitalize first char
}
```

------

## **Avoiding Unnecessary Copies**

### **Original Code:**

```cpp
string capitalised = raw;  // Unnecessary copy
return capitalised;
```

### **Lesson:**

- **Copying strings is inefficient** (especially for long strings).
- **Return the modified string directly** (C++ optimizes this via **Return Value Optimization (RVO)**).

### **Optimized Way:**

```cpp
return raw;  // No extra copy
```

------

## **Understanding C++ Streams (`cin`, `cout`)**

### **Error:**

Trying to use `cin` as if it were a string.

### **Lesson:**

- **`cin` is an input stream (`istream`), not a string.**

- **Use `>>` for word-by-word input or `getline()` for full-line input.**

- **Example:**

  ```cpp
  int num;
  cin >> num;  // Reads an integer
  
  string line;
  getline(cin, line);  // Reads a full line
  ```

------

## **Compiler Warnings**

### **What the Compiler Told Me:**

- **"Comparison between pointer and integer"** → I compared `char` with `const char*`.
- **"No viable overloaded '+='"** → You tried to add `cin` to a string.

------

## **Final Corrected Code (Recap)**

```cpp
#include <iostream>
#include <string>

using namespace std;

string capitalise(string raw) {
    if (!raw.empty() && raw[0] >= 'a' && raw[0] <= 'z') {
        raw[0] += ('A' - 'a');  // Convert lowercase to uppercase
    }
    return raw;
}

int main() {
    cout << "Please input string: " << endl;
    string rawString;
    getline(cin, rawString);  // Read entire line
    rawString = capitalise(rawString);
    cout << rawString << endl;
    return 0;
}
```

------

## **Summary of Lessons Learned**

| **Mistake**        | **Lesson**                                                |
| :----------------- | :-------------------------------------------------------- |
| `raw[0] <= "z"`    | Use `'z'` for chars, `"z"` for strings.                   |
| `rawString += cin` | Use `getline(cin, str)` to read input.                    |
| No empty check     | Always check `!str.empty()` before `str[0]`.              |
| Unnecessary copy   | Return the string directly (RVO optimises it).            |
| Misusing `cin`     | `cin` is a stream, not a string. Use `>>` or `getline()`. |

### **Key Takeaways for Future Code:**

✅ Be careful with string literals and char literals.
✅ Don't treat cin as if it was a string.
✅ Always check for empty strings before accessing elements.
✅ Avoid unnecessary copies (let C++ optimise).
✅ Learn more about `getline()` function and enhance the understanding stream.
