# Develop LSTM RNN in Python using the Keras deep learning

## Dataset (often referred to as the IMDB dataset) contains 25,000 highly polar movie reviews (good or bad) for training and the same amount again for testing. 

training testing区别先后

**Training**: The process where the model learns by adjusting its parameters using training data. The model repeatedly "sees" the data to learn the relationship between input and output.

**Testing**: After the model is trained, testing is done using data the model has never seen. Testing assesses the model's performance on unseen data without updating its parameters.

**Difference**: Training is for learning, while testing is for evaluation. Testing ensures the model can generalize to new data.

| **项目**     | **Training（训练）**             | **Testing（测试）**                    |
| ------------ | -------------------------------- | -------------------------------------- |
| **目的**     | 学习和调整模型参数               | 评估模型的泛化能力                     |
| **数据使用** | 模型使用训练数据来调整权重和参数 | 模型使用测试数据进行评估，但不调整参数 |
| **操作顺序** | 先进行训练，直到模型性能较好     | 训练完成后再进行测试                   |
| **数据暴露** | 模型**反复“看”**训练数据         | 模型从未见过测试数据                   |

## 告诉我Keras库具体怎么调用这个函数，用简单的例子说明，比如我在一个小小的py脚本里面要用这个数据库

**Keras provides built-in access to the IMDB dataset. The **imdb.load_data()** function allows you to load the dataset in a format ready for use in neural networks and deep learning models.**

Keras 提供了一个非常方便的接口来直接加载 IMDB 数据集，使用 `imdb.load_data()` 函数可以轻松获取已经预处理好的数据，适合直接用在深度学习模型中。

接下来我会通过一个简单的 Python 脚本例子，演示如何在 Keras 中调用 `imdb.load_data()` 函数，并加载 IMDB 数据集。

* Step 1: 安装 Keras（如果还没有安装的话）

在终端或命令行中运行以下命令安装 `tensorflow`，因为 Keras 已经集成在 TensorFlow 中。

```bash
pip install tensorflow
```

* Step 2: 使用 `imdb.load_data()` 加载数据

下面是一个完整的小脚本，展示如何调用 `imdb.load_data()` 函数，并对数据集进行初步处理：

```Python
# 导入必要的库
import tensorflow as tf
from tensorflow.keras.datasets import imdb

# 1. 加载IMDB数据集
# 设置我们只考虑最常见的5000个单词，其余单词会被忽略
top_words = 5000
(X_train, y_train), (X_test, y_test) = imdb.load_data(num_words=top_words)

# 打印一些数据集的信息
print(f'训练数据的数量: {len(X_train)}')
print(f'测试数据的数量: {len(X_test)}')

# 2. 查看训练数据的具体内容
print(f'第一条训练影评的编码序列: {X_train[0]}')
print(f'第一条训练影评的情感标签: {y_train[0]}')

# 3. 为了使得每条影评长度一致，我们对其进行填充和截断操作
from tensorflow.keras.preprocessing import sequence

# 设置最大影评长度为500
max_review_length = 500

# 通过填充或截断使得每条影评长度变为500
X_train = sequence.pad_sequences(X_train, maxlen=max_review_length)
X_test = sequence.pad_sequences(X_test, maxlen=max_review_length)

# 打印填充后的第一条影评
print(f'填充后的第一条影评: {X_train[0]}')
```

* 代码解释

1. **导入Keras模块**：

   - `tensorflow.keras.datasets.imdb` 包含了IMDB数据集。
   - `sequence.pad_sequences` 用来填充或截断输入序列，确保所有影评的长度一致。

2. **加载IMDB数据集**：

   - `imdb.load_data(num_words=5000)`：我们只保留前5000个最常见的单词，这样可以减少模型的复杂度。

   - 返回的 

     ```python
     (X_train, y_train)
     ```

      和 

     ```python
     (X_test, y_test)
     ```

      是训练和测试集：

     - `X_train` 和 `X_test` 是影评的序列，每条影评被表示为一串单词的索引（数字化）。
     - `y_train` 和 `y_test` 是影评对应的标签，0表示负面影评，1表示正面影评。

3. **初步检查数据**：

   - 打印影评和标签的数量。
   - 查看第一个训练样本的具体内容，显示该影评的数字化序列和标签。

