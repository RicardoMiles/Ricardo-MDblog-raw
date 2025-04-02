---
title: Code with Mosh in CPP Part Two
date: 2025-03-06 07:45:03
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "Tutorial excerpts from Mosh’s CPP course part 2."
---

## Array

###  **Creating and intialising arrays**

* C plus plus never block us from accessing the invalid index element, we will get a little warnings but still compile code sucessfully.

* Instead of explicitly initialising every single element, using brace initialiser when declare an array, the rest elements will automatically be assigned to zero by default.

  ``` cpp
  int main(){
  		int numbers[5] = {[0] = 10, [1] = 20};
  
  		Cout << numbers;
  
  		Return 0;
  }
  ```

* Directly print array itself without accessing an element with index, we will get a hexdeccimal number , it is pointer

* **Always use prural name for array bc it's a sequence of data in memory.**

* Omitting the number in square bracket when we declare an array while offering the value of elements, our compiler will infer the array size by itself. For example, `int arrays[] = {1,2}`, our compiler can know the size by brace initialiser 

### **Determine the Size of Array**

* Range-based Loop for Array 

  ```cpp
  #include <iostream>
  using namespace std;
  
  int main(){
    int numbers[] = {10,20};
    for (int num:numbers){
        cout << num << endl;
    }
    return 0;
  }
  ```

​			sometimes we will get some warnings from compiler because we didm't specify the standard, the default 			cpp standard was C++98. Range-based loop is one of C++11 features.

​			The traditional loop for array is shown below:

* ```CPP
  #include <iostream>
  using namespace std;
  
  int main(){
  	int numbers[] = {10,20};
    for(int index = 0; index < 3; index++){
      cout << numbers[index] << endl;
    }
    return 0;
  }
  ```

* When using range-based loop, `auto` keyword applied could fully use the inferring ability of CPP feature

  Shown below is equivalent to the 

  ```cpp
  #include <iostream>
  using namespace std;
  
  int main(){
    int numbers[] = {10,20};
    for (auto num:numbers){
        cout << num << endl;
    }
    return 0;
  }
  ```

​			`auto` keyword is C++11 feature too, it let our compiler infer the type of variable. 

* A trick for automatically count the size of array is `sizeof` operator, return number of bytes allocated to the array, we need to divide it by Byte size of its data type, then we get the size of array

  ```cpp
  #include <iostream>
  using namespace std;
  
  int main(){
    int numbers[] = {10,20,40};
    for (i = 0; i < sizeof(numbers) / sizeof(int); i++){
        cout << numbers[] << endl;
    }
    return 0;
  }
  ```

* More advanced is `size()` function built in C++ standard library, it is defined in std namespace

   ```cpp
   #include <iostream>
   using namespace std;
   
   int main(){
     int numbers[] = {10,20,40};
     for (i = 0; i < size(numbers); i++){
         cout << numbers[] << endl;
     }
     return 0;
   }
   ```



### **Copying Arrays**

* In C++ we can not assign one array to another one , if we wanna copy an array, we should copy elements one by one, it was always done by traditional for loop because element should be put in the same index (position) of those two arrays. 

### **Comparing Arrays**

* The reason why we can't compare two arrays by their name in if statement is that when we access array by its name, we get a hexdecimal number which is array's pointer. Two arrays could not be allocated in same area of memory, so there is no possibility that comparing two arrays by their name like `if(FirstArray == SecondArray)`. **It is deadly error cause!**

* Depends on Boolean type variable to track the equality of two arrays is correct solution

  ```cpp
  #include <iostream>
  using namespace std;
  
  int main(){
    int FirstArray[] = {10,20,30};
    int SecondArray[] = {10,2,30};
    
    bool isEqual = true;
    for(i = 0; i < size(FirstArray); i++){
      if(FirstArray[i] != SecondArray[i]){
        isEqual = false;
        break;
      }
    }
    
    cout << boolalpha << isEqual; 
    
    return 0;
  }
  ```

### **Passing Arrays to Functions**

 Under the hood, when we reference an array without index, it is a hexdecimal number stores memory addresss working as pointer . So, it is impossible to loop over a number, we can loop a list of elements

When we pass array to function, bug emerged  as follow:

```cpp
void PrintArray(int numbers[]){
  	for(int num:numbers){
      cout << num << endl;
    }
}
// It occurs to be some error because numbers here is a hexdecimal number can't be loop 
```

Traditional loop still faces bug 

```cpp
void PrintAray(int numbers[]){
		for(int i = 0; i < size (numbers); i++){
		    cout << numbers[i] << endl;
		}
}
// interger array when you referencing it without index, it will be converted to a pointer
// interger pointer just holds a number 
// It doesn't make sense that pass a memory address to size() function
```

Solution is whenever we wanna pass an array to a function, we should always include its size as parameter of function as well 

```cpp
void PrintAray(int numbers[],int size){
		for(int i = 0; i < size; i++){
		    cout << numbers[i] << endl;
		}
}
```

