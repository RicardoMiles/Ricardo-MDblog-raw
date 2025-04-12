---
title: Reflection on C++ Objects and Object Pointers Initialisation
date: 2025-04-12 18:19:35
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "Deeper learning and key-point retold driven by Object Pointer Practice Debugging."

---

## The Initial Code

I have a `Student` class with `Student.h` and `Student.cpp`. I worked with them in order to do the exercise

* Define a class `Student` that contains member variables `name` and `score`
* And define a member function `printInfo` to print the student's information. 
* In the `main` function, dynamically create a `Student` object and call the `printInfo` function through a pointer.
* **Hint:** Use `new` and `delete`.

My `main.cpp`

```cpp
#include "Student.h"
#include <iostream>

using namespace std;

int main(){
    Student* student_ptr = new Student{"Peter",150};
    Student* student_mry = &(Student{"Mary",120});
    student_ptr->printInfo();
    (*student_mry).printInfo();
    cout << "Students number in current class: " << Student::getClassStudentsNumber() << endl;

    delete student_ptr;
    student_ptr = nullptr;

    return 0;   
}
```

My `Student.h`

```cpp
#ifndef ADVANCED_STUDENT_H
#define ADVANCED_STUDENT_H
#include <string>

using namespace std;

class Student{
public:
    Student(string name,int score);

    void setScore(const int& score);
    void setName(const string& name);
    string getName() const;
    int getScore() const;
    void printInfo() const;

    static int getClassStudentsNumber(); 
private:
    string name;
    int score;

    static int classStudentsNumber;
};

#endif
```

I bumped into compilation error like this

```cpp
ObjectPointerExercise % g++ Student.cpp Car.cpp main.cpp -o myProgram
main.cpp:16:32: error: no matching constructor for initialization of 'Student'
   16 |     Student* student_ptr = new Student{"Peter",150};
      |                                ^
./Student.h:14:7: note: candidate constructor (the implicit copy constructor) not viable: requires 1 argument, but 0 were provided
   14 | class Student{
      |       ^~~~~~~
./Student.h:16:5: note: candidate constructor not viable: requires 2 arguments, but 0 were provided
   16 |     Student(string name,int score);
      |     ^       ~~~~~~~~~~~~~~~~~~~~~
main.cpp:17:37: error: expected ')'
   17 |     Student* student_mry = &(Student{"Mary",120});
      |                                     ^
main.cpp:17:29: note: to match this '('
   17 |     Student* student_mry = &(Student{"Mary",120});
      |                             ^
main.cpp:17:50: error: expected expression
   17 |     Student* student_mry = &(Student{"Mary",120});
      |                                                  ^
3 errors generated.
        
ObjectPointerExercise % g++ -std=c++11 Student.cpp Car.cpp main.cpp -o myProgram
main.cpp:17:28: error: taking the address of a temporary object of type 'Student' [-Waddress-of-temporary]
   17 |     Student* student_mry = &(Student{"Mary",120});
      |                            ^ ~~~~~~~~~~~~~~~~~~~
1 error generated.

```

At first I thought it was due to compiler standards variation. But I found even in C++11 (or later), my code:

```cpp
Student* student_ptr = new Student{"Peter", 150};
```

Had issues because:

- The constructor Student(`std::string`, `int`) expects a `std::string`, but "Peter" is a `const char*`.
- Brace initialization (`{}`) is stricter than parentheses (`()`) about implicit conversions. The `const char*` to `std::string` conversion, while valid, may be rejected by` {}` unless explicitly allowed (e.g., by constructing std::string("Peter")).
- Pre-C++11, this wouldn’t work at all because `{}` couldn’t call any constructor—Student isn’t an aggregate, and no rule allowed `{}` to invoke` Student(std::string, int)`.

If we were using a pre-C++11 compiler (unlikely, but possible if no `-std=c++11` flag was set), `Student{"Peter", 150} ` would fail outright because brace initialization for non-aggregates wasn’t defined.

**So even with my extra flag `-std=c++11`, there still issues in my code**:

* Using temporary to initialise an object pointer
* Still have incompatibility with constructor parameter and arugments (`const char*` and `std::string`)

It reflects my ignorance of following knowledge

* The brace initialiser (list initialiser, unified initialiser) compatibility in Early C++
* The actual concept of string literal
* Reference could work with temporary, but pointer has limitation on it

## All Traps about String Literal `"Peter"` 

1. ### String Literal Type in C++

   - In C++, a string literal like "Peter" is an array of constant characters with type const char[N], where N is the length of the string plus one (for the null terminator `\0`).
   - For  `"Peter"`
     - It’s an array of 6 characters: {'P', 'e', 't', 'e', 'r', '\0'}.
     - Its type is const char[6].
   - The const qualifier ensures the string literal cannot be modified (e.g., attempting `*"Peter" = 'X' ` is undefined behavior).

2. ### Array-to-Pointer Decay

   - In most contexts, an array type like const char[6] **decays** to a pointer to its first element, i.e., `const char*`.
   - When I pass `"Peter"` as an argument (e.g., in` Student{"Peter", 150};`), C++ treats it as a `const char*` pointing to the memory location of 'P'.
   - This decay happens automatically in function calls, assignments, and other expressions, unless the array is used in a context that preserves its array nature (e.g., `sizeof `or binding to a reference to an array).