4. **填充和截断序列**：

   - 影评的长度不同，为了统一输入格式，我们使用 `pad_sequences` 对影评进行处理。
   - 填充或截断后，所有影评的长度都会变为 `500`，无论原来多长或多短。

* 脚本输出

运行这个脚本后，你会看到类似如下的输出：

```makefile
代码训练数据的数量: 25000
测试数据的数量: 25000
第一条训练影评的编码序列: [1, 14, 22, 16, ...]  # 这里是影评被数字化后的结果
第一条训练影评的情感标签: 1  # 1 表示正面影评
填充后的第一条影评: [0, 0, 0, 0, 0, ..., 22, 16, 43, 530, 973]
```

* 详细步骤

1. **加载数据**：首先你需要使用 `imdb.load_data()` 加载 IMDB 数据集。此时，Keras 会自动将影评中的单词转换为数字表示，并将这些数字化的序列作为模型的输入。
2. **查看数据格式**：每一条影评在 `X_train` 中都被表示为一串数字（单词的索引），而 `y_train` 中的标签是0或1，表示影评的情感分类（负面或正面）。
3. **填充序列**：为了让模型能够处理不同长度的影评，我们用 `sequence.pad_sequences()` 函数对影评进行填充或截断，使得所有影评的长度一致，方便后续输入到神经网络中。

## You will map each movie review into a real vector domain

tell me what is a real vector domain

A **real vector domain** refers to a space where vectors are represented using real numbers. In machine learning and deep learning, particularly in natural language processing (NLP), mapping data like text or images into a **real vector domain** means converting that data into a set of vectors, where each vector is composed of real numbers (numbers that can take any value on the number line, including decimals).

* What does this mean in the context of movie reviews?

​	When you are processing movie reviews for a neural network, the text data (which is discrete in nature, made of words and characters) needs to be 	transformed into a numerical format that the model can understand. This numerical format is typically a **real vector space**.

​	For example, suppose you have a sentence like:

​	**"I love this movie"**

This sentence can be mapped into a vector space using techniques like **word embeddings** (e.g., Word2Vec, GloVe, or learned through the Embedding layer in Keras). Each word will be represented as a vector of real numbers, and collectively, these vectors form the vector representation of the sentence.

* Example of a Real Vector Domain:

Imagine each word in the sentence **"I love this movie"** is mapped into a vector like this:

"I" → `[0.2, 0.5, -0.1]`

"love" → `[0.8, 0.7, 0.3]`

"this" → `[0.1, -0.3, 0.4]`

"movie" → `[0.6, 0.1, 0.9]`

Each of these vectors resides in a **3-dimensional real vector space** because each vector has three components, and each component is a real number (positive or negative, or even zero).

* Why is this necessary?

**Neural networks** and machine learning models work with numerical data. In order to process and analyze textual data (like movie reviews), it must be converted into a format that the model can operate on, and the **real vector domain** provides a way to represent the relationships between words or documents numerically.

**Real vector domain** allows us to apply mathematical operations (like dot products, Euclidean distance) to understand the relationships between different words, sentences, or reviews. Vectors that are closer together in this space might represent words or sentences that have similar meanings.

### How is this done in practice?

In your case, the movie reviews (which are made of words) need to be converted into real-numbered vectors. This is typically done using **embedding layers** or **pre-trained word embeddings** in deep learning frameworks like Keras.

Here's an example of how this works with an Embedding layer in Keras:

```python
from tensorflow.keras.layers import Embedding

# Assuming a vocabulary size of 5000, and you want to map each word to a 32-dimensional vector
embedding_layer = Embedding(input_dim=5000, output_dim=32)

# The embedding layer will map each word (represented by an integer index) into a 32-dimensional real vector space.
```

### Visualization:

- **Before Mapping (Text Domain)**: "I love this movie" (discrete words).

- After Mapping (Real Vector Domain)

  :

  ```c#
  [ [0.2, 0.5, -0.1],     # "I"
    [0.8, 0.7, 0.3],      # "love"
    [0.1, -0.3, 0.4],     # "this"
    [0.6, 0.1, 0.9] ]     # "movie"
  ```

