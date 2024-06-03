---
title: 'Data Struct: Graph 图'
date: 2024-04-14 09:54:26
tags: 
 - Data-Struct
 - LearningCS
 - Notes
---

## Definition 定义

linklist中我们叫数据元素为element, in Tree data struct we call element node, in Graph data struct we call it Vertex.

No element in list we call it 空表, No node in Tree we call it 空树，

But we do not allow no vertex in Graph. In tree struct, neighbour level/layer have connection; In list, the neighbour element have string connection; but in graph, any two of vertex may have connection, the logic connection between vertexes signed by sides, side could be null.

无向边Edge vi vj之间的边没有方向, called Edge. Use （Vi, Vj）to signate.
No sequence non-odd pairs.

If any two of vertexes' connection is Edge, we call the graph as Undirected graphs无向图. So (Vi,Vj) could also be (Vj,Vi) because the direction is no matter.

有向边（弧）Arc。若从顶点vi到vj的边有方向，则称这条边为有向边，也称为弧（Arc）。用有序偶对<vi, vj>来表示，vi称为弧尾（Tail），vj称为弧头（Head）。如果图中任意两个顶点之间的边都是有向边，则称该图为有向图（Directed graphs）。图7-2-3就是一个有向图。连接顶点A到D的有向边就是弧，A是弧尾，D是弧头，<A，D>表示弧，注意不能写成<D，A>。

Head指向目标，Tail发自原点

() 表示无向边, <> 表示有向边

简单图means there is unique connection side between vertexes,and no connection side between vertex and itself.

在无向图中，如果任意两个顶点之间都存在边，则称该图为无向完全图。含有n个顶点的无向完全图有(n*(n-1)/2)条边.

在有向图中，如果任意两个顶点之间都存在方向互为相反的两条弧，则称该图为有向完全图。

The graph contains n vertexes, which is 完全有向图，would have n×（n－1）connections (arcs). 

有些图的边或弧具有与它相关的数字，这种与图的边或弧相关的数叫做权（Weight）。这些权可以表示从一个顶点到另一个顶点的距离或耗费。这种带权的图通常称为网（Network）