### **Understanding `size_t`** 

Size_t is a data type defined in C plus plus standard library , "t" here is a short for type, when we use `sizeof()` operator , cpp will automatically returns a data structure called `size_t `

* int hold 4 Bytes,long long holes 8 Byte
* Size_t holds 8 Bytes, it can only hold positive number size_t is the same is unsigned longlong, sometimes due to different compiler,  size_t is just equivalenet of unsigned int.
* Long long take 8 Bytes of memory
* numeric_limits class is defined in a standard library

### **Unpacking Arrays**

No matter how we called it, we can use this hack to unpacking an array to couple of different variables like shown below

```cpp
int main(){
	int value[3]= {20,30,40};
	
	int x = value[0];
	int y = value[1];
	int z = value[2];
	
	return 0;
}
```

* In Cpp we call it structured binding
* In Python we call it unpacking
* In JavaScript we call it restructuring

```cpp
int main(){
	int value[3] = {20,30,40};
	
	auto [x,y,z] = values;
	
	return 0;
}
```

* equivalent advanced unpacking that takes use of CPP 11 new feature

### **Searching Arrays**

* Linear searching: iterating the whole list to compare - Time complecity - O(1) - O(n)big one notation

* Binary Search

* Ternary Search

* Jump Search

* Exponential Search

  

  A linear search implementation

  ```cpp
  #include<iostream>
  using namespace std;
  
  int linearSearch(int array[],int targetValue,int size){
      for(int i = 0; i < size; i++){
          if(array[i] == targetValue){
              return i;
          }
      }
      return -1;
  }
  
  int main(){
      int numbers[] = {20,30,40};
      int targetValue = 30;
      // int result = linearSearch(numbers, targetValue, size(numbers));
      // Reason why I comment is due to default compiler setting by commandline g++ *.cpp -o *
      // As shown below, an OG way
      int result = linearSearch(numbers, targetValue, sizeof(numbers)/sizeof(numbers[0]));
      cout << "Target number located at #" << result << endl;
      return 0;
  }
  
  ```

### **Sorting Arrays**