### Summary:

In simple terms, **real vector domain** is a space where data is represented using vectors made of real numbers. When you map movie reviews into this domain, you're essentially transforming the text into numerical vectors (real-valued numbers) so that a neural network can process and understand the data.

## Keras provides a convenient way to convert positive integer representations of words into a word embedding by an Embedding layer.

给我一个简单例子说一下怎么写这种代码

## You will map each word onto a 32-length real valued vector. You will also limit the total number of words that you are interested in modeling to the 5000 most frequent words and zero out the rest. Finally, the sequence length (number of words) in each review varies, so you will constrain each review to be 500 words, truncating long reviews and padding the shorter reviews with zero values.

哪一步代码做到了这些

根据这段描述，代码的不同部分实现了以下目标：

1. **将每个单词映射为一个长度为32的实数向量**。
2. **限制总的单词数量为最常见的5000个单词，忽略其他单词**。
3. **将每个影评的长度限制为500个单词，截断过长的影评，并用0填充较短的影评**。

----

1. **将每个单词映射为一个32维实数向量**

这一点通过 **Embedding 层** 来实现。在代码中如下：

```python
model.add(Embedding(input_dim=5000, output_dim=32, input_length=500))
```

- `input_dim=5000`：这是词汇表的大小，表示我们只考虑最常见的5000个单词。
- `output_dim=32`：表示每个单词将被映射为一个32维的实数向量。
- `input_length=500`：表示每条影评的长度被限制为500个单词。

2. **限制词汇表为5000个最常见的单词**

这是通过加载 IMDB 数据集时设置 `num_words=5000` 参数实现的，如下：

```python
(X_train, y_train), (X_test, y_test) = imdb.load_data(num_words=5000)
```

- `num_words=5000`：表示我们只使用词频最高的5000个单词，其他单词会被忽略（或设为0）。

3. **将影评长度限制为500个单词，填充或截断**

通过 `sequence.pad_sequences()` 函数实现。它会对影评进行填充或截断，以确保所有影评的长度一致：

```python
X_train = sequence.pad_sequences(X_train, maxlen=500)
X_test = sequence.pad_sequences(X_test, maxlen=500)
```

- `maxlen=500`：表示每条影评的长度限制为500个单词。较短的影评会在前面用0填充，较长的影评则会被截断。

以下是完整代码，结合了上述步骤来实现描述的目标：

```python
from tensorflow.keras.datasets import imdb
from tensorflow.keras.preprocessing import sequence
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Embedding, LSTM, Dense

# 加载IMDB数据集，并仅保留前5000个最常用单词
top_words = 5000
(X_train, y_train), (X_test, y_test) = imdb.load_data(num_words=top_words)

# 将影评长度限制为500个单词，较短的填充0，较长的截断
max_review_length = 500
X_train = sequence.pad_sequences(X_train, maxlen=max_review_length)
X_test = sequence.pad_sequences(X_test, maxlen=max_review_length)

# 创建模型
model = Sequential()
# Embedding层：将每个单词映射为32维向量，最多使用5000个单词，影评长度为500
model.add(Embedding(input_dim=top_words, output_dim=32, input_length=max_review_length))
model.add(LSTM(100))
model.add(Dense(1, activation='sigmoid'))

# 编译模型
model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])

# 打印模型概述
print(model.summary())

# 训练模型
model.fit(X_train, y_train, epochs=3, batch_size=64)
```

1. **Embedding层**通过 `output_dim=32` 将每个单词映射为一个32维的实数向量。
2. 使用 `num_words=5000` 参数来限制词汇表的大小，仅保留最常见的5000个单词。
3. 使用 `pad_sequences()` 函数将影评长度限制为500个单词，较短的影评用0填充，较长的影评会被截断。

------

**English Summary**:

1. The **Embedding layer** maps each word to a 32-dimensional real-valued vector (`output_dim=32`).
2. The vocabulary is limited to the top 5000 most frequent words using the `num_words=5000` parameter.
3. The review length is constrained to 500 words using `pad_sequences()`, which truncates longer reviews and pads shorter ones with zeros.

## Let’s start by importing the classes and functions required for this model and initializing the random number generator to a constant value to ensure you can easily reproduce the results.

