###  Creating and intialising arrays

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

### Determine the Size of Array

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

   

  


### Copying Arrays

* In C++ we can not assign one array to another one , if we wanna copy an array, we should copy elements one by one, it was always done by traditional for loop because element should be put in the same index (position) of those two arrays. 

### Comparing Arrays

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

### Passing Arrays to Functions

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

### Understanding `size_t` 

Size_t is a data type defined in C plus plus standard library , "t" here is a short for type, when we use `sizeof()` operator , cpp will automatically returns a data structure called `size_t `

* int hold 4 Bytes,long long holes 8 Byte
* Size_t holds 8 Bytes, it can only hold positive number size_t is the same is unsigned longlong, sometimes due to different compiler,  size_t is just equivalenet of unsigned int.
* Long long take 8 Bytes of memory
* numeric_limits class is defined in a standard library

### Unpacking Arrays

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

### Searching Arrays

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

###  Sequenise the Array

### Multiple Dimensions Array



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

#### Use Empty Brace Initialiser

 `int array[5] = {}` , value 0 will be assigned to all elements automactically.

#### Global Array & Static Array

Put array outside of any function -> Global Array;

Use keyword `static` before declaration statement like `static int arrays[5]` ->Static Array

Both of the methods above initialise all elements of array into zero value.

#### Partial initialization by brace initialiser

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

**Class template** means it’s a class that takes a type as a parameter, like this:

```cpp
template <typename T> class numeric_limits;
```

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

- There is more different static constant member functions and static member functions:

- works with angle brackets

  #### Key static member functions:

  - **`max()`** — Returns the maximum representable value.
  - **`min()`** — Returns the minimum *positive* value (for floating-point types) or the smallest value (for integers).
  - **`lowest()`** — Returns the lowest value the type can hold (useful for floating-point types, where `min()` isn’t the most negative value).
  - **`epsilon()`** — For floating-point types, it returns the difference between 1 and the next representable value.
  - **`round_error()`** — Returns the maximum rounding error for floating-point types.
  - **`infinity()`** — Returns the representation of positive infinity (for floating points).
  - **`quiet_NaN()`** — Returns a quiet NaN ("Not a Number") for floating points.
  - **`signaling_NaN()`** — Returns a signaling NaN, which can raise an exception when used.
  - **`denorm_min()`** — Returns the smallest positive *denormalized* value for floating points.

  #### Key static constants (all `constexpr`):

  - **`is_signed`** — `true` if the type can hold negative values, otherwise `false`.
  - **`is_integer`** — `true` for integer types, otherwise `false`.
  - **`is_exact`** — `true` if the type uses exact representations (like integers).
  - **`has_infinity`** — `true` if the type can represent infinity.
  - **`has_quiet_NaN`** — `true` if the type can represent quiet NaNs.
  - **`has_signaling_NaN`** — `true` if the type supports signaling NaNs.
  - **`is_bounded`** — `true` if the type has a finite range.
  - **`is_modulo`** — `true` if the type wraps around on overflow (like unsigned integers).
  - **`digits`** — The number of *base-2* digits the type can store.
  - **`digits10`** — The number of *base-10* digits that can be safely represented without change.
  - **`max_digits10`** — For floating-point types, the number of decimal digits needed to uniquely represent all distinct values.
  - **`radix`** — The base of the representation (typically 2 for binary types).
  - **`min_exponent`** — The smallest exponent for normalized floating-point numbers.
  - **`max_exponent`** — The largest exponent for floating points.
  - **`min_exponent10`** — The smallest power of 10 for normalized floating points.
  - **`max_exponent10`** — The largest power of 10 for normalized floating points.
  - **`has_denorm`** — Indicates whether the type supports *denormalized numbers*.
  - **`has_denorm_loss`** — Indicates if a loss of precision occurs when converting to a denormalized value.
  - **`traps`** — `true` if arithmetic operations can trigger exceptions.
  - **`tinyness_before`** — For floating points, checks if *underflow* is detected before rounding.
  - **`round_style`** — An enum indicating the rounding style (like nearest, towards zero, etc.).b

So, to clarify:

- **It is not a function.**
- **It is a class template.**
- **It is not an object** — you don’t create instances of it; you just use its static members directly.





### Class Template

**Class template** means it’s a class that takes a type as a parameter, like this:

```cpp
template <typename T> class numeric_limits;
```

```cpp

```
