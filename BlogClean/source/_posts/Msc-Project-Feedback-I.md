---
title: Msc Project Feedback I
date: 2024-06-09 19:39:21
categories: 
- Coding
tags: 
- CS Learning
- Research
- University of Bristol
- Machine Learning
- BCI 
- NN
- RNN
- LSTM
excerpt: First Note of techniques learned in UoB summer project.
---

神经网络是一种模拟生物大脑结构和功能的计算模型，广泛应用于人工智能和机器学习领域。它主要由大量互相连接的人工神经元（或节点）组成，通过学习从数据中提取特征和模式，以解决各种复杂问题。

### Neural Network基本组成部分

1. **神经元（Neurons）**：
   
   - 类似于生物神经元，人工神经元接收输入信号，进行加权求和，然后通过激活函数输出结果。

2. **层（Layers）**：
   
   - 神经网络通常包括输入层、隐藏层和输出层。输入层接收外部数据，隐藏层进行数据处理，输出层给出最终结果。

3. **连接权重（Weights）**：
   
   - 每个连接都有一个权重，表示信号的重要性。通过训练，网络会调整这些权重以最小化预测误差。

4. **激活函数（Activation Functions）**：
   
   - 激活函数决定神经元的输出，如Sigmoid、ReLU（修正线性单元）和Tanh（双曲正切）等。

### Simple NN Examples

#### 一个简单的FNN-前馈神经网络

TensorFlow and its advanced API Keras 

```python
import tensorflow as tf
from tensorflow.keras import layers, models

# 加载MNIST数据集
mnist = tf.keras.datasets.mnist
(x_train, y_train), (x_test, y_test) = mnist.load_data()
# MNIST dataset是一个包含手写数字的标准数据集，每张图像是28*28像素
# 标签是0到9之间的数字
# tf.keras.datasets.mnist 是TensorFlow中的一个模块，用于加载MNIST数据集
# mnist.load_data():返回两个元组，分别是训练数据(x_train,y_train);和测试数据(x_test,y_test)

# 归一化数据
x_train, x_test = x_train / 255.0, x_test / 255.0


```

假设我有自己的数据文件，格式与MNIST数据相同。我需要将数据加载到numpy数组中，并进行同样的归一化处理。

```python
import numpy as np
from PIL import Image
import os

# 自定义函数加载图像并转换为numpy数组
def load_custom_data(data_dir):
    images = []
    labels = []
    for file_name in os.listdir(data_dir):
        if file_name.endswith('.png'):  # 假设图像格式为PNG
            label = int(file_name.split('_')[0])  # 假设文件名格式为 "label_index.png"
            img_path = os.path.join(data_dir, file_name)
            img = Image.open(img_path).convert('L')  # 转换为灰度图
            img = img.resize((28, 28))  # 确保图像大小为28x28
            img_array = np.array(img)
            images.append(img_array)
            labels.append(label)
    return np.array(images), np.array(labels)

# 加载自定义数据
custom_data_dir = 'path_to_your_custom_data'  # 替换为你的数据文件夹路径
x_custom, y_custom = load_custom_data(custom_data_dir)

# 归一化自定义数据
x_custom = x_custom / 255.0

```



加载完毕，构建和训练模型

```python
# 构建模型
model = models.Sequential()
model.add(layers.Flatten(input_shape=(28, 28)))  # 将28x28的图像展开成784维的向量
model.add(layers.Dense(128, activation='relu'))  # 全连接层，包含128个神经元，激活函数为ReLU
model.add(layers.Dense(10, activation='softmax'))  # 输出层，包含10个神经元，对应10个类别

# 编译模型
model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

# 训练模型
model.fit(x_train, y_train, epochs=5)

```



用训练好的模型对我的数据进行预测

```python
# 预测自定义数据
predictions = model.predict(x_custom)

# 打印预测结果
for i, prediction in enumerate(predictions):
    predicted_label = np.argmax(prediction)
    true_label = y_custom[i]
    print(f'图像 {i}: 预测标签 = {predicted_label}, 实际标签 = {true_label}')

```



It is a simple FNN, used to solve a basic sorting problem. The MNIST handwriting number identification. MNIST dataset contains 28*28 size image of handwriting image. Every image reflect a tag, which signify the image's number 0-9.

#### 

#### Python-Tuple Review元组复习

Tuple is  a kind of data struct in Python, used to store multiple values. Tuple is similar to list. But there is crucial difference.

* 不可变性：元组一旦创建，其中的元素就不能修改。这与列表不同，列表是可变的，可以在创建后修改元素。

* 定义： 用 `()` round bracket to define Tuple, separate elements in Tuple by comma. 圆括号定义，逗号分隔。