Why I need initializing the random number generator, and why constant value could ensure I can easily reproduce the result. It is hard for me to comprehend this connection.

在深度学习或机器学习中，**初始化随机数生成器**和设置一个**常量值（随机种子）\**非常重要，这样可以保证每次运行代码时的结果是\**可复现的**。接下来我会详细解释为什么需要这样做，以及常量值如何帮助你轻松地复现结果。

#### 1. 为什么需要初始化随机数生成器？

在机器学习和深度学习中，有很多地方会用到随机数，比如：

- **模型权重的初始化**：在神经网络中，模型的初始权重通常是随机生成的。
- **数据的随机化**：训练时，数据会被打乱顺序，这也是随机的。
- **随机梯度下降算法**：优化过程中可能使用随机抽样的方式来更新模型参数。

由于这些操作都依赖于随机数，如果每次运行程序时都用不同的随机数，就会导致每次的模型训练过程不同，结果也可能有差异。

#### 2. 为什么设置常量值可以保证结果复现？

当你**设置一个随机种子（常量值）**时，实际上你是告诉程序的随机数生成器，每次都从同样的初始状态开始生成随机数。这样一来，尽管随机数的本质是不可预测的，但只要你每次都设置同样的随机种子，随机数的生成顺序也会保持一致，程序的行为也就保持一致，从而保证结果是可复现的。：

你可以把随机种子想象成一个**食谱**。如果你每次使用同样的食谱（相当于同一个随机种子），即便你做菜时需要随机放一点盐或其他调料（随机数生成），最终你做出的菜的味道仍然是相同的。换句话说，**相同的输入（种子）\**会给你\**相同的输出**。

在代码中，你可以通过如下方式设置随机数生成器的种子：

```python
import tensorflow as tf

# 设置随机数生成器的种子为常量值7
tf.random.set_seed(7)
```

每次运行这段代码时，程序中的所有涉及随机性的部分都会遵循同样的随机数序列，这样你就可以保证结果是一致的、可复现的。

#### 3. 具体作用：

- **模型训练时的随机初始化**：当你用相同的种子初始化模型权重时，即便你多次运行代码，模型会从相同的初始状态开始训练。
- **打乱数据的顺序**：数据被打乱的顺序每次都是一样的，这保证了数据顺序对模型训练的影响是可控的。
- **优化过程中的随机性**：比如在随机梯度下降中，模型每次抽取的小批量数据是相同的。

Summary

- **为什么要初始化随机数生成器？**：因为深度学习中的很多操作依赖于随机数（比如模型初始化、数据打乱等），随机数的不同会导致模型结果不同。
- **为什么设置常量值可以保证结果复现？**：通过设置随机种子，你可以确保每次运行时生成相同的随机数序列，从而保证模型的训练过程一致，最终结果也一致。

------

**English Summary**:

1. **Why initialize the random number generator?** In machine learning, many operations like model weight initialization and data shuffling rely on randomness. Different random numbers can lead to different results in training.
2. **Why does setting a constant value ensure reproducibility?** By setting a random seed (constant value), you ensure that every time the code is run, the random number generator produces the same sequence of numbers, which ensures that the model's behavior remains consistent and the results are reproducible.

## 在importing部分这里我没看懂

```python
# fix random seed for reproducibility
tf.random.set_seed(7)
```

为啥是7，为啥fix random seed 可以reproducibility

#### 1. 为什么使用 `7` 作为种子？

在代码中，`7` 这个数字本质上没有特别的意义，它可以是任何一个整数。使用 `7` 只是一个示例，开发者可以选择任意一个数字作为**随机种子**。

**为什么选择 7？**

- 选择 `7` 作为随机种子纯粹是随机的，这里 `7` 可以替换成任意的其他整数（如 `42`、`1234` 等），它们都会有相同的作用：**固定随机数生成器的初始状态**。
- 你可以理解为这是程序员随意选的一个数字，目的是为了确保每次生成的随机数序列是一致的。

#### 2. 为什么固定随机种子可以实现结果的可复现性？

`tf.random.set_seed()` 函数的作用是**设置随机数生成器的种子**，通过设置这个种子，我们可以控制程序中的“随机”行为，使得它每次运行时的结果都相同，达到可复现性。

