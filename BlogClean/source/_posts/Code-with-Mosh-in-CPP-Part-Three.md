---
title: Code with Mosh in CPP Part Three
date: 2025-04-07 01:19:56
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "Tutorial excerpts from Mosh’s CPP course part 2. OOP FOCUSED!"

---

## What is OOP

Program paradigm - Style of programming

* Procedural
* Functional
* Object-Oriented
* Event-Driven 

Functional and OOP is the two most popular ones nowadays 

**Object** - A software entity that has **attributes** and **functions**

* attributes - properties
* function - methods

Class - A class is a blueprint or recipe for creating objects



We can represent a classs using vision language called UML - which is short for Unified Modelling Language 

In UML, we use a box with three sections, on the top we have the class name, in the middle section we list attributes or variables that holds data, at bottom section we list functions. These variables and functions are called **members of the class**

**Structure is more about data, Class is more about DATA+BEHAVIOR**. This is one of the core principles of OOP called **Encapsulation** (Combining the data and functions that operate on the data into one unite)

An object is an instance of class 

In UML we call the data part attributes, in C++ we call them member variable, in other languages we call them fields or properties. All of those terminology is the same - a variable inside a class

 Methods = Member functions 

## Define a Class

Use Clion's feature of creating a C++ class will automatically create a `Classname.h` headerfile and a `Classname .cpp` file with same name which is linked. We can also do these thing manually.

In the headerfile, we are going to define the features of class. We are gonna include this headerfile later

we have header guard  in header files to prevent this headerfile being included multiple time in the compilation process

```cpp
#ifndef ADVANCED_RECTANGLE_H
// if this constant is not defined
#define ADVANCED_RECTANGLE_H
// we are gonna define it 
class Rectangle{
    int width;
    int height;
    void draw();
    int getArea();
};

#endif // ADVANCED_RECTANGLE_H
```

* We use double quotation marks to include header files from out own project while using angle bracket to include headers from standard library 
* We only do function declaration or aka function prototype in header files, the actual implementation is gonna go our cpp files
* In cpp files we qualify the function by its class name using double colon`::` which is called scope resolution operator

```cpp
#include "Rectangle.h"
#include <iostream>

/*
    Here we have to qualify the draw() function
    With its class name
    Double colon :: is called scope resolution operator
*/
using namespace std;

void Rectangle::draw(){ 
    cout << "drawing a rectangle" << endl;
}

int Rectangle:: getArea(){
    return width * height ;
}
```

## Creating Objects

We are not gonna include `.cpp` file of class implementation, we only `#include "ClassName.h"` because

The reason we have two files per class is to reduce compilation time, our main file `main.cpp` is independent from the `Rectangle.h`

When we do change to `ClassName.cpp`, only itself will be recompiled. but if we do change to `ClassName.h` then every files that is depend on the `ClassName.h`  like `#include "ClassName.h"` will be recomipled. 

An object is an intance of a class, we can access the member of this object by dot operator like 

```cpp
ClassName object;
object.membervariable = "string";
```

Compilation error will told us we can not access a private member of a class outside of the class. This is the main difference of classes and structures. 

* In structures, when we declare members they are always public or accessible by default
* In classes, when we declare members, they are always private or inaccessible by default

In order to make them public, we have to use keyword `public` by a colon `:` before all those public members declaration

```cpp
class Rectangle{
public: 
    int width;
    int height;
    void draw();
    int getArea();
    // Now all the members above is accessible and exposed outside this class
}
```

To compile a C++ project with a header file (e.g., ClassName.h), an implementation file (e.g., ClassName.cpp), and a main file (e.g., main.cpp), we can compile all files together into an executable using g++:

```bash
g++ -o myProgram main.cpp ClassName.cpp
```

The **sequence** of `main.cpp` and `ClassName.cpp` in the command does **not** matter for the compilation process itself. The g++ compiler processes all the source files listed (`main.cpp` and `ClassName.cpp`) and links them together into the executable (`myProgram`), regardless of the order in which they appear on the command line. Here's why:

We can also compile each .cpp file into an object file first, then link them:

```bash
g++ -c ClassName.cpp -o ClassName.o  # Compile ClassName.cpp to object file 
g++ -c main.cpp -o main.o            # Compile main.cpp to object file 
g++ main.o ClassName.o -o myProgram  # Link object files into executable
```

- `-c`: Compile without linking.
- `-o`: Specify output file name.

## Access Modifier

Data hiding principle of OOP saves invalid value assignment -  A class should hide its internal data from the outside code and provide functions for accessing the data.

`public` `private` `protected` are access modifiers , as the best practice we add public section first then add private section 

## Getters and Setters