* Access 访问：用索引访问 e.g. `print(my_tuple[0])`

* Unpacking 解包：Assign the values of a tuple to multiple variables in a single statement. 将一个元组中的多个值解包给多个不同的变量

##### Unpacking

```python
my_tuple = (10,20,30)
a,b,c = my_tuple
print(a) # Output: 10
print(b) # Output: 20
print(c) # Output: 30
```

Unpacking the tuple into variables a, b and c.

##### Access

```python
my_tuple = (10,20,30)
print(my_tuple[0]) # Output: 10
print(my_tuple[2]) # Output: 30
```

In Python, I can access elements of a tuple using an index. An inde is a number that indicates the position of the element in the tuple, starting from zero for the first element's index.



#### Q-什么叫模型的评估，我为啥要评估，怎么评估

#### Q-什么叫归一化，为啥要归一化，归一化有没有原则和规则

Normalization 是将数据调整到特定范围内的过程。通常是[0,1] or [-1,1]的过程。在数据处理中，Normalization is kinda of preprocessing.归一化后的数据范围较小，计算时会更加高效，从而加快模型的训练速度。

**In my project, I should check what preprocessing with George**



##### Min-max归一化

将数据缩放到[0,1]区间：

```python
x_norm = (X - X.min()) / (X.max() - X.min())
```

##### Z-score归一化

将数据调整为均值为0，标准差为1：
**原理**：

- Z-score归一化，也称为标准化（Standardization），是将数据转换为均值为0，标准差为1的分布。
- 公式：Xnorm​ = (X−μ)➗​σ
  - μ 是数据的均值（mean）。
  - σ 是数据的标准差（standard deviation）。

```python
x_norm = (X - X.mean()) / X.std()
```

**操作方法**：

- 对于每个数据点 X，我们计算其归一化后的值 Xnorm​，方法是将数据点减去均值，然后除以标准差。

**具体步骤：**

1. **计算均值（mean）**：
   
   - 均值是所有数据点的平均值，表示数据的中心位置。
   - 公式：μ=N1​∑i=1N​Xi​
   - 在代码中，使用 `X.mean()` 计算。

2. **计算标准差（standard deviation）**：
   
   - 标准差表示数据的离散程度，即数据点相对于均值的平均偏差。
   - 公式：σ=N1​∑i=1N​(Xi​−μ)2​
   - 在代码中，使用 `X.std()` 计算。

3. **归一化**：
   
   - 对于每个数据点 X，计算其归一化后的值：Xnorm​=X−μ / σ​

**`mean()` 方法**：

- `mean()` 是 NumPy 数组对象的方法，用于计算数组中所有元素的平均值。
- 例子：对于数组 `X = np.array([1, 2, 3, 4, 5])`，`X.mean()` 计算的结果是 `3.0`。

**`std()` 方法**：

- `std()` 是 NumPy 数组对象的方法，用于计算数组中所有元素的标准差。
- 例子：对于数组 `X = np.array([1, 2, 3, 4, 5])`，`X.std()` 计算的结果是 `1.4142135623730951`。

```python
import numpy as np

# 示例数据
X = np.array([1, 2, 3, 4, 5])

# 计算均值
mean = X.mean()
print(f'Mean: {mean}')  # 输出: Mean: 3.0

# 计算标准差
std = X.std()
print(f'Standard Deviation: {std}')  # 输出: Standard Deviation: 1.4142135623730951

# Z-score 归一化
X_norm = (X - mean) / std
print(f'Z-score Normalized Data: {X_norm}')
# 输出: Z-score Normalized Data: [-1.41421356 -0.70710678  0.  0.70710678  1.41421356]

```

###### **Z-Score Nomalization详细步骤**：

1. **计算均值**：
   
   - 数组 `X` 的均值 μ=3.0。
   - `X.mean()` 计算整个数组的平均值。

2. **计算标准差**：
   
   - 数组 `X` 的标准差 σ≈1.414。
   - `X.std()` 计算整个数组的标准差。

3. **归一化**：
   
   - 对数组中的每个元素 Xi​，使用公式 Xnorm​=σXi​−μ​ 进行归一化。

###### Z-score总结

Z-score归一化是将数据调整为均值为0、标准差为1的过程。这可以通过减去均值并除以标准差来实现。`mean()` 和 `std()` 方法分别用于计算数据的均值和标准差，这些方法由NumPy库提供，用于简化数据处理过程。

##### 最大绝对值归一化

将数据缩放到[-1,1]区间，适用于有正负值的数据：

```python
x_norm = x / np.abs(x).max()
```

##### Sample using Z-score and Min-Max

