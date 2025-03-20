---
title: Learn from CodeSignal
date: 2025-02-27 23:46:45
tags:
 - SLA
categories:
 - Interview Revision
excerpt: "Math revision from interview questions."
---

## Hand shake problem

At an event 11 attendees shook hands with each other before and after the event how many total handshakes occurred.

#### 数学原理和规律

- 这个问题涉及到组合数学中的组合公式，用于计算从n个不同元素中取出k个元素的组合数，记作 *C*(*n*,*k*) 或 (*k**n*)。
- 组合数的计算公式为：*C*(*n*,*k*)=*k*!(*n*−*k*)!*n*!，其中 *n*! 表示n的阶乘，即 *n*×(*n*−1)×⋯×1。
- 在这个问题中，我们需要计算从11个人中选择2个人握手的组合数，即 *C*(11,2)。
- 根据组合公式，*C*(11,2)=2!(11−2)!11!=2×111×10=55。
- 由于活动开始前和活动结束后各发生一次这样的握手过程，所以总握手次数为 55×2=110 次。

#### Mathematical Principle and Pattern

- This problem involves the combination formula in combinatorial mathematics, which is used to calculate the number of ways to choose k elements from n different elements, denoted as *C*(*n*,*k*) or (*k**n*).
- The formula for combinations is: *C*(*n*,*k*)=*k*!(*n*−*k*)!*n*!, where *n*! represents the factorial of n, i.e., *n*×(*n*−1)×⋯×1.
- In this problem, we need to calculate the number of ways to choose 2 people out of 11 to shake hands, which is *C*(11,2).
- According to the combination formula, *C*(11,2)=2!(11−2)!11!=2×111×10=55.
- Since the handshake process occurs once before and once after the event, the total number of handshakes is 55×2=110 times.

### 排列（Permutations）

排列是指从n个不同元素中取出r个元素，按照一定的顺序排列起来。排列的计算公式为：P其中，*n*!（n的阶乘）表示从1到n的所有正整数的乘积。

### 组合（Combinations）

组合是指从n个不同元素中取出r个元素，不考虑顺序。组合的计算公式为： *C*(*n*,*r*)=*r*!(*n*−*r*)!*n*! 组合数也记作 (*r**n*)。

### 例子

- 从5个人中选择3个人进行排列，排列数为 *P*(5,3)=(5−3)!5!=2!5!=2120=60。
- 从5个人中选择3个人进行组合，组合数为 *C*(5,3)=3!(5−3)!5!=3!2!5!=6×2120=10。
