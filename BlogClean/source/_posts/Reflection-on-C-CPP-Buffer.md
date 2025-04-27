---
title: Reflection on C&C++ Buffer
date: 2025-04-05 22:23:49
tags:
 - CS Learning
 - CPP
 - Vocabulary
 - English Learning
 - SLA
categories:
 - Coding
excerpt: "Understanding C++ Output Buffers: The Performance Impact of `std::endl` vs. `\n`, this post comes from the confusion I had trying to follow Mosh’s C++ tutorial."

---

Regarding what Mosh mentioned in Part 2 of the course
>Use `\n` instead of `<< endl` for performance reason. What happened under the hood is : When we write something to the  output stream, the date is not directly written to the output stream, data get stored in a buffer. And then at some point the buffer is get flushed, and the content is get written to the output stream. The difference between `\n` and `endl` is `endl` always flushes the buffer.

I can't understand why, and I also don't know what the action of flushing means in C++.

I also have a doubt: When using `\n`, the data remains in the buffer until the buffer is full or the program ends. So, if the data is still in the buffer, won't the next line of read/write operations cause duplicate data to be written?

## The Role of Output Buffers

When we write data to an output stream (such as `std::cout`), the data doesn’t go directly to the target output (like the screen or a file). Instead, it gets temporarily stored in a buffer. The primary purpose of a buffer is to enhance output efficiency and reduce the number of system calls. Specifically:

- **Reducing System Calls**: Each time we write to an output stream, the program has to make a system call, which is relatively expensive in terms of performance. By using a buffer, data can be temporarily stored and written to the output stream in bulk when the buffer is full or when explicitly requested.
- **Improving Efficiency**: Buffers allow for batch processing of data, reducing the number of actual output operations, thereby improving the overall performance of the program.

### SLA Part

* In bulk - dealing with a large amount of something all at once

## The Difference Between `std::endl` and `\n`

Although both `std::endl` and `\n` are used for line breaks, they behave differently, especially in terms of buffer handling.

### `std::endl`

`std::endl` is a manipulator that does two things: 

* it inserts a newline character into the output stream 
* and forces the buffer to flush. 

This means that every time we use `std::endl`, the data in the buffer is immediately written to the target output stream, and the buffer is cleared. For example:

```cpp
std::cout << "Hello" << std::endl;
std::cout << "World" << std::endl;
```

- `"Hello"` is written to the buffer.
- `std::endl` forces the buffer to flush, writing `"Hello"` to the output stream and clearing the buffer.
- `"World"` is written to the buffer.
- `std::endl` again forces the buffer to flush, writing `"World"` to the output stream and clearing the buffer.

### `\n`

`\n` is a simple newline character that only inserts a line break into the output stream without affecting the buffer. Data remains in the buffer until the buffer is full or the program explicitly requests a flush. For example:

```cpp
std::cout << "Hello\n";
std::cout << "World\n";
```

- `"Hello\n"` is written to the buffer.
- `"World\n"` is written to the buffer.
- When the buffer is full or the program ends, the contents of the buffer (`"Hello\nWorld\n"`) are written to the output stream all at once, and the buffer is cleared.

## Why `\n` is More Efficient

The primary reason to prefer `\n` over `std::endl` is to minimize unnecessary buffer flushes. Each buffer flush involves a system call, which is computationally expensive. Frequent use of `std::endl` can lead to many buffer flushes, increasing the number of system calls and degrading performance.

In contrast, using `\n` allows data to remain in the buffer until it is full or the program ends. This leverages the buffer’s ability to batch process data, reducing the number of actual output operations and improving performance.

## Misconceptions at First

When discussing the differences between `std::endl` and `\n`,  I worry that using `\n` could lead to data duplication or confusion. However, this concern is unfounded. The buffer is cleared after each flush, and new data is written to the buffer without mixing with previous data. For example:

```cpp
std::cout << "Hello\n";
std::cout << "World\n";
```

- `"Hello\n"` is written to the buffer.
- `"World\n"` is written to the buffer.
- When the buffer is full or the program ends, the contents (`"Hello\nWorld\n"`) are written to the output stream all at once, and the buffer is cleared.

Data is written to the output stream in the order it was written to the buffer, ensuring no duplication or confusion.

## Conclusion

In C++, the choice of output method can significantly impact our program’s performance. While both `std::endl` and `\n` can be used for line breaks, they behave differently. `std::endl` forces a buffer flush, while `\n` does not. In most cases, using `\n` is more efficient because it leverages the buffer’s batching capabilities, reducing the number of system calls.

Of course, if we need to ensure that certain data is immediately output (for example, for debugging purposes), using `std::endl` or `std::flush` is appropriate. However, in other scenarios, `\n` is the recommended choice for better performance.
