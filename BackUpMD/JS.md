[TOC]



# JS

## Hoisting

Hoisting（变量提升）：

- 左边显示为undefined，右边显示为not defined。
- 让我们记住执行上下文。
- 上下文包含所有的变量和函数。
- 这就是所谓的变量提升。
- 对于var来说，这叫做声明提升。
- 对于函数来说，这叫做值提升。

这段内容解释了变量提升（hoisting）的概念。左边显示undefined，而右边显示not defined，这是因为在不同的情况下，JavaScript会有不同的行为。当我们讨论执行上下文时，指的是当前JavaScript代码正在执行的环境，其中包含了所有的变量和函数。

在JavaScript中，变量提升意味着在代码执行之前，变量和函数的声明会被提升到当前作用域的顶部。对于使用var声明的变量，这种提升被称为声明提升（declaration hoisting）。而对于函数，其声明和定义会一起被提升，这种情况下称为值提升（value hoisting）。

这段内容的目的是说明在JavaScript中变量提升的概念，以及它对代码执行的影响。

## Scope

作用域（Scope）：

- JavaScript中的作用域是词法（lexical）的。
- 这意味着变量的创建位置及其父级作用域会影响作用域的范围，但不包括其子级作用域。
- 在我们的例子中，
  - `First()` 函数可以访问全局执行上下文。
  - `First()` 函数无法访问其子函数 `Second()` 的执行上下文。
  - 因此，我们在右侧的图片中看到了错误。
- 当沿着作用域链向上移动到父级和祖父级时，这就定义了作用域链。

这段内容解释了JavaScript中作用域的概念。在JavaScript中，作用域决定了变量和函数的可访问性范围。词法作用域意味着作用域是由代码的结构在书写时确定的，而不是在运行时动态确定的。

在这个例子中，`First()` 函数可以访问其父级作用域（全局作用域），但无法访问其子级作用域（`Second()` 函数）。这就是为什么在右侧的图片中出现错误的原因。作用域链描述了作用域之间的关系，当查找变量或函数时，JavaScript引擎会沿着作用域链向上查找直到找到匹配的标识符。

![image-20240503133831718](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240503133831718.png)

## Call stack

![image-20240503134004561](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240503134004561.png)

调用堆栈（Call Stack）的概念。调用堆栈是一种数据结构，用于在程序运行时存储关于活动子程序的信息。这个结构特别关键，因为它帮助管理函数调用过程中的变量和执行上下文。

图中分为左右两部分：

1. **左侧部分**：
   - 展示了全局和局部作用域。全局作用域中的变量（如 `a`, `resultglobal`）在整个程序中都可以访问。而局部作用域中的变量（如 `num`, `resultlocal`）只能在特定的函数或代码块中访问。
   - 局部作用域是嵌套在全局作用域内的，表示局部变量在函数调用时创建，在函数执行完毕后销毁。
2. **右侧部分**：
   - 文字说明描述了调用堆栈的操作方式，即“压栈”和“弹栈”。这表示当一个新的函数被调用时，它的上下文（包括局部变量等）会被推入（压栈）到调用堆栈中。当函数执行完毕返回时，它的上下文会从堆栈中移除（弹栈）。
   - 右侧还简洁地说明了全局和局部作用域的区别。





## Array

这段代码涉及到了数组的概念，但它实际上并没有创建一个数组。相反，它创建了一个字符串，并尝试使用类似于数组的方式来访问字符串的特定字符。

```js
var name = "johndoe";
```

首先，代码创建了一个名为`name`的变量，并将其赋值为字符串`"johndoe"`。

```javascript

console.log(name.length); // 输出：7
```

`name.length`用于获取字符串的长度，即字符的数量，这里是7个字符。

```js

console.log(name[0]); // 输出：'j'
```

`name[0]`表示访问字符串`name`的第一个字符，索引从0开始。所以这里输出的是字符`'j'`。

```js

console.log(name[name.length]); // 输出：undefined
```