#### 原理：

- **随机数生成器**实际上是使用一个数学算法生成伪随机数序列的。伪随机数的意思是：它们看起来是随机的，但实际上是由确定性的算法生成的。如果你提供相同的初始值（即“种子”），那么每次运行这个算法时，它生成的随机数序列就会是一样的。
- **随机种子**是这个算法的起点。如果你每次使用相同的种子值（比如 `7`），那么每次运行程序时，生成的“随机数”将会是相同的，这也就确保了程序中涉及到随机性的部分（如模型初始化、数据打乱等）是**一致的**。

#### 3. 如何实现可复现性？

在深度学习或机器学习中，随机性影响着许多操作，例如：

- **模型权重的初始化**：神经网络在训练开始时的初始权重通常是随机的。
- **数据的随机打乱**：训练时通常会随机打乱数据顺序。
- **训练数据的随机抽样**：在批量训练过程中，数据是通过随机抽样的方式送入模型。

由于这些操作依赖于随机数生成器，如果每次运行代码时使用不同的随机数，模型的训练过程可能会不同，最终的结果也会不同。

通过设置**随机种子**，你可以确保每次运行程序时的随机数是相同的，从而确保每次训练模型的初始状态、数据顺序和批量选择等操作是一致的，这样就能**复现**相同的结果。

```python
import tensorflow as tf

# 固定随机数生成器的种子为7
tf.random.set_seed(7)

# 任何涉及到随机性的操作，比如初始化权重或随机打乱数据
```

在上面的代码中，每次你运行这个程序，TensorFlow 会使用同样的随机数序列进行模型初始化或数据操作，保证每次运行时结果相同。

- **为什么使用 7？**：`7` 是一个示例性的随机种子值，本质上可以是任何整数，开发者可以任意选择。
- **为什么固定随机种子可以实现结果的可复现性？**：随机种子决定了随机数生成器的起点，设置相同的种子意味着每次运行程序时生成相同的随机数序列，从而使得涉及随机性的操作（如权重初始化、数据打乱）一致，确保结果的可复现性。

------

**English Summary**:

- **Why use 7?** The number 7 is just an example of a random seed. It could be any integer, and the purpose is to initialize the random number generator with a fixed starting point.
- **Why does fixing the random seed ensure reproducibility?** The random seed determines the starting point for the random number generator. By setting the seed to a constant value, we ensure that the same sequence of "random" numbers is generated each time the code runs, making the results consistent and reproducible.

### 做限制的部分

You need to load the IMDB dataset. You are constraining the dataset to the top 5,000 words. You will also split the dataset into train (50%) and test (50%) sets.

这部分说明我看懂了，但是具体代代码中，这里我不懂

```python
(X_train, y_train), (X_test, y_test) = imdb.load_data(num_words=top_words)

```

这是在干嘛

```
(X_train, y_train), (X_test, y_test) = imdb.load_data(num_words=top_words)
```

是在使用 Keras 提供的 `imdb.load_data()` 函数加载 IMDB 数据集。接下来我会详细解释它的作用。

#### 1. `imdb.load_data()` 函数的作用：

`imdb.load_data()` 是 Keras 中的一个函数，专门用于加载 IMDB 电影影评数据集。这个数据集已经被预处理成数字化形式，其中每个单词都被映射为一个整数。该函数将影评数据和对应的标签（情感分类，0 表示负面影评，1 表示正面影评）作为输出。

#### 2. 代码解释：

```python
(X_train, y_train), (X_test, y_test) = imdb.load_data(num_words=top_words)
```

这行代码的作用是：

- **加载IMDB数据集**：从 Keras 的 `imdb` 模块中加载预处理后的 IMDB 数据集。
- **限制词汇表大小**：通过设置 `num_words=top_words` 参数，代码只保留词频最高的 `top_words` 个单词，其余单词将被忽略。这在此处等同于保留**最常用的5000个单词**。
- **分割数据集**：数据集已经被划分成**训练集**和**测试集**，分别用 `(X_train, y_train)` 和 `(X_test, y_test)` 来表示。