* Bubble Sort, Selection Sort, Insertion Sort, Merge Sort, QuickSort
* Reflection on Bubble Sort was in [Reflection on Bubble Sort Implementation](https://ricardopotter.github.io/RicardoBlog/2025/03/10/Reflection-on-My-Implementation-of-Bubble-Sort/)
* More Sort Learning Excerpts tbc.

### **Multiple Dimensional Array**

Represent a matrix using 2-dimensional array, 2 by 3 matrix declared two row three columns

```cpp
Int matrix[2][3] = {

{11,12,13},

{21,22,23}

};

For (int row = 0; row < rows; row++){

	For(int col = 0; col < columns; col++){

		cout << matrix[row][col] << endl;

	}
}
```

Pass the multi-dimensional array as a parameter to a function, call the function by pass the variable name of array

## Pointer

### **What is a pointer** 

Pointer is a special variable that hold the address of another variable in memory

A variable is just a label for memory address

Pointers could efficiently pass large objects, do dynamic memory allocation, enable polymorphism

### **Declare and use a pointer** 

Every variable has an address, prefix the variable name with & like `&variablename`

`&` is called the address-of operator, we can use it to access address value of variable 

Variable Type + asterisk -> represent a pointer e.g. `int*` 

Followed by a pointer variable name, just other type of variable e.g. `int* ptr`

Just like other variables, if we don't initialise this pointer, it's gonna hold garbage or junk values. So if we use uninitialised pointer, we might end up accessing a part of memory we are not supposed to , and in that case the operating system is going to terminate out program and say memory access violation. So as a best practice, we should always initialise our pointers.

In order to initialise our pointers, we can use address-of operator to set our pointer variable's value to the address of another variable. If we don't know what variable this is going to point to, we can set to null pointer e.g. `int* ptr = nullptr` , `nullptr` is a special keyword in modern C plus plus, it is a pointer does not point to anything.

In the future, we can benefit from null pointer by check a pointer before use it. (Be like if it is not a nullpointer, we are gonna use it)

In the earlier version of C plus plus and C we use `NULL` in all capital or `0`, modern CPP use `nullptr`

Dereferencing operator(Indirection), type an asterisk before our pointer like `*ptr`, with this we can access the data at target memory location. 

* Asterisk being put at right after the data type -> address-of operator

* Asterisk being put at left of pointer variable name -> indirection / dereferencing operator

### **Constant Pointer**

If our variable is constant integer like `const int x = 10`, then use `int* ptr` point to the variable x will cause compilation error, cuz we can not use an integer pointer point to a constant integer, the type should be identical.  

So we use constant interger pointer shown below

```cpp
int main(){
    const int x = 10;
    const int* ptr = &x;

// Over there, if we use indirection operation to access this memory location 
// And try to update the value
// We get compilation error, cuz it's the same as setting x to 20.
// It's illegal bc x is constant variable
// *ptr = 20; is not allowed here
// We can set another variable and make our pointer point to it
// Our pointer is not constant
// It's a normal pointer points to constant int type

     int y = 10;
     ptr = &y;
     *ptr = 20;

     return 0;
 }
```

To define a constant pointer, we should put the `const` keyword after the asterisk like this `int* const ptr = &x`. Once we have this, we can not change it value. That means we should always initialise constant pointer cuz we can't change its value later.

This two groups of concept are totally different

* constant pointer points to constant integer

* pointer points to constant integer

### **Passing Pointers to Functions** 

If we pass a variable's value to void function, and then update the value in the function. When we call the variable again, nothing gonna happen to the original variable's value. Cuz the operation mechanism under the hood was just copy the value stored in original variable when calling and passing value to void function in main function. Then the copied value will be assigned to the parameter of void function, which works like local variable of those void functions. When the void function finished running, all local variable would be crashed. 

```cpp
 void increasePrice(double price){
   price *= 1.20; 
 }

 int main(){
     double price = 100;
     increasePrice(price);
     cout << price;
     return 0;
 }
```

The output of above code snippest gonna be still 100. 

Then we can use an OG style of pointer operation to passing value around

```cpp
void increasePrice(double* price){
  *price *= 1.2 ;
}

int main(){
  double price = 10;
  double* priceptr = &price;
  increasePrice(priceptr);

  // It can be simplifies to increasePrice(&price)

  //but for clarity I declared a new variable

  cout << price;

  return 0;

}
```

In that case, value of price would be updated properly. It is complex but makes lots of sense.

In modern C++, references are often preferred, which is introduced in Mosh's course. References cannot be `nullptr` , whereas pointers can be null, leading to potential undefined behavior.

- **Modern C++**hide the dereferencing (`*`) and address-of (`&`) operations, making the code more readable.

  ```cpp
  void increasePricer(double& price) { 
    price *= 1.2; 
  }  // No explicit dereferencing needed
  ```

- **Pointers** require explicit dereferencing (`*`) and often extra variables to hold addresses.

  ```cpp
  void increasePrice(double* price) { 
    *price *= 1.2; 
  }  // Must dereference explicitly
  ```

With references, we don’t need an extra pointer variable. We directly pass variable prototype to the function, then it'll be dealt by address-of operator in parameters definition.

```cpp
void increasePrice(double& price){
  price *= 1.2 ;
}

int main(){
  double price = 10;
  increasePrice(price); // Directly pass variable to it
  cout << price;
  return 0;
}
```

### **The Relationship Between Arrays and Pointers**

After declaration of an array, we can print **the memory address of the first element in array** in hexdecimal number. Like

```cpp
int main(){
	int ArrayName = {1,2,3};
	cout << ArrayName << endl;
  // We are going to get a hexdecimal number here
  cout << *ArrayName << endl;
  // We are going to get number 10 on screen
	return 0;
}

```

Compiler treats our array name as an pointer to the first element of array. We can assign it to any other pointer like shown below

```cpp
int main(){
    int numbers[] = {10,20,30};
    int* ptr = numbers;
    // We initialised a pointer by another one.
    cout << *numbers;    
    return 0;
}
```

That is why when we pass an array to function, `size()` doesn't work with the array name. Compiler treat the parameter as an int pointer, and we can't pass an address to `size()` function and use range-based for loop

```cpp
void printNumbers(int numbers[]){
	  numbers[0] = 0;
}

int main(){
  int numbers[] ={10,20,30};
  int* ptr = numbers;
  printNumbers(numbers);
  cout << numbers[0] << endl;
  // then it gonna be 0 in output
	return 0;
}
```

Our array is passed by reference, so it means every changes we make to this array is gonna be visible outside of the function. C++ compilers always pass array using a pointer.

### **Pointer Arithmetic**

When we increase our ptr by `ptr++`, the value of ptr increase by `sizeof(numbers)`

`ptr + 1` == `*ptr + sizeof(datatype it points to)`

For example

```cpp
#include <iostream>
using namespace std;

int main(){
	int numbers[] = {10,20,30};
	int* ptr = numbers;
  // Let's say the value of ptr is 100
  
  // 3 equivalent expressions
  cout << ptr[1]; 
  cout << numbers[1];
  cout << *(ptr+1);
  
  ptr++;
  // Current ptr value is not 101, it's 104 bc sizeof(int) == 4
  cout << *ptr << endl;
  // Then if we print the dereferenced ptr, we are gonna see the second element's value
  // It is 20
	return 0;
}
```

We can also do subtraction to pointers like `ptr--`

### **Comparing Pointers**

The pointers can be compared by `<`,` >`, `==`, `!=`

We can use it to avoid nullpointer

```cpp
if(ptrX != nullptr){
	cout << *ptrX;
}
// If the pointer is not null pointer, then use it
```

### **Dynamic Memory Allocation**

During program execution or runtime, if it needs more space we can allocate it on demand, we are gonna use a nex syntax to implement dynmamic memory allocation

```cpp
int main(){
   // Stack
   // int numbers[1000];
  
   // Heap (Free Store)
   int* numbers = new int[10];
   delete[] numbers;
   // the square brackets here just because it deallocating array
   int* number = new int;
   delete number;
   // reset
   number = nullptr;
   numbers = nullptr;
   return 0;
}
```

Use `new` operator followed by the target type, when we use this syntax to declare such a variable, that variable is declare in a part of memory called Heap (Free Store). The new operation returns a pointer.

Goings that variables declared on Stack is: they get automatic cleanup, when it is going to go out of the scope (e.g. the fucntion it was declared at)  ,memory that was allocated to it will get released automatically

When we declare a variable on the Heap using the `new` operator, we programmers are responsible for the cleanup. Once we have used the variable, we should always dealocate memory using the `delete` operator

### **Dynamically Resizing an Array**

The implementation of resizing an array should include 

* Resize the array when it is full (Checking size - usually if block)
* Create a temp array (twice as the current size)
* Copy all the elements
* Have original array-name pointer point to the new array

Debugging reflection of dynamically resizing an array was shown in [Dangling Pointer and C++ Scope Rules](https://ricardopotter.github.io/RicardoBlog/2025/03/26/Reflection-on-Scope-Rules-and-Dangling-Pointer/)

Then we should not only recycle the array once. It is dynamical so it shall be more flexible like this

```cpp
#include <iostream>
using namespace std;

int main(){
    // Creating integer array 
    int* numbers = new int[5];
    // Use a variable to track the entry point
    // Initialising it to zero
    int entries = 0;
    int capacity = 5;
    
    // Constantly ask users to enter a number
    // Store it to our array
    while(true){
        cout << "Number: ";
        cin >> numbers[entries];
        // check whether it is a valid number or not
        // if cin.fail() returns True means
        // users enter something can't be converted to a number
        // we're gonna break out of this loop
        if(cin.fail()){
            break;
        }
        // otherwise we're going to increase entries by 1
        entries++;
        // Resize the array when it is full
        if(entries == capacity){
            // Create a temp array (twice the size)
            // Copy all the elements
            // Have "numbers" pointer point to the new array
            cout << "The arraySize = " << entries << "We are gonna resize it."<< endl;
            capacity *= 2;
            int* temp = new int[capacity];
            for(int i = 0; i < entries; i++){
                temp[i] = numbers[i];
            }
            delete[] numbers;
            // int* numbers = &(temp[0]);
            // Wrong code is above
            numbers = temp;
        }
    }

    // loop to print user-entered numbers so far
    for (int i = 0; i < entries; i++){
        cout << numbers[i] << endl;
    }
    
    
    delete[] numbers;
    

    return 0; 
}
```

That is standard implementation of it in C++ called vector. See it later.

### **Smart Pointers**

In modern C++ we have a new concept called smart pointer which free us from having to deleting these pointers. We can work with them just like regular variables that we declare on the stack

* Unique pointers
* Shared pointers

### **Working with Unique Pointers**

We can not have 2 unique pointers point to the same piece of memory location

```cpp
#include <iostream>
#include <memory>

using namespace std;

int main(){
  unique_ptr<int> jptr(new int);
  
  // we gonna see a memory address
  cout << jptr << endl;
  
  // De-referencing it and do arithmetic operation
  *jptr = 10;
  cout << *jptr << endl;
  
  // Generic function with different datatype return instance of unique pointer class
  unique_ptr<int> lptr = make_unique<int>();
  // Equivalent to above
  auto lptr = make_unique<int>();
  
	return 0;
}
```

* `unique_ptr` is a class, right after the classname we use the angle brackets, inside of the brackets we are specified the type of pointer we want to create, then give it a variable name like `jptr` then followed by a pair of parenthesises.
* In the parenthesises pair, we use `new` operator to creat an integer pointer, which passing it to `jptr`
* `jptr` is called object
* an object is an instance of class
* We can not do pointer arithmetic operation to `jptr`
* There is a generic function that can create a unique pointer instance called `make_unique<datatype>()`

### **Working with Shared Pointers**

```cpp
#include <iostream>
#include <memory>

using namespace std;

int main(){
  shared_ptr<int> x(new int);
  shared_ptr<int> duplicateX = make_shared<int>();
  auto z = make_shared<int>();
  
  *x = 10;
  
  // Initialising y using x
  shared_ptr<int> y(x);
  if(x == y){
    cout << "Equal"; 
  }
  
	return 0;
}
```

## String

### **C Strings v.s. C++ Strings**

string typr is not part of C++ language itself, it's part of the standard library 

* legacy C plus plus code, C string is char array, so all the issues array have have the possibility of occurring 
* The last character of C style strings is always '\0' - Null Terminator
* C++ string type optimises memory usage dynamically
* we can access individual characters by index cuz we are working with array
* single character enclosed by single quotes is so-called "character literal"
* We can not combine two c-style string by `+` operator like we do with C++ string objects 
* We can not compare c-style string by `==`  operator
* We can not copy c-style string by `=` assignment 
* The comparison of two strings in C is indeed determined by the first differing character when using the `strcmp` function. The `strcmp` function compares the strings character by character, starting from the first character of each string. It continues comparing subsequent characters until it finds a pair of characters that differ or until it reaches the null terminator (`'\0'`) of both strings.

Two ways to initialise a C style string

```cpp
// Use curely braces and type a bunch of characters
// Last character should always be back slashs zero 
char name[5] = {'J','a','z','z','\0'};

// Use string literal to initialise
// String literal is a sequence of characters enclosed with double quotes
// In this case, null terminator was automaticallly added by default 
char name[5] = "Jazz";

// C style way to get string size
#include <cstring>
int string_size = strlen(name);
// It is gonna return 4, cuz the function will count until it faces the null terminator

char greet[] = "WYD";
// cat is short for Concatenate(combine)
// Both two parameters for it are char pointers
// The second one is constant char pointer
// So nothing is gonna be modified 
// The function take second argument and added it to the first argument
strcat(name,greet);
cout << name;
// It should be "JazzWYD"
// After combination the array size is go beyond defined size 
// In order to avoid nasty bugs in more complicated situation
// We should give this array more capacity 
// Let us say char name[50]

// Copy one string to another
// Taking  the second argument and copy it to first argument
// name is overwritten by greet
strcpy(name, greet);
cout << name;
// It should be "WYD"
// But if the first argument is not large enough 
// To contain the second argunment 
// We are gonna go exceed the boundary of array
// Run into a part of memory that we are not supposed to  

// Both of the parameters are const char pointer
// return 0 when equal
// if the first one comes before second one alphabetically, it returns negative value
// if the first one comes after second one alphabetically, it returns positive value
if (strcmp(name,greet) == 0){
  cout << "Equal" << endl;
}
 
```

C++ string

* It is a class, internally it uesed C style string to implement. Instances of this class, we call it string objects
* Each of the obeject got lots of functions we can access by `.` Operator 
* Instead of `strcat()`, we can use `+` operator
* Instead of `strcpy()`, we can declare another string object , and simplty set it to another string  
* Instead of `strcmp()`, we can simply use `==` operator to compare two string 
* `string.starts_with()` can check if the string starts with string or character, return `0` which means false, return `1` which means true; Same with `ends_with() `
* `string.empty()` to check if it is an empty string 
* `string.front()` to return the first character of string; similar function we call it back `string.back()` to return the last character of string 

```cpp
#include <iostream>
#include <string>

using namespace std;
int main(){
    string name = "Orchid";
    name[0] = 'o';
    cout << name.length();
    // It should be 6
    
    name += "Walking Artist";
  
    string another = name;
  
    if(name == another){
        cout << "Same";
    }
    
    // Equivalent ways to get last char from string
    char last_char = name[name.length()-1];
    char last_char = name.back();
  
    return 0;
}
```

### **Modifying Strings**

* `string.append("string literal")` to add another string into the end of `string`
*  `string.insert( 0 , "string literal")` to insert string to the accurate part of another string , `0` is an example index
* `string.erase(0,2)`, method for erasing characters from string, exam ple shown formerly means that erasing `2`characters starts from index`0`
* `string.clear()` function to set our string to an empty string
* `string.replace(0,2,"MO")` replacing 2 characters from index `0`, wih string literal `‘M’` and `'O'`

### **Searching Strings**

* `string.find()` with this function we can find the position of  first ocurrence of some content in this string
*  Just like all string operation, `string.find()` is case-sensitive.
*  If this methor can't find the position, it will return the largest value we can store in `size_t` type cuz `size_t` couldn't store negative values, actually it is `-1`, compare the failure result of `string.find()` with `-1`, we will get `==` true 
* `string.rf()`, rf is short for reverse_find , it starts search from the end 
* `string.find_first_of("string") ` we can check any of characters in passed string (we passed to the function) position in searched string, examples below 

```cpp
string name = "Kristiannea";
name.find('a');
// We are going to see 6
name.find('a',7);
// Pass one extra argument as searching start position
// Our searching is going to start at position 7
// This is gonna return next 'a' position as  10 

name.rf('a');
// We get 10
name.find_first_of("azw");
// it will return 6, it returns the first occurence position of char in passed string
name.find_last_of("azw");
// same as find_first_of function, but search starts from last element
name.find_first_not_of("azw");
// Return the first char in searched string that not any of char in given&passed string
// In our case, it is 'K'.
// Return 0
name.find_last_not_of("azw");
// return the last element not any of "azw"
// in this case 
// return 9, which is 'e '
 
```

### **Extracting substrings**

* `string.substr()` has two parameters: both of them are `size_t` numbers, first one is starting position, second one is the length of substring, but both of them are optional
*  if we call this `string.substr()` without any arguments, we get a full copy of this string
* if only one number is given as arguments like `string.substr(5)`, it will comprehended as starting postion, then return the rest of string from index  `5`

### **Working with Characters**

* `islower()` can check a character lower or not 

  ```cpp
  string name = "Ricardo";
  cout << islower(name[0]) << endl;
  // output with 0 cuz 'R' is capitalised 
  cout << isupper(name[0]) << endl;
  // output with 1 cuz 'R' is capitalised
  ```

* `isupper()`  check a character upper or not

* `isalpha()` returns True if this character is alphabetic from a to z no matter captilised or lower-cased 

* `isdigit()`  returns True if we pass digit character to it

* `isspace()` chck a character whitespace or not 

* `toupper()` convert lower case character into uppercase ones

* `tolower()` convert upper case character into lowercase ones

* if we give `tolower()` a character non-alphabetic like a dash `-`, it returns the character itself `-`

  ```cpp
  string name = "Ricardo";
  cout << (char) tolower(name[0]) << endl;
  // C style cast
  // Without casting we will get ascii value of 'r'
  ```

* Please test each edge case and consider each senario

### **Converting Strings to Numbers and Vice Versa**

* User input is always string
* `stod()` string to double
* `stoi()` string to integer
* `stof()` string to float
* `stol()` string to long 

```cpp
// The function always does its best to convert string to numbers
string price = "19.99x";
stod(price);
// We will get 19.99
string price = "19.x99";
stod(price);
// We will get 19
string price = "x19.99";
stod(price);
// Program will crashed due to exceptionm
```

* `to_string()` function is overloaded, so it takes int, long, double ...

### **Escape Sequences**

* Back slash has a special meaning in string 
* Type two back slash `\\` in order to represent a single `\` in string, it is an escape sequence 
* `\"` double quotation 
* Type a back slash to escape the following character 
* `\n` a newline, `\t` a tab, there is no limitation of how much `\n` or`\t` we can use in a string

```cpp
string greet = ""Hello World"";
// Compilation error
// The second double quote does not be identified as character
```

`""` be taken as the string literal, and the rest - `Hello World""`, is taken as garbage value

### **Raw Strings**

We can use raw string to raise code readability instead of escaping sequences, we just need type a `R` followed by a pair of parentheses wrapped by double quote `R"()"`, inside the parentheses, we can put raw string without the need of escaping any characters

```cpp
// Equivalent code
string path = "\"C:\\Users\\Administrator\\Desktop\"";
string path = R"(C:\Users\Administrator\Desktop)";
```

What we see in the parentheses is exactly what we are gonna show to the user, code is readable, cleaner and easier to understand.

### **Defining Structures**

* With structures we can define custom date type, in Computer Science we call it ADT - Abstract Data Type
* Abstraction - which is A general model of something

```cpp
// PascalCase Naming Convention to name a struct
// Capitalise every word
struct Movie{
    string name;
    int releaseYear;
};
// with this defination we are not  allocating any memory for these variable 
// We are simply telling compiler that Movie structure consists of 
// These variables

int main(){
    // We declare a object
    // Object means an instance of a type 
    Movie movie;
    // access member of object by dot operator
    movie.name = "Harry Potter"; 
  
    return 0;
}
```

 

## My Practice Feedback

### Garbage Value in Uninitialised Array & Misunderstanding of CPP auto-dealing

```cpp
#include <iostream> 
using namespace std;

int main(){
		int arrays[5]; 

		cout << "That's element with index 2 in the arrays that only specified elements amount" << arrays[2] <<endl; 

		return 0;
} 
```

Result 

```bash
 ./ArrayInitialising 

That's element with index 2 in the arrays that only specified elements amount1 
```

Why ?????? I thought it would be zero by auto assignment after declaration. 

In C++, when we declare an array (or any variable) without explicitly initializing it, the elements of the array will contain **garbage values**—essentially whatever data happened to be in that memory location previously. This is why I was seeing 1 (or some other seemingly random value) instead of 0. **I have misunderstanding that C plus plus will automatically assign 0 to array elements when it was declared without explicit assignment. But only BRACE INITICIALISER could do that.** 

local variables (including arrays) declared inside a function (like `main`) are **not automatically initialized to zero**. This is different from global or static variables, which are automatically initialized to zero. **Brace initialiser is different from the normal declaration.**

There is 3 ways to fix grabage value issues

* Use Empty Brace Initialiser

 `int array[5] = {}` , value 0 will be assigned to all elements automactically.

* Global Array & Static Array

Put array outside of any function -> Global Array;

Use keyword `static` before declaration statement like `static int arrays[5]` ->Static Array

Both of the methods above initialise all elements of array into zero value.

* Partial initialization by brace initialiser

`int arrays[5] = {10,20}` <- first two elements were explicitly assigned;

Or `int arrays[5] = {[1]=10,[2]=40}` <- second and third elements were explicitly assigned;

Both of methods above will automatically assign 0 to the rest elements of array.  

### How to Use For Loop in CPP

```cpp
for (initialization; condition; update) {

  // Code to execute

}
```

Syntax is shown above,

**Note: Semicolon `;` between *initialization*, *condition* and *update***

#### CPP style for loop

C++11 introduced a **range-based `for` loop**, which simplifies iterating over containers like arrays, vectors, etc.:

```cpp
#include <iostream>
using namespace std;

int main() {
    int numbers[] = {10, 20, 30, 40, 50};

    for (int num : numbers) {
        cout << num << endl;
    }

    return 0;
}
```

**Output:**

```bash
10
20
30
40
50
```

#### `Skip` and `continue` in for loop

use `continue` to skip the current iteration and `break` to exit the loop entirely:

#### Infinite For Loop

an infinite loop by omitting the condition:

```cpp
#include <iostream>
using namespace std;

int main() {
    for (;;) {
        cout << "This will run forever!" << endl;
    }
    return 0;
}
```

**Note:** Use `Ctrl+C` to stop an infinite loop in the terminal. (On macOS  it shall be `Command + C`)

#### `using namespace` rather than `use namespace`

Always remember, it shall be `using namespace std` ...  

### What is `boolalpha`

`std::boolalpha` is a **stream manipulator** in C++ that modifies how boolean values (`true` and `false`) are displayed in output streams (like `std::cout`). By default, boolean values are printed as `1`(for `true`) and `0` (for `false`). When you use `std::boolalpha`, boolean values are printed as the strings `"true"` and `"false"` instead.

```cpp
cout << true;  // Output: 1
cout << false; // Output: 0
cout << boolalpha << true;  // Output: true
cout << boolalpha << false; // Output: false
```

### What is `numeric_limits`

In C++, `numeric_limits` is a **class template** defined in the `<limits>` header. It provides information about the properties of arithmetic types (like `int`, `float`, `double`, etc.).

```cpp
// Examples for using numeric limits
#include <iostream>
#include <limits>
using namespace std;

int main() {
    cout << "Maximum value of int: " << numeric_limits<int>::max() << endl;
    cout << "Minimum value of int: " << numeric_limits<int>::min() << endl;
    cout << "Is float signed: " << numeric_limits<float>::is_signed << endl;
    cout << "Infinity for double: " << numeric_limits<double>::infinity() << endl;
    return 0;
}
```

What’s happening here:

- `max()`, `min()`, and `infinity()` are **static member functions**.

- `is_signed` is a **static constant**.

- There is more different static constant and static member functions:

  Key static member functions:

  - `max()` — Returns the maximum representable value.
  - `min()` — Returns the minimum *positive* value (for floating-point types) or the smallest value (for integers).
  - `lowest()` — Returns the lowest value the type can hold (useful for floating-point types, where `min()` isn’t the most negative value).
  - `epsilon()` — For floating-point types, it returns the difference between 1 and the next representable value.
  - `round_error()` — Returns the maximum rounding error for floating-point types.
  - `infinity()` — Returns the representation of positive infinity (for floating points).
  - `quiet_NaN()` — Returns a quiet NaN ("Not a Number") for floating points.
  - `signaling_NaN()` — Returns a signaling NaN, which can raise an exception when used.
  - `denorm_min()` — Returns the smallest positive *denormalized* value for floating points.

  Key static constants (all `constexpr`):

  - `is_signed` — `true` if the type can hold negative values, otherwise `false`.
  - `is_integer` — `true` for integer types, otherwise `false`.
  - `is_exact` — `true` if the type uses exact representations (like integers).
  - `has_infinity` — `true` if the type can represent infinity.
  - `has_quiet_NaN` — `true` if the type can represent quiet NaNs.
  - `has_signaling_NaN` — `true` if the type supports signaling NaNs.
  - `is_bounded` — `true` if the type has a finite range.
  - `is_modulo` — `true` if the type wraps around on overflow (like unsigned integers).
  - `digits` — The number of *base-2* digits the type can store.
  - `digits10` — The number of *base-10* digits that can be safely represented without change.
  - `max_digits10` — For floating-point types, the number of decimal digits needed to uniquely represent all distinct values.
  - `radix` — The base of the representation (typically 2 for binary types).
  - `min_exponent` — The smallest exponent for normalized floating-point numbers.
  - `max_exponent` — The largest exponent for floating points.
  - `min_exponent10` — The smallest power of 10 for normalized floating points.
  - `max_exponent10` — The largest power of 10 for normalized floating points.
  - `has_denorm` — Indicates whether the type supports *denormalized numbers*.
  - `has_denorm_loss` — Indicates if a loss of precision occurs when converting to a denormalized value.
  - `traps` — `true` if arithmetic operations can trigger exceptions.
  - `tinyness_before` — For floating points, checks if *underflow* is detected before rounding.
  - `round_style` — An enum indicating the rounding style (like nearest, towards zero, etc.).b

So, to clarify:

- **It is not a function.**
- **It is a class template.**
- **It is not an object** — I did’t create instances of it; I just use its static members directly.

### String Pre-learning 
* **What is buffer ->** A **sequential section of memory allocated to contain data**, such as a character string or an array of integers. It is essentially **an temporary storage area** for **data that is being processed or transferred.**

* **What is buffer overflow ->** When a program writes more data to a buffer that it can hold. This excess data overflows into adjacent memory, potentially corrupting other variables or program structures. 

* **Who fixed or regulated the size of buffer ->** In C, the size of a buffer is determined by the programmer at the time of allocation. We mujst decide how much memory to allocate for the buffer based on the expected size of the date it will hold. This decision directly affects the buffer's capacity.
  
  ```C
  #include <stdio.h>
  
  int main() {
      // Decision point: How much memory to allocate for the user's name?
      char name[50]; // Buffer size of 50 characters
  
      printf("Enter your name: ");
      scanf("%49s", name); // Read up to 49 characters to leave space for the null terminator
      printf("Hello, %s!\n", name);
  
      return 0;
  }
  ```
  * **Buffer:** name is the buffer here, which is an array of characters.
  * **Size**: The size of the buffer is 50 characters (char name[50];).
  * **Decision**: The programmer decides to allocate 50 characters for the buffer based on the expected length of the user's name. This decision is critical because it determines how much data the buffer can safely hold.
  
* **Why C Strings are prone to buffer overflows ->** C strings are arrays of characters terminated by a null character (`'\0'`). When working with C strings, we often need to manually manage memory and ensure that data does not exceed the allocated buffer size. This manual management can lead to errors, such as buffer overflows, if not handled carefully

* C strings are arrays of characters terminated by a null character (`'\0'`). 

  ```c
  // String literal - a sequence of characters enclosed in double quotes 
  // Use String Literral to declare and initialise a character array to create a string
  // When we declare it
  // Compiler conuts the characters in the string literal
  // including the null terminator
  // And allocates an array of that size
  // Stored as: 'A','l','i','c','e','/0'
  char greeting[] = "Alice";
  
  // In that case we specify the size of the array explicitly
  // The string "Hello World!" will be copied into this array, and the remaining characters will be initialised to zero("\0");
  // Static allocation, stored on stack
  char explicitstring[20] = "Hello World!"; 
  
  // Careful
  // Dynamic allocation
  // On read-only memory, immutable
  char* string_literal = "YOLO";
  ```
  ​	**Dynamic Allocation**: `char* string_literal = "YOLO";` declares a pointer to a string literal. The string literal is stored in read-only memory, and `name` points to it.

* Ways of C++ String creation

  ```cpp
  #include <iostream>
  #include <string>
  
  using namespace std;
  
  int main(){
  	string greeting = "Hello World!";
  	cout << greeting << endl;
  	return 0;
  }
  ```
  without `using namespace std;`	
  ```cpp
  #include <iostream>
  #include <string>
  
  int main(){
    std::string greeting = "Hello World";
    std::cout << greeting << std:endl;
    return 0;
  }
  ```

* ## **Key Differences Between C and C++ `getline()`**

  | Feature         | C                                          | **C++**                          |
  | :-------------- | :----------------------------------------- | :------------------------------- |
  | **Header**      | `<stdio.h>`                                | `<iostream>` + `<string>`        |
  | **Memory**      | Manual (`malloc`/`free`)                   | Automatic (`std::string`)        |
  | **Buffer**      | Requires `char**` + `size_t*`              | Uses `std::string`               |
  | **Safety**      | Risk of leaks if not freed                 | No leaks (RAII)                  |
  | **Delimiter**   | Always `\n` (hardcoded)                    | Customizable (`'\n'` by default) |
  | **Return**      | `ssize_t` (bytes read or `-1`)             | Returns stream reference         |
  | **Portability** | POSIX (Linux/macOS), not always in Windows | Standard C++ (works everywhere)  |

  C-style `getline()` example
  ```c
  #include <stdio.h>
  #include <stdlib.h>  // For free()
  
  int main() {
      char *line = NULL;
      size_t len = 0;
      ssize_t read;
  
      printf("Enter a line: ");
      read = getline(&line, &len, stdin);  // Reads from stdin
  
      if (read != -1) {
          printf("You entered: %s", line);
      }
  
      free(line);  // Must free allocated memory!
      return 0;
  }
  ```

  C++ rules of using `getline()`
  ```cpp
  #include <iostream>
  #include <string>
  
  int main() {
      std::string line;
  
      std::cout << "Enter a line: ";
      std::getline(std::cin, line);  // Reads until '\n'
  
      std::cout << "You entered: " << line << std::endl;
      return 0;
  }
  ```