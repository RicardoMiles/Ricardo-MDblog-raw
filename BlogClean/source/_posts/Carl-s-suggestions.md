---
title: Carl's Suggestion on LeetCode Practice
date: 2025-02-22 02:41:04
tags:
 - CS Learning
 - CPP
 - LeetCode
 - Data-Struct
 - Algorithm
categories:
 - Coding
excerpt: "LeetCode刷题中的注意事项，代码随想录 - 程序员卡尔的建议。"
---

## 究竟什么时候用库函数，什么时候要自己实现

例如：[字符串：151. 翻转字符串里的单词](https://leetcode.com/problems/reverse-words-in-a-string/description/)这道题目本身是综合考察同学们对字符串的处理能力，如果 split + reverse的话，那就失去了题目的意义了。

提供一个标准来判断平时算法题是否用库函数

**如果题目关键的部分直接用库函数就可以解决，建议不要使用库函数**。

**如果库函数仅仅是 解题过程中的一小部分，并且你已经很清楚这个库函数的内部实现原理的话，那么直接用库函数。**

使用库函数最大的忌讳就是不知道这个库函数怎么实现的，也不知道其时间复杂度，上来就用，这样写出来的算法，时间复杂度自己都掌握不好的。

例如for循环里套一个字符串的insert，erase之类的操作，你说时间复杂度是多少呢，很明显是O(n^2)的时间复杂度了。

## 本地编译运行LeetCode代码

在力扣上直接打日志，这个就不用讲，C++的话想打啥直接cout啥就可以了。

我来说一说LeetCode代码如何在本地运行。

毕竟我们天天用LeetCode刷题，也应该知道力扣上的代码如何在本地编译运行。

其实挺简单的，大家看一遍就会了。

我拿我们刚讲过的这道题[动态规划：使用最小花费爬楼梯](https://leetcode.com/problems/min-cost-climbing-stairs/description/)来做示范。

力扣746. 使用最小花费爬楼梯，完整的可以在直接本地运行的C++代码如下：

```cpp
#include <iostream>
#include <vector>
using namespace std;

class Solution {
public:
    int minCostClimbingStairs(vector<int>& cost) {
        vector<int> dp(cost.size());
        dp[0] = cost[0];
        dp[1] = cost[1];
        for (int i = 2; i < cost.size(); i++) {
            dp[i] = min(dp[i - 1], dp[i - 2]) + cost[i];
        }
        return min(dp[cost.size() - 1], dp[cost.size() - 2]);
    }
};

int main() {
    int a[] = {1, 100, 1, 1, 1, 100, 1, 1, 100, 1};
    vector<int> cost(a, a + sizeof(a) / sizeof(int));
    Solution solution;
    cout << solution.minCostClimbingStairs(cost) << endl;
}
```

代码中可以看出，其实就是定义个main函数，构造个输入用例，然后定义一个solution变量，调用minCostClimbingStairs函数就可以了。

此时大家就可以随意构造测试数据，然后想怎么打日志就怎么打日志，没有找不出的bug。

## 引注声明

**本文完全摘自[程序员Carl ](https://github.com/youngyangyang04)的原创——代码随想录。仅作部分删节，用以个人练习中复习留档。**