- `X_train`：包含了**训练数据**，即电影影评本身（以整数表示的单词序列），每个影评的单词都被转化为一个整数序列。
- `y_train`：包含了训练数据的**标签**，每条影评的情感分类（0 表示负面影评，1 表示正面影评）。
- `X_test`：包含了**测试数据**，即用来评估模型性能的影评数据。
- `y_test`：包含了测试数据的**标签**，用于评估模型的分类准确性。

#### 3. `num_words=top_words` 的作用：

通过设置 `num_words=top_words`，你告诉程序只保留词频最高的 `top_words` 个单词，其余不常见的单词会被忽略或处理为0。这有助于减少模型的复杂性，因为模型只会关注最常用的单词，而不需要学习所有可能出现的单词。

例如，如果 `top_words=5000`，那么程序会只保留数据集中最常用的5000个单词，并将其余的单词转换为0或忽略掉。

#### 4. 数据集的分割：

`imdb.load_data()` 函数已经为你将数据集划分成了训练集和测试集：

- **训练集** (`X_train, y_train`)：用于训练模型，包含影评数据和对应的标签。
- **测试集** (`X_test, y_test`)：用于评估模型的泛化能力，包含影评数据和标签。通常，测试数据是模型从未见过的数据。

在这个例子中，IMDB 数据集已经按照 50% 的比例自动分成了训练集和测试集。

```python
# 设置我们只考虑最常见的5000个单词
top_words = 5000

# 加载数据集，并分割为训练集和测试集
(X_train, y_train), (X_test, y_test) = imdb.load_data(num_words=top_words)

# 查看训练数据的长度
print(f'训练集样本数量: {len(X_train)}')
print(f'测试集样本数量: {len(X_test)}')
```

这段代码加载数据集后，你可以查看训练集和测试集的大小，进一步了解数据的内容。

- `imdb.load_data(num_words=top_words)` 加载 IMDB 数据集，并只保留词频最高的 `top_words` 个单词。
- 这行代码将数据集分成训练集 `(X_train, y_train)` 和测试集 `(X_test, y_test)`，分别包含电影影评的数字序列和情感分类标签。
- 训练集用于训练模型，测试集用于评估模型性能。

------

**English Summary**: The line `(X_train, y_train), (X_test, y_test) = imdb.load_data(num_words=top_words)` loads the IMDB dataset, where only the top `top_words` most frequent words are kept. The data is split into a training set `(X_train, y_train)` and a test set `(X_test, y_test)`. Each movie review is represented as a sequence of integers (words), and the labels are 0 or 1 for negative and positive sentiment, respectively.

## Truncating 和 padding的部分

```python
X_train = sequence.pad_sequences(X_train, maxlen=max_review_length)
X_test = sequence.pad_sequences(X_test, maxlen=max_review_length)
```

这里的sequence在哪里定义的，`.pad_sequence` 又是怎么使用的



## The next layer is the LSTM layer with 100 memory units (smart neurons).

我不理解的是100个记忆单元是所有LSTM层自带的吗，还是我作为coder人为规定的，在哪定义呢

## Finally, because this is a classification problem, you will use a Dense output layer with a single neuron and a sigmoid activation function to make 0 or 1 predictions for the two classes (good and bad) in the problem.

* sigmoid activation function和single neuron为啥是用于Dense output layer
* EEG data predicating is also a 0 or 1 prediction for two classes  - it is a binary classification problem 



## Because it is a binary classification problem, log loss is used as the loss function

* What is log loss
* `binary_crossentropy` in Keras, how to use it, give me simple example and explanation
* The efficient ADAM optimization algorithm is used - what is ADAM optimization algorithm
* The model is fit for only two epochs because it quickly overfits the problem. A large batch size of 64 reviews is used to space out weight updates.



##  Once fit, you can estimate the performance of the model on unseen reviews.

Why

### This is a template that you can use to apply LSTM networks to your own sequence classification problem

* How to apple that LSTM template to my EEG part
* Could EEG data translate into vector's
* Could EEG data exclude the 伪影&干扰信号
* Refer to the dataset paper: how they do with the original data as an example
* Refer to the dataset paper: where is the food choice part in the batch of data
* Refer to the dataset paper: how can I do with EEG, how can I do the preprocessed data