To achieve Data Hiding principle, by making them private, for each varibale we need two functions accessing one to get value one to set value. 

Getter is also called accessor

Setter is also called mutator (to mutate something means to change something)

`this` is the pointer to current object, we need to de-reference it before we use dot operator to access the actual object, pointer is always just address

Lots of ppl use `m_` M Underlined prefixed to differenciate the parameter and member variable with same name

```cpp
/*
    A mosh preferred way to differenciate assignment variables
*/

void Rectangle::setWidth(int width){
    if(width < 0){
        throw invalied_argument("Width Error");
        // Throw a exception
    }
    (*this).width = width;
    // shortcut for it would be like
    // this->width = width;
}
```

We can also use ClassName followed by double colon to access current object's private member variable like `Rectangle::width = width`, it is another equivalent

* Plus sign in UML means `public`
* Hyphen sign in UML means `private`

Mosh's implementation of a TextBox class suggested that 

* When we pass a string parameter to fucntion, it is always better to pass it as a reference parameter like `void setValue(string& value);` , value are not copied across function calls, this is for performance reasons
* Also it is better to declare the parameter a constant `void setValue(const string& value);`, avoiding accidental modification on `value`

## **Constructors**

Constructor is a special function inside class that initialising object, that could avoid the invalid calling of getter by properly do assignment to private variables at first.

Consturctor doesn't have return type, not even `void`, their name is exactly the same as the ClassName

```cpp
class Rectangle{
public:
    Rectangle(int width, int height);
    void setWidth(int width);
    void setHeight(int height);
    int getWidth();
    int getHeight();
private:
    int width;
    int height;
};
```

Using curely braces to initialise objects

```cpp
int main(){
    Rectangle rectangle{10,20};
    return 0;
}
```

## Member Initialiser List

In modern C plus plus, our compiler clearly know the left `width`is our member variable, the `width` inside curely braces is paramter, we can do the same for `height` after comma 

```cpp
Rectangle::Rectangle(int width,int height):width{width},height{height}{
}
```

A member initialiser list - techinique is slightly effiecient, but doesn't give us access to do validations

The approach is not exclusive with the tradition approach that do the initialisation inside of the body 

## The Default Constructor

A default constructor is a constructor with no parameters

Just like functions we can always overload constructors, we can have two constructors with different signature

 In modern C++ we can tell our compiler to generate a default compiler for us in `ClassName.h` like this

```cpp
class ClassName{
public:
    ClassName() = default;  
};
```

Instead of do implementation in `ClassName.cpp` like this

```cpp
ClassName::ClassName(){
}
```

C plus plus compiler generator a default constructor for every class, that is the reason why we can create class and object without out manually and explicitly defined constructors.

Compiler stops generating a default constructor for us until we declare a non-default constructor, that is why we can't use the `ClassName ObjectName;` to declare an object in main program without giving it parameters. 

## **Using the Explicit Keyword**

Single-argument constructors must be marked explicit to avoid unintentional implicit conversion

That is how implicit conversion happens

```cpp
class Person{
public:
    Person(int age);
private:
    int age;
}
```

In `main.cpp` :

```cpp
#inlude "Person.h"

using namespace std;

void showPerson(Person person){

}

int main(){
    Person person{20};
    showPerson(20);
    // When we pass int 20
    // Reason it works is our compiler knows
    // In this class we have a constructor takes an int
    // It implicitly converse the int to a Person object
}
```

After declare our single-argument construct with `explicit` keyword, we can't pass int to `showPerson()` anymore. Because after that, our compiler will force us to pass a proper Person object to the function. If we apply `explicit` keyword, there is no longer a "Convertin Constructor"

```cpp
class Person{
public:
    explicit Person(int age);
private:
    int age;
}
```

## **Constructor Delegation**

 A constructort can delegate  the initialisation of an object to another constructor. With this feature, we can remove duplicate code. 

Given that `Rectangle.h`

```cpp
class Rectangle{
public:
    Rectangle(int width, int height);
    void setWidth(int width);
    void setHeight(int height);
    int getWidth();
    int getHeight();
private:
    int width;
    int height;
    string color;
};
```

We have the `Rectangle.cpp`