3. ### Why Not `std::string`?

   - A string literal (`"Peter"`) is **not** a `std::string`. `std::string` is a C++ standard library class that manages a dynamically allocated character buffer, with methods for string manipulation.

   - To create a `std::string` from a `const char*`, **C++ requires a constructor call of string class**:

     ```cpp
     std::string s = "Peter"; // Implicit conversion via std::string constructor
     ```

   - The `std::string` class has a constructor that accepts a `const char*`

     `std::string::string(const char* s);`

   - However, **this conversion doesn’t happen automatically when the compiler evaluates "Peter" in isolation**. The compiler sees `"Peter"` as a `const char*` (after array decay) and only converts it to `std::string` if we explicitly call string constructor to convert it to string.

4. ### My Specific Case

   **Insight**: String literals in C++ have type `const char[N]` (e.g., `const char[6]` for "Peter"), which decays to `const char*` in most contexts. The `Student` constructor expected a `std::string`, requiring an implicit conversion. Brace initialization is stricter than parentheses (`()`) about such conversions, often rejecting them to prevent unintended type coercions.

   **Test 1** : I tried parentheses initialization:

   ```cpp
   Student* student_ptr = new Student("Peter", 150);
   ```

   This compiled, suggesting that `{}` was indeed the issue. Parentheses allowed the `const char*` to `std::string` conversion (**implicit conversion**), but `{}` didn’t. 

   **Test 2**: I tried explicitly call string constructor to make sure I pass a string

   ```cpp
   Student* student_ptr = new Student{std::string{"Peter"},150};
   ```

   This compiled, suggesting that `{}` was still indeed the issue. With those approach to keep it, I have to explictly do the conversion to avoid ambiguity.

   Converting `const char*` to `std::string` is a user-defined conversion (via the `std::string` constructor), and `{}` may reject a string literal who decayed to constant chararcter pointer to avoid ambiguity or unintended conversions.This is why the compiler reported: `error: no matching constructor for initialization of 'Student'`. I noted this and moved to the next error.

## **Why Brace Initialisation Fails in Earlier C++**

Brace initialization (`{}`), introduced in C++11, follows these rules:

1. Check for a constructor taking `std::initializer_list`.
2. Look for a constructor whose parameters match the types in {}.
3. If the class is an aggregate, perform aggregate initialization.

For `Student{"Peter", 150};` in C++98/C++03 (pre-C++11 standards, my default compiler without extra flag`std=c++11`) :

- Uniform initialization is a C++11 feature. Pre-C++11, `{}` was for aggregates only, explaining why older code avoids it for constructors. **A.K.A. Brace initialization was only for aggregates (classes without user-defined constructors) or arrays.**

  [Click here to check earlier Debugging Note&Reflection about Aggregate Type](https://ricardopotter.github.io/RicardoBlog/2025/04/04/Reflection-on-Aggregate-Types-in-C/)

- `Student{"Peter", 150}` wouldn’t work at all because `Student` **has a constructor, making it non-aggregate, and {} couldn’t call constructors.** Only `()` can call constructor in thiis older standards.

- I can fix it with explicitly define another constructor accepting `cosnt char*` type as parameter, if I have to stick to specific old compiler, and I can use `()` to substitute.

## Temporary Objects Are Dangerous

Compiler warned me that I could use that temporary.

```
Student* student_mry = &(Student{"Mary", 120});
```

**Analysis**: In C++, `Student{"Mary", 120}` creates a **temporary object** (a prvalue), which is destroyed at the end of the full expression. I recalled that I learned that constant reference could work with temporary while non-const reference couldn't be bind to a fleeting,unamed object which also known as temporary object.  [Click here to check rules of temporary in C++](https://ricardopotter.github.io/RicardoBlog/2025/04/11/Reflection-on-CPP-Parameter-Passing/#Edge-Cases-and-Notes). **Taking temporary's address with  address-of operator `&` is illegal because the object no longer exists after the statement, leaving `student_mry` as a dangling pointer.** I also stuck in plight with dangling pointer [Click here to review the dangling pointer Note&Reflection](https://ricardopotter.github.io/RicardoBlog/2025/03/26/Reflection-on-Scope-Rules-and-Dangling-Pointer/)

**Fix**: I realised I should dynamically allocate `student_mry` like `student_ptr`, using new:

```cpp
Student* student_mry = new Student("Mary", 120);
```

Or initialise an Student objct with variable name, taking its address to make my object pointer

```cpp
Student mary = Student{string{"Mary"},120};
Student* student_mry = &mary;
```

## Conclusion

* Always pair `new` with `delete`, and don't forget to assign `null_ptr` to the pointer for avoiding leaks
* Don't forget add `std=c++11` flag, if I used lots of modern C++ features
* Never be ignorant of how the OG C++ works
  * The string literal concept and how it works under the hood
  * The decay mechinic of char arrays
  * How to call constructor of string to initialise a string type variable by passing string literal
  * If I have to stick on older compiler, remember use `()` as precaution
* Dangling Pointer Issue
* Work with temporarys carefully

