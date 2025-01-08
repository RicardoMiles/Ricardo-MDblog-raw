---
title: Code with Mosh in CPP Part One
date: 2025-01-06 15:45:03
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "Tutorial notes and English output try as a non-native blogger."
---



# What is CPP
**Recommended IDE:** Clion

**Cpp executable:** Cpp 20


A project have a unique main file ended with `.cpp` postfix.

Case sensitive language - CPP


Type of value the function gonna return, followed by function name; After the function name, there is a pair parenthesis, followed by a pair of braces

Hash tag with angle bracket define the directive of our program;


Iostream - input output stream


`std` is short for standard library


This is like the bucket or container available for us


`cout` is short for character out, follow by two left angle bracket .


End each line of statement with semicolon.


Terminate it with a semicolon as it is a statement, A line is called a statement.

# Run Code in IDE
CPP code needs to be compiled to machine code that can be run by the computer operating system.

Machine code is the native language that a computer's operating system understands.

The bar  (pane) under codes is called console window or terminal window.

`Command + B` to compile & build codes.

`Command + R` to run codes.

# TOC 

The content included in the ultimate c++ course from CodeWithMosh's version. It is also shown in 

## Basic 
* Fundametals of programming in C++
        * Variables and constants
        * Naming conventions
        * Mathematical expressions
        * Writing to and reading from the console
        * Working with the standard library
        * Comments
* Data types
* Loops
* Decision making statement
* Functions

## Intermediate
* Arrays
* Pointers
* Strings
* Structures
* Enumrations
* Streams

## Advanced 
* Classes
* Exception
* Templates
* Containers

# Foundamentals of CPP
## Variables and constants
Variable - temporarily  store data in computer's memory

Also, it's the name of location in memory where we can store some value.

### Declare a variable in CPP
Data type + Meaningful Name + Assignment Operator (optional) + Value (optional);

Initializing variable is not mandatory, but good to follow;

### Insights behind Swap A and B
Use another variable `temp` to hold the value of variable `A`, and give the value of variable `B` to `A`, give the value of `temp` to `B`.

### Constants
Use constant to prevent some variable's value from changing,

We type the "const" keyword before declaring this variable.

## Naming convention
Snake Case, low case word with lower slash. `hello_world_variable`

Pascal Case, Capitalized the variable name. `HelloWorldVariable`

Camel Case, first lower case and rest word capitalised. `helloWorldVariable`

## Mathematical Expressions
There is operator and operands in a expression, for example, in `A+B`, A and B is the operands
* Addition operator +
* Subtraction operator -
* Multiplication operator x
* Division operator /
* Modulus operator % returns the remainder of a devision

If both of operands are integers, it will not output a result of floating number tho,
At least, one of the operands is double type, so that the result could be floating number.

### `x++`,`++x`and `x=x+1`
Only decrement and increment have notations like `x++` and `x--`
They can be applied as a postfix or as a prefix, What is the difference between them then ?
E.g. `++x` `x++`

```CPP
 int x = 10
 int y = x++;
```
**Postfix notation:** first step the current value of x which is 10 will be assigned to variable y
And then X will be incremented by one
After this code block x will be 11, y will be 10

```CPP
 int x = 10
 int z = ++x
```
**Prefix notation:** Use increment operator as a prefix, first step variable x will be incremented by one, and then the value of x will be stored in z.
So in that case both x and z will be 11

In mathematics, the multiplication and division always have a higher order or priority than addition or subtraction operators


We can always change order of these operators using parenthesis, wrap this in parenthesis

In the fraction ¾, four is the denominator.

Decimal part will gone if the declared variable to store it is integer.

## Write to and Read from the Console

`<<` These double left angle brackets are called the stream insertion operator,

The operator for inserting something to our output stream.

`std::endl` == `\n` newline character to end a line.

`cin` along with the stream extraction operator,

It's the opposite of stream insertion operator,

Stream extraction operator notation is double right angle brackets `>>`

## Working with the standard library

With statement `using namespace std;` declared before main function,

We can simply access all objects in the STD namespace without double colons and `std` prefixed,

`std::cin` could be simplied to just `cin` in that way.


## Comments
It’s more conventional to write a comment above a line

We can also start a mutiple-line comment with a forwar slash and an asterisk


# Fundamental Data Type

C++ is statically type language

When declaring its type we need to specify its type and this type cannot be changed throughout the lifetime of our program

CPP‘s built in types
* Short
* Int
* Long
* Long long
* Float
* Double
* Long double
* Bool
* Char

If we don't type `f` or `l` after float and long type variable's value in assignment statement, compiler will treat them as double and int by default.

Key word `auto` leads our compiler to infer datatype.

Brace initialization, it could defaultly initialize a variable to zero and prevent it shows the random value in garabage before firsst assignment. Garbage makes program unpredictable. Also, it could prevent you from wrong type assignment, 

Decimal part = fractional part

# Warning on Numerical Variable Processing
* Decimal base 10
* Binary base 2
* Hexadecimal base 16

e.g. 0xFF =  0b11111111 = 255

Keyword “unsigned” numerical type should be stayed away, we don't need every feature c plus plus has

Narrowing
Initializing a small type with a larger type
Compiler will narrow down our number
E.g. 

```cpp
 int number =1000000;
 short another = number;
 cout << "another = " << another << endl
```

There is a warning before compilation, and after compilation, this is the result 

```cpp
16960
```

It's the result of narrowing conversion

```cpp
 int number  = 1000000;
 short another {number};
```

Brace initializer's benefit in that case is compiler will prevent us from compiling it 

"=" assignment operator

# Generating a random number
Use the `rand()` function in `ctdlib`, everytime we run our code we get an exact same number. Because the so-called random is not that true random, it technically relys on some mathematical formula

## Getting the current time to get a wilder seed 
Time function calculate the elapsed seconds from 1th of Jan 1970

# `Variable` and `Argument`
* Variable: A variable is a storage location in memory that can hold a value. Variables are used to store data that can change during the execution of a program. They have a name (identifier), a data type, and a value. Variables can be manipulated and used in expressions and statements.
* Arguments: Input values that are passed to a function or a method. When a function is called, the values passed to it are called arguments. These arguments are used by the function to perform specific tasks.

# `Argument` and `Parameter`
* Parameters are the variables defined in a function's declaration that specify what input the function expects.
* Arguments are the actual values or expressions that you provide when you call the function, which correspond to the parameters.

# Hash Define Directive

must place the `#define` directive before the `#include` directive. 

```cpp
#define _USE_MATH_DEFINES
#include <cmath>
```

​	This way, the preprocessor will see the definition of _USE_MATH_DEFINES before it includes the <cmath> header, and the mathematical constants will be available for use in your code. If place #define after it the preprocessor don't get the instruction to do extra operation when replace #include <cmath> because its sequence should be fixed 

Circle area is equivalent to Pi times Radius to the power of **2**