```cpp
#include "Rectangle.h"
#include <iostream>
#include <string>

using namespace std;

Rectangle::Rectangle(int width, int height){
    setWidth(width);
    setHeight(height);
    
}

// Call another constructor so that we can avoid duplicate code
// colon after the signature to call 
Rectangle::Rectangle(int width, int height, const string& color):Rectangle(width,height){
    this->color = color;
}

void Rectangle::draw(){ 
    cout << "Drawing a rectangle" << endl;
    cout << "Its width is "<< width << ", its height is " << height << "\n";
}

int Rectangle::getArea(){
    return width * height ;
}

void Rectangle::setHeight(int heightInput){
    if(height < 0){
        throw invalid_argument("Height Error");
    }
    height = heightInput;
}

void Rectangle::setWidth(int widthInput){
    if(width < 0){
        throw invalid_argument("Width Error");
    }
    width = widthInput;
}

int Rectangle::getHeight(){
    return height;
}

int Rectangle::getWidth(){
    return width;
}

```

* Call another constructor by using `:` after the curent constructor's implementation signature, passing all the paramters it should take
*  There is no limitation of delegation times, but too much constructor leads to unmaintainable code

## **The Copy Constructor**

Copy constructor is another special constructor,  which is used for copying objects. 

```cpp
int main(){
    Rectangle first{10,20,"orange"};
    Rectangle second = first;
    return 0;
}
```

As for second line `Rectangle second = first;` , the reason coyping works is because under the hood the compiler automatically generates a copy constructor in the rectangle class . This copy constructor takes source object, and then it copy all the values in the source objects to initialise the second object.

This automatical work of copy constructor works pretty well all the time, but sometimes there are situations we need to have control of how objects are copied

Explicitly declare a copy constructor in the header file

```cpp
Rectangle(const Rectangle& source); 
// single parameter
// the type of parameter has to be the same as the class 
// make it reference parameter
// if we don't do so, compiler doesn 't know how to copy it 
// Because the copy operation is defined in this constructor 
// also, we should make it a constant parameter
// So we don't accidentally modify the source object as part of the copy operation 
```

In the implementation `Rectangle.cpp`

```cpp
Rectangle::Rectangle(const Rectangle& source){
    this->width = source.width;
    this->height = soure.height;
    this->color = source.color; 
}
```

It's always best to rely on the copy constructor that the compiler generated for us, because when we have more members added into the class, we have to add more lines to copy more object's variable members manually.  

* If we pass object directly to a function as parameter, it is gonna be copied 
* Use reference we pass the source object to the function 
* Every time we pass object as parameter, a copy constructor will be called
*  



If we go to implementation file and remove the explicitly created copy constructor then go to header file telling our compiler to delete the copy constructor for us

```cpp
Rectangle(const Rectangle& source) = delete;
// If we don't include this line
//the compiler will automatically generate another copy constructor for us 
```

With that we can validate that every time we pass object directly as parameter, copy constuctor will be called, we explicitly deleted the copy constructor then all the function with direct object pass can't work 

## The Destructor

 Destructor are automatically called when our object are being destroyed and this is an opportunity for us to free system resources that an object is using. So if we allocate memory or open a file or network connection, then we need to release these resources in destrcutors

In our header file we type a `~` followed by the name of the class, similar to constructor, our destructor doesn't have a return type and the name is exactly the class name :  `～Rectangle();` We can not overload destructors. Each class can have a maximum of one destructor.

``` 
Rectangle::~Rectangle(){
    cout << "Destructor called" << endl;
}
```

In main program we have a Rectangle object, this object is declared on stack. So when the main function finishes the execution. This object is going to go out of scope. So it will be destroyed, At that point, the destructor will be called. 

``` cpp
int main(){
    Rectangle first;
    return 0;
}
```

## Static Members

 All the functions and variables we declared so far is are what we called instance member, this member belong to instances of the `Rectangle` class, each instance is gonna have its own copies of these members.  We can also declare members that belong to the `Rectangle` class itself, so we will have only single copy of this member in memory. And this single copy will be shared by all instances. We call it static members

```cpp
class Rectangle{
public:
    static int objectCounts;
    ~Rectangle();
    Rectangle(int width, int height);
    Rectangle(const Rectangle& source);
    void setWidth(int width);
    void setHeight(int height);
    int getWidth();
    int getHeight();
private:
    int width;
    int height;
    string color;
};
```

*  Whenever we declare a static variable, we should always define it in our implementation `.cpp` file

  ```cpp
  int Rectangle::objectCount = 0;
  
  Rectangle::Rectangle(int width, int height){
      objectCount++;
      setWidth(width);
      setHeight(height);
  }
  ```

* We access static variable member by scope resolution operator and class name `ClassName::staticVariable` if it is in public section

