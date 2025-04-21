---
title: Reflection on My Implementation of Singly Linked List
date: 2025-04-21 22:01:47
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
excerpt: "Reflection on my implementation of singly linked list data structure and its algorithm in C++."

---

## My Implementation and Problems

[My implementation with int type link list](https://github.com/RicardoMiles/DSA2025/tree/main/MoshCPP/PointerExercise/int_singly_linked_list.cpp)

[Full implementation](https://github.com/RicardoMiles/DSA2025/tree/main/MoshCPP/PointerExercise/general_singly_linked_list.cpp)

When I tried to implement a linked list started from `int` type, I face little problems. 

I used a incorrect deletion logic when I try to clear all the nodes in singly linked list: I try to delete from end and face double memory free error when running the program.

```cpp
void clearAllNode(){
    while(this->head != nullptr){
        LinkedListNode* currentNode = this->head;
        LinkedListNode* lastNode = nullptr;
        while(currentNode->nextNode != nullptr){
            currentNode = currentNode->nextNode;
            lastNode = currentNode;
        }
        delete currentNode;
        currentNode = lastNode;
        currentNode->nextNode = nullptr;
    } 
}
```

* I attempted to delete the last node by traversing to the end of the list, and then somehow referencing the "second-last" node afterward.  
* I incorrectly assigned `currentNode` to `lastNode` after traversing `currentNode` to the end of the list using `currentNode = currentNode->nextNode;`. My intention was to make `lastNode` represent the node before the last one. However, in this case, both `currentNode` and `lastNode` ended up referring to the same node, because I assigned `lastNode` **after** `currentNode` had already moved to the last node.
* But since a **singly linked list only points forward**, once I delete the last node, I lose access to the previous one. This caused a **bug or crash**
* especially when I tried to access a freed node

## How to Fix

If I insist on deleting nodes from the end of a singly linked list, I must:

* Traverse the list each time to find the second-last node
* Delete the last node.
* Set the second-last node's `nextNode` to `nullptr`
* Do that again and again until `head` points to `nullptr`

```cpp
void clearAllNode(){
    while(this->head != nullptr){
        if((this->head)->nextNode == nullptr){
            delete this->head;
            this->head = nullptr;
        }else{
            LinkedListNode* currentNode = this->head;
            LinkedListNode* lastNode = nullptr;
            while(currentNode->nextNode != nullptr){
                lastNode = currentNode;
                currentNode = currentNode->nextNode;
            }
            delete currentNode;
            currentNode = lastNode;
            currentNode->nextNode = nullptr;
        }     
    } 
}
```

## Better Practice and Why

I **can’t efficiently delete from the end** in a singly linked list because:

- Each node only has a pointer to the **next** node, not the **previous** one.
- To delete the last node, I must **traverse the entire list** from the beginning to find:
  1. The **last node**, to delete it.
  2. The **second-last node**, so I can set its `nextNode = nullptr`.

That means:

- I cannot just move backward in the list.
- Deleting every node from the end means **traversing the list N times**, making the time complexity **O(n²)** for clearing.  [How to Calculate O(n) Complexity](https://www.geeksforgeeks.org/analysis-algorithms-big-o-analysis/)

Better practice for me to clear all nodes from a singly linked list is delete from head

```cpp
void clearAllNode(){
    while (head != nullptr) {
        LinkedListNode* temp = head;
        head = head->nextNode;
        delete temp;
    }
    cout << "Already Empty Linked List\n";
}
```