`name.length`返回的是字符串的长度，即7。但是字符串的索引是从0到6，所以`name[7]`处并没有字符，因此访问越界的索引会返回`undefined`。

```js

console.log(name[name.length-1]); // 输出：'e'
```

`name[name.length-1]`表示访问字符串`name`的最后一个字符，即倒数第一个字符。由于字符串的长度是7，所以最后一个字符的索引是6。因此这里输出的是字符`'e'`。



# asynchronous JavaScript

异步编程技术使你的程序可以在执行一个可能长期运行的任务的同时继续对其他事件做出反应而不必等待任务完成。与此同时，你的程序也将在任务完成后显示结果。

浏览器提供的许多功能（尤其是最有趣的那一部分）可能需要很长的时间来完成，因此需要异步完成，例如：

- 使用 [`fetch()`](https://developer.mozilla.org/zh-CN/docs/Web/API/fetch) 发起 HTTP 请求
- 使用 [`getUserMedia()`](https://developer.mozilla.org/zh-CN/docs/Web/API/MediaDevices/getUserMedia) 访问用户的摄像头和麦克风
- 使用 [`showOpenFilePicker()`](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/showOpenFilePicker) 请求用户选择文件以供访问

## 同步编程

观察下面的代码：

JSCopy to Clipboard

```javascript
const name = "Miriam";
const greeting = `Hello, my name is ${name}!`;
console.log(greeting);
// "Hello, my name is Miriam!"
```

这段代码：

1. 声明了一个叫做 `name` 的字符串常量
2. 声明了另一个叫做 `greeting` 的字符串常量（并使用了 `name` 常量的值）
3. 将 `greeting` 常量输出到 JavaScript 控制台中。

我们应该注意的是，实际上浏览器是按照我们书写代码的顺序一行一行地执行程序的。浏览器会等待代码的解析和工作，在上一行完成后才会执行下一行。这样做是很有必要的，因为每一行新的代码都是建立在前面代码的基础之上的。

这也使得它成为一个**同步程序**。

事实上，调用函数的时候也是同步的，就像这样：

JSCopy to Clipboard

```javascript
function makeGreeting(name) {
  return `Hello, my name is ${name}!`;
}
const name = "Miriam";
const greeting = makeGreeting(name);
console.log(greeting);
// "Hello, my name is Miriam!"
```

在这里 `makeGreeting()` 就是一个**同步函数**，因为在函数返回之前，调用者必须等待函数完成其工作。

基础知识：

- JavaScript采用同步执行。
- 它们按照代码顺序逐行执行。
- 在现实世界中，有时我们需要在执行某些操作之前等待一段时间。
- 这不应该阻止程序的其余部分继续执行。
- 因此，我们需要异步执行。因此，我们有回调函数和Promise。callback and promise



回调函数：

- 让一个函数负责调用另一个函数。
- 当你想在另一个函数或任务完成后调用一个函数或执行某些操作时，这非常有用。





## callback 地狱

回调地狱（Callback Hell）或金字塔地狱（Pyramid of Doom）是指在编写异步JavaScript代码时，多个嵌套的回调函数形成的深层次、难以阅读和维护的代码结构。

在JavaScript中，经常会出现需要串行或并行执行多个异步操作的情况，比如请求数据、读取文件、处理事件等。为了处理这些异步任务，通常会使用回调函数或Promise来处理任务的完成或失败状态。然而，如果这些异步操作嵌套过多，就会导致代码的可读性变差，形成回调地狱或金字塔地狱。

例如，一个回调函数中嵌套了另一个回调函数，而后者又嵌套了另一个回调函数，依次类推，形成了深层次的嵌套结构。这种结构不仅难以理解和调试，而且容易出现错误和难以维护。

为了避免回调地狱，可以使用一些方法来改善代码结构，比如使用Promise、async/await等异步处理方式，或者采用模块化的方式将代码分解成更小的、可重用的部分。这样可以使代码更易读、易维护，并且降低出错的可能性。

## promises

Promises（承诺）：

- Promises被用于处理异步操作。
- 异步操作意味着我们依赖于用户或其他任务的完成。
- 例如，如果用户正在浏览并选择要在您的网站上购买的物品。
- Promises可以处于等待（pending）、已实现（fulfilled）和已拒绝（rejected）状态。
- Promise对象是不可变的。

![image-20240503140630802](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240503140630802.png)

# 菜鸟js

# basic

JavaScript 用法

------

HTML 中的 Javascript 脚本代码必须位于 **<script>** 与 **</script>** 标签之间。

Javascript 脚本代码可被放置在 HTML 页面的 **<body>** 和 **<head>** 部分中。

<script> 标签

如需在 HTML 页面中插入 JavaScript，请使用 <script> 标签。

<script> 和 </script> 会告诉 JavaScript 在何处开始和结束。

<script> 和 </script> 之间的代码行包含了 JavaScript:

<script> alert("我的第一个 JavaScript"); </script>

您无需理解上面的代码。只需明白，浏览器会解释并执行位于 <script> 和 </script>之间的 JavaScript 代码 

| ![lamp](https://www.runoob.com/images/lamp.jpg) | 那些老旧的实例可能会在 <script> 标签中使用 type="text/javascript"。现在已经不必这样做了。JavaScript 是所有现代浏览器以及 HTML5 中的默认脚本语言。 |
| ----------------------------------------------- | ------------------------------------------------------------ |
|                                                 |                                                              |

<body> 中的 JavaScript

在本例中，JavaScript 会在页面加载时向 HTML 的 <body> 写文本：实例

<!DOCTYPE html> <html> <body> . . <script> document.write("<h1>这是一个标题</h1>"); document.write("<p>这是一个段落</p>"); </script> . . </body> </html>

[尝试一下 »](https://www.runoob.com/try/try.php?filename=tryjs_intro_document_write)

## JavaScript 函数和事件

上面例子中的 JavaScript 语句，会在页面加载时执行。

通常，我们需要在某个事件发生时执行代码，比如当用户点击按钮时。

如果我们把 JavaScript 代码放入函数中，就可以在事件发生时调用该函数。

您将在稍后的章节学到更多有关 JavaScript 函数和事件的知识。

在 <head> 或者 <body> 的JavaScript

您可以在 HTML 文档中放入不限数量的脚本。

脚本可位于 HTML 的 <body> 或 <head> 部分中，或者同时存在于两个部分中。

通常的做法是把函数放入 <head> 部分中，或者放在页面底部。这样就可以把它们安置到同一处位置，不会干扰页面的内容。

<head> 中的 JavaScript 函数

在本例中，我们把一个 JavaScript 函数放置到 HTML 页面的 <head> 部分。

该函数会在点击按钮时被调用：

## 外部的 JavaScript

也可以把脚本保存到外部文件中。外部文件通常包含被多个网页使用的代码。

外部 JavaScript 文件的文件扩展名是 .js。

如需使用外部文件，请在 <script> 标签的 "src" 属性中设置该 .js 文件：

## 语法

# JavaScript 语法

------

JavaScript 是一个程序语言。语法规则定义了语言结构。

------

## JavaScript 语法

JavaScript 是一个脚本语言。

它是一个轻量级，但功能强大的编程语言。

------

## JavaScript 字面量

在编程语言中，一般固定值称为字面量，如 3.14。

**数字（Number）字面量** 可以是整数或者是小数，或者是科学计数(e)。

3.14

1001

123e5

[尝试一下 »](https://www.runoob.com/try/try.php?filename=tryjs_syntax_numbers)

**字符串（String）字面量** 可以使用单引号或双引号:

"John Doe"

'John Doe'

[尝试一下 »](https://www.runoob.com/try/try.php?filename=tryjs_syntax_strings)

**表达式字面量** 用于计算：

5 + 6

5 * 10

[尝试一下 »](https://www.runoob.com/try/try.php?filename=tryjs_syntax_expressions)

**数组（Array）字面量** 定义一个数组：

[40, 100, 1, 5, 25, 10]

**对象（Object）字面量** 定义一个对象：

{firstName:"John", lastName:"Doe", age:50, eyeColor:"blue"}

**函数（Function）字面量** 定义一个函数：

function myFunction(a, b) { return a * b;}

------

## JavaScript 变量

在编程语言中，变量用于存储数据值。

JavaScript 使用关键字 **var** 来定义变量， 使用等号来为变量赋值：

var x, length

x = 5

length = 6

[尝试一下 »](https://www.runoob.com/try/try.php?filename=tryjs_syntax_variables)

变量可以通过变量名访问。在指令式语言中，变量通常是可变的。字面量是一个恒定的值。



| ![Note](https://www.runoob.com/images/lamp.jpg) | 变量是一个**名称**。字面量是一个**值**。 |
| ----------------------------------------------- | ---------------------------------------- |
|                                                 |                                          |

------

## JavaScript 操作符

JavaScript使用 **算术运算符** 来计算值:

(5 + 6) * 10

[尝试一下 »](https://www.runoob.com/try/try.php?filename=tryjs_syntax_operators)

JavaScript使用**赋值运算符**给变量赋值：

x = 5
y = 6
z = (x + y) * 10

[尝试一下 »](https://www.runoob.com/try/try.php?filename=tryjs_syntax_assign)

JavaScript语言有多种类型的运算符：

| 类型                   | 实例      | 描述                   |
| :--------------------- | :-------- | :--------------------- |
| 赋值，算术和位运算符   | = + - * / | 在 JS 运算符中描述     |
| 条件，比较及逻辑运算符 | == != < > | 在 JS 比较运算符中描述 |

------

## JavaScript 语句

在 HTML 中，JavaScript 语句用于向浏览器发出命令。

语句是用分号分隔：

x = 5 + 6;
y = x * 10;

------

## JavaScript 关键字

JavaScript 关键字用于标识要执行的操作。



和其他任何编程语言一样，JavaScript 保留了一些关键字为自己所用。

**var** 关键字告诉浏览器创建一个新的变量：



var x = 5 + 6;
var y = x * 10;

JavaScript 同样保留了一些关键字，这些关键字在当前的语言版本中并没有使用，但在以后 JavaScript 扩展中会用到。

以下是 JavaScript 中最重要的保留关键字（按字母顺序）：

| abstract | else       | instanceof | super        |
| -------- | ---------- | ---------- | ------------ |
|          |            |            |              |
| boolean  | enum       | int        | switch       |
|          |            |            |              |
| break    | export     | interface  | synchronized |
|          |            |            |              |
| byte     | extends    | let        | this         |
|          |            |            |              |
| case     | false      | long       | throw        |
|          |            |            |              |
| catch    | final      | native     | throws       |
|          |            |            |              |
| char     | finally    | new        | transient    |
|          |            |            |              |
| class    | float      | null       | true         |
|          |            |            |              |
| const    | for        | package    | try          |
|          |            |            |              |
| continue | function   | private    | typeof       |
|          |            |            |              |
| debugger | goto       | protected  | var          |
|          |            |            |              |
| default  | if         | public     | void         |
|          |            |            |              |
| delete   | implements | return     | volatile     |
|          |            |            |              |
| do       | import     | short      | while        |
|          |            |            |              |
| double   | in         | static     | with         |
|          |            |            |              |

------

## JavaScript 注释

不是所有的 JavaScript 语句都是"命令"。双斜杠 **//** 后的内容将会被浏览器忽略：

// 我不会执行

------

## JavaScript 数据类型

JavaScript 有多种数据类型：数字，字符串，数组，对象等等：

var length = 16;                  // Number 通过数字字面量赋值
var points = x * 10;               // Number 通过表达式字面量赋值
var lastName = "Johnson";             // String 通过字符串字面量赋值
var cars = ["Saab", "Volvo", "BMW"];       // Array 通过数组字面量赋值
var person = {firstName:"John", lastName:"Doe"}; // Object 通过对象字面量赋值

------

## 数据类型的概念

编程语言中，数据类型是一个非常重要的内容。

为了可以操作变量，了解数据类型的概念非常重要。

如果没有使用数据类型，以下实例将无法执行：

16 + "Volvo"

16 加上 "Volvo" 是如何计算呢? 以上会产生一个错误还是输出以下结果呢？

"16Volvo"

你可以在浏览器尝试执行以上代码查看效果。

在接下来的章节中你将学到更多关于数据类型的知识。

------

## JavaScript 函数

JavaScript 语句可以写在函数内，函数可以重复引用：

**引用一个函数** = 调用函数(执行函数内的语句)。

function myFunction(a, b) {
  return a * b;                // 返回 a 乘以 b 的结果
}

------

## JavaScript 字母大小写

JavaScript 对大小写是敏感的。

当编写 JavaScript 语句时，请留意是否关闭大小写切换键。

函数 **getElementById** 与 **getElementbyID** 是不同的。

同样，变量 **myVariable** 与 **MyVariable** 也是不同的。

------

## JavaScript 字符集

JavaScript 使用 Unicode 字符集。

Unicode 覆盖了所有的字符，包含标点等字符。

## 回调函数

回调函数就是一个函数，它是在我们启动一个异步任务的时候就告诉它：等你完成了这个任务之后要干什么。这样一来主线程几乎不用关心异步任务的状态了，他自己会善始善终。

## 实例

function print() {    document.getElementById("demo").innerHTML="RUNOOB!"; } setTimeout(print, 3000);

[尝试一下 »](https://www.runoob.com/try/try.php?filename=tryjs_async)

这段程序中的 setTimeout 就是一个消耗时间较长（3 秒）的过程，它的第一个参数是个回调函数，第二个参数是毫秒数，这个函数执行之后会产生一个子线程，子线程会等待 3 秒，然后执行回调函数 "print"，在命令行输出 "RUNOOB!"。

当然，JavaScript 语法十分友好，我们不必单独定义一个函数 print ，我们常常将上面的程序写成：

## 实例

setTimeout(function () {    document.getElementById("demo").innerHTML="RUNOOB!"; }, 3000);

[尝试一下 »](https://www.runoob.com/try/try.php?filename=tryjs_async2)

**注意：**既然 setTimeout 会在子线程中等待 3 秒，在 setTimeout 函数执行之后主线程并没有停止，所以：

## 实例

setTimeout(function () {    document.getElementById("demo1").innerHTML="RUNOOB-1!";  // 三秒后子线程执行 }, 3000); document.getElementById("demo2").innerHTML="RUNOOB-2!";      // 主线程先执行

[尝试一下 »](https://www.runoob.com/try/try.php?filename=tryjs_async3)

这段程序的执行结果是：

```
RUNOOB-1!    // 三秒后子线程执行
RUNOOB-2!    // 主线程先执行
```

------

## 异步 AJAX

除了 setTimeout 函数以外，异步回调广泛应用于 AJAX 编程。有关于 AJAX 详细请参见：https://www.runoob.com/ajax/ajax-tutorial.html

XMLHttpRequest 常常用于请求来自远程服务器上的 XML 或 JSON 数据。一个标准的 XMLHttpRequest 对象往往包含多个回调：

## 实例

var xhr = new XMLHttpRequest();  xhr.onload = function () {    // 输出接收到的文字数据    document.getElementById("demo").innerHTML=xhr.responseText; }  xhr.onerror = function () {    document.getElementById("demo").innerHTML="请求出错"; }  // 发送异步 GET 请求 xhr.open("GET", "https://www.runoob.com/try/ajax/ajax_info.txt", true); xhr.send();

[尝试一下 »](https://www.runoob.com/try/try.php?filename=tryjs_async4)

XMLHttpRequest 的 onload 和 onerror 属性都是函数，分别在它请求成功和请求失败时被调用。如果你使用完整的 jQuery 库，也可以更加优雅的使用异步 AJAX：

## 实例

$.get("https://www.runoob.com/try/ajax/demo_test.php",function(data,status){    alert("数据: " + data + "\n状态: " + status); });