* But better practice is put in private section and use line break to separate it from instance members, then define a getter for it

  ```cpp
  static int getObjectCount();
  // In header file we need static keyword, in implementation file we remove it
  int ClassName::getObjectCount(){
       return objectCount; 
  }
  
  int main(){
      // Call it by ClassName
      cout << Rectangle::getObjectCount() << endl;
      return 0;
  }
  ```

  ## **Constant Objects and Functions**

  Just like we can declare a constant integer, we can also declare a constant object

  ``` cpp
  int main(){
      const Rectangle rectangle;
      // When we declare an object as constant
      // Our compiler makes all of its attributes constant
      // Which is Read-only and Immutable
      return 0;
  }
  ```

  * We can't modify the attributes of a constant object - They're read only and immutable
  * When we add the keyword `const` at the end of a function declaration, we are telling the compiler that in this function we're not gonna change the state of this object
  * It's the best practice that put the `const` keyword at the end of function declaration if it doesn't change the state of object
  * Compiler doesn't allow us to use function without `const` keyword for constant object, because it think there may be some risk that object will be changed in those non-constant functions

  ```cpp
  // Syntax for constant function in header file
  int getAge() const;
  // Syntax for constant function in implementation file
  int getAge() const{
      return age;
  }
  ```

  A function to get static member, which is static member, we can still call them when we use a constant object without declare it with`const`. But we should always call it use the `ClassName::staticMemberGetter`

  ```cpp
  int main(){
      const Person meow = Person("Meow",10000);
      // Given that peopleCount is a static member of class like below
      // In headerfile
      // static int peopleCount;
      // static int getPeopleCount();
      // In implementation file
      // int getPeopleCount(){ return peopleCount; }
      // int People::peopleCount = 0;
      int peopleCount = Person::getPeopleCount();
  }
  ```

  The reason we can still access it is due to static member is shared by all objects, we can not change it.

  ## Pointer to Objects

  All the object we have created so far is on the stack - which is a part of  memory that automatically cleaned when our object go outside the scope. When the main function finishes execution, the object we created in the main function will go out of scope, the destrcutor of object's class get called, the memory allocated to this object  will be freed automatically.

  Object created on stack is useful when they are local to a function, so we don't need them outside the function. But sometimes we need an object to stay in memory when the function finishes its execution. In this case we need create object on the heap use the new operator 

  ```cpp
  int main(){
      Rectangle* longerRectangle = new Rectangle(10,20);
       (*longerRectangle).width;
      longerRectangle->length;
      // delete only do operation to the memory 
      delete longerRectangle;
      // we should make it point to null ptr
      // otherwise it will stick to the address forever
      // we refer to that a dongling pointer
      // it leads to memory leak
      longerRectangle = nullptr; 
      return 0;
  }
  ```

  `new` operator returns a pointer, in this case Rectangle object pointer, so we store it in a Rectangle pointer.

  Because it is a pointer, so we can access by arrow operator `->` or dot operator`.` after dereferencing. 

   

  We can rewrite with smart pointer

  ```
   #include <memory>
   
   int main(){
      // specify the the object we wanna create in angle bracket
      unique_ptr<Rectangle> longerRectangle =  make_unique<Rectngle >(10,20) ;
      rectangle->draw(); 
      return 0;
  } 
  ```

  <img width="1840" alt="Image" src="https://github.com/user-attachments/assets/1c9cfbaf-0425-4124-a3f1-a3dd61f9302b" />

  ```cpp
  #ifndef ADVANCED_SMART_POINTER_H
  #define ADVANCED_SMART_POINTER_H
  
  class SmartPointer{
  public:
      // My raw implementation below
      // SmartPointer(int* ptr);
      // single argument constructor need explicit as better practice
      explicit SmartPointer(int* ptr);
      ~SmartPointer();
  
  private:
      int* ptr;
  };
  
  #endif
  ```

  then implementation

  ```cpp
  #include "SmartPointer.h"
  
  SmartPointer::SmartPointer(int* ptr){ 
      this->ptr = ptr;
  }
  
  SmartPointer::~SmartPointer(){
      delete ptr;
      ptr = nullptr;
  }
  ```

  main.cpp

  ```cpp
  #include "SmartPointer.h"
  
  int main(){
      SmartPointer ptr{new int}; 
      return 0;
  }
  ```

  * Use new operator + DataType, we get a return of DataType Pointer, then we use it to initialise the object of SmartPointer Class. 
  * Use curely braces to initialise the object



## **Array of Objects **

We can create array of Objects just like any other data type.

There is two ways to generate an array of object

```cpp
Rectangle recArray[3] = {Rectangle(10,20),Rectangle(10,20,"blue"),Rectangle()};
```

Here we explicitly call the constructors

```cpp
Rectangle recArray[3] = { {10,20},{10,20,"blue"},{}};
```

We can also use the brace initialiser, because compiler know each element of array is an instance of Rectangle object, we  directly put the brace initialiser in body of array declaration without giving the data type.