```python
import numpy as np


# 实例数据
X = np.array([1,2,3,4,5])

# Min-Max 归一化
X_min_max_norm = (X - X.min()) / (X.max() - X.min())
print(f'Min-Max Normalized Data: {X_min_max_norm}')


# Z-score归一化
X_z_score_norm = (X - X.mean()) / X.std()
print(f'Z-score Normalized Data: {X_z_score_norm}')
```

Output:

```textile
Min-Max Normalized Data: [0.   0.25 0.5  0.75 1.  ]
Z-score Normalized Data: [-1.41421356 -0.70710678  0.  0.70710678  1.41421356]

```

#### Q-是不是只有我自己的数据格式和现存机器学习库的标准数据集一致，我才能进行训练、加载、预测

#### Q-numpy数组是什么，numpy基本教学

**NumPy** 是 Python 中一个非常流行的科学计算库，它提供了对多维数组对象（即 `ndarray`）的支持。NumPy 数组与 Python 的原生列表有很多相似之处，但它们提供了更高效的存储和操作多维数据的功能。

* 每次在写脚本的时候都导入NumPy

```python
import numpy as np
```

* 创建NumPy数组的两种方法
  
  * 从列表创建
  
  ```python
  list_sample = [1,2,3,4,5]
  np_array = np.array(list_sample)
  print(np_array) # Output: [1 2 3 4 5]
  ```
  
  * 用Numpy内置函数创建
    
    1. 全零
       
       ```python
       zeros_array = np.zeros((3, 4))
       print(zeros_array)
       # 输出:
       # [[0. 0. 0. 0.]
       #  [0. 0. 0. 0.]
       #  [0. 0. 0. 0.]]
       ```
    
    2. 全一
       
       ```python
       ones_array = np.ones((2, 3))
       print(ones_array)
       # 输出:
       # [[1. 1. 1.]
       #  [1. 1. 1.]]
       ```
    
    3. 创建指定值的数组
       
       ```python
       full_array = np.full((2, 2), 7)
       print(full_array)
       # 输出:
       # [[7 7]
       #  [7 7]]
       ```
       
       
    
    4. 创建一个包含一定范围内数字的数组
       
       ```python
       range_array = np.arange(0, 10, 2)
       print(range_array)
       # 输出: [0 2 4 6 8]
       ```
    
    5. 创建随机数组
       
       ```python
       random_array = np.random.random((2, 2))
       print(random_array)
       # 输出:
       # [[0.26726124 0.99429272]
       #  [0.55237008 0.27386384]]
       ```

* Access Numpy Array
  
  * Access Numpy Array
    
    NumPy 数组可以使用索引和切片操作来访问元素：
    
    
    
    ```python
    array = np.array([[1, 2, 3], [4, 5, 6]])
    print(array[0, 0])  # 输出: 1
    print(array[1, 2])  # 输出: 6
    print(array[:, 1])  # 输出: [2 5]
    ```
  
  * Element level math calculation
    
    ```python
    a = np.array([1, 2, 3])
    b = np.array([4, 5, 6])
    
    print(a + b)  # 输出: [5 7 9]
    print(a * b)  # 输出: [ 4 10 18]
    print(a ** 2)  # 输出: [1 4 9]
    ```
  
  * 矩阵运算
    
    ```python
    A = np.array([[1, 2], [3, 4]])
    B = np.array([[5, 6], [7, 8]])
    
    print(np.dot(A, B))
    # 输出:
    # [[19 22]
    #  [43 50]]
    ```
  
  * 数组形状获取和重塑
    
    ```python
    array = np.array([[1, 2, 3], [4, 5, 6]])
    print(array.shape)  # 输出: (2, 3)
    
    reshaped_array = array.reshape((3, 2))
    print(reshaped_array)
    # 输出:
    # [[1 2]
    #  [3 4]
    #  [5 6]]
    
    ```
  
  * 例子：使用NumPy加载和处理图像数据
    
    ```python
    import numpy as np
    from PIL import Image
    import os
    
    def load_custom_data(data_dir):
        images = []
        labels = []
        for file_name in os.listdir(data_dir):
            if file_name.endswith('.png'):
                label = int(file_name.split('_')[0])
                img_path = os.path.join(data_dir, file_name)
                img = Image.open(img_path).convert('L')
                img = img.resize((28, 28))
                img_array = np.array(img)
                images.append(img_array)
                labels.append(label)
        return np.array(images), np.array(labels)
    
    custom_data_dir = 'path_to_your_custom_data'
    x_custom, y_custom = load_custom_data(custom_data_dir)
    x_custom = x_custom / 255.0
    
    print(x_custom.shape)  # 输出图像数组的形状，例如: (num_images, 28, 28)
    print(y_custom.shape)  # 输出标签数组的形状，例如: (num_images,)
    
    ```
    
    
