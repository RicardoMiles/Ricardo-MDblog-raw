---
title: Msc Project Archive
date: 2024-06-05 12:08:04
categories: 
- Coding
tags: 
- CS Learning
- Research
- University of Bristol
- Machine Learning
- BCI    
excerpt: Kick-off part of personal individual summer project.
---

## Sections should be included

### Abstract

### Background

Background section talks about what method  I used, what data I used, and some related theory/concept

* EEG (general concept) and what it is

* Theory of Machine Learning & Neural Network &  RNN & LSTM

* What is LSTM

### Methodology

Methodology section talks about actual work I've done, specificly LSTM implement

### Result

### Discuss

### Ethnics

There are two professors George contacted. They said it is happy to give me advice. But it is not top priority should be considered right now. One of them is Andrew Charlesworth, another is Emi Tonkin.

### Conclusion

## Tasks

* Getting familiar with neural network

* Having a rough understanding of RNN

* Having my own research on machine learning

* Focus on Session Two “Food Choice” part of dataset

* Make sure the submission date of delayed project

* Make sure the reassessment period of CA and C and JAVA

* Write a proposal for myself - George said there is no need to do weekly report, but motivation and schedule for myself is more vital

## Title

Predicting Binary Choices using Machine Learning Techniques on EEG data : A case study on Legal ethics of BCI's

Predicting Binary Choices using LSTM on EEG data : A case study on Legal ethics of BCI's

## Quick Overview

### NN & RNN & CNN & LSTM

* NN - Neural Network

* RNN - Recurrent Neural Network

* LSTM - Long Short-Term Memory

  * Long Short-Term Memory，LSTM是一种时间循环神经网络（RNN）。LSTM适合于处理和预测时间序列中间隔和延迟非常长的重要事件。

  * LSTM的表现通常比时间循环神经网络及隐马尔科夫模型（HMM）更好，作为非线性模型，LSTM可作为复杂的非线性单元用于构造更大型深度神经网络。

  * 通常情况，一个LSTM单元由细胞单元（cell）、输入门（input gate）、输出门（output gate）、遗忘门（forget gate）组成。

  * 我的项目用LSTM来做。

* CNN - Convolutional Neural Network

  卷积神经网络。目前我用不到，简单了解。

### NN Family Hierarchy

![NN Hierarchy](/images/2024-06-10-00-59-14-image.png)

* NN forms a hierarchy that includes CNN and RNN, with RNN further including LSTM.

* RNNs and LSTMs are particularly good for sequence data, with LSTMs improving the RNN's ability to remember information over longer sequences.

* CNNs are particularly good for image and spatial data due to their convolutional layers.

### Basic Components of Neural Networks

1. **Neurons**:

   - Similar to biological neurons, artificial neurons receive input signals, perform a weighted sum, and then output results through an activation function.

2. **Layers**:

   - Neural networks typically consist of an input layer, hidden layers, and an output layer. The input layer receives external data, the hidden layers process the data, and the output layer provides the final result.

3. **Weights**:

   - Each connection has a weight, representing the importance of the signal. Through training, the network adjusts these weights to minimize prediction errors.

4. **Activation Functions**:

   - Activation functions determine the output of a neuron, such as Sigmoid, ReLU (Rectified Linear Unit), and Tanh (Hyperbolic Tangent).

### Simple NN Examples

Based on TensorFlow and its advanced API Keras. It is a simple FNN, used to solve a basic sorting problem. The MNIST handwriting number identification. MNIST dataset contains 28*28 size image of handwriting image. Every image reflect a tag, which signify the image's number 0-9.

```python
import tensorflow as tf
from tensorflow.keras import layers, models

# Loading MNIST Dataset
mnist = tf.keras.datasets.mnist
(x_train, y_train), (x_test, y_test) = mnist.load_data()
# MNIST dataset is a standard dataset including handwritten numbers, each picture size is 28*28 pixels
# Label falls in numbers from 0 - 9
# tf.keras.datasets.mnist is module of TensorFlow used to load MNIST
# mnist.load_data():return 2 tuple，(x_train,y_train) and (x_test,y_test)

# Standardized dataset
x_train, x_test = x_train / 255.0, x_test / 255.0


```

### All My Noob Question 

#### Q1-Suppose I have my own data file in the same format as the MNIST data. I need to load the data into a NumPy array and perform the same normalization. What should I do?

```python
import numpy as np
from PIL import Image
import os

# Custom function to load images and convert them to NumPy arrays
def load_custom_data(data_dir):
    images = []
    labels = []
    for file_name in os.listdir(data_dir):
        if file_name.endswith('.png'):  # Assuming the image format is PNG
            label = int(file_name.split('_')[0])  # Assuming filename format is "label_index.png"
            img_path = os.path.join(data_dir, file_name)
            img = Image.open(img_path).convert('L')  # Convert to grayscale
            img = img.resize((28, 28))  # Ensure image size is 28x28
            img_array = np.array(img)
            images.append(img_array)
            labels.append(label)
    return np.array(images), np.array(labels)

# Load custom data
custom_data_dir = 'path_to_my_custom_data'  # Replace with my data folder path
x_custom, y_custom = load_custom_data(custom_data_dir)

# Normalize custom data
x_custom = x_custom / 255.0
```

* After loading, build and train the model

  ```python
  # Build the model
  model = models.Sequential()
  model.add(layers.Flatten(input_shape=(28, 28)))  # Flatten the 28x28 image into a 784-dimensional vector
  model.add(layers.Dense(128, activation='relu'))  # Fully connected layer with 128 neurons, ReLU activation
  model.add(layers.Dense(10, activation='softmax'))  # Output layer with 10 neurons, corresponding to 10 classes
  
  # Compile the model
  model.compile(optimizer='adam',
                loss='sparse_categorical_crossentropy',
                metrics=['accuracy'])
  
  # Train the model
  model.fit(x_train, y_train, epochs=5)
  ```

* Use the trained model to predict my data

  ```
  # Predict custom data
  predictions = model.predict(x_custom)
  
  # Print prediction results
  for i, prediction in enumerate(predictions):
      predicted_label = np.argmax(prediction)
      true_label = y_custom[i]
      print(f'Image {i}: Predicted label = {predicted_label}, True label = {true_label}')
  ```

* What is tuple - [Extreme Simple Tutorial for Tuple Review in Python](#TupleReview)

#### Q2-What does model evaluation mean, why do I need to evaluate it, and how do I evaluate it?

* What does model evaluation mean?

  Model evaluation refers to the process of assessing how well a machine learning model performs on a given task. It involves measuring the model's accuracy, reliability, and ability to generalize to new, unseen data. Essentially, it tells me how good my model is at making predictions or solving the problem I trained it for.

* Why do I need to evaluate it?

  I need to evaluate my model for several reasons:

  - **Performance Check**: To ensure the model is learning effectively and producing useful results, rather than just memorizing the training data (overfitting) or failing to learn at all (underfitting).

  - **Generalization**: To confirm the model works well on data it hasn’t seen before, which is critical for real-world applications like predicting choices from EEG data in my project.

  - **Improvement**: Evaluation helps identify weaknesses, allowing me to tweak the model (e.g., adjust hyperparameters, change architecture, or preprocess data differently).

  - **Decision-Making**: In my case, if the model predicts binary choices (e.g., yes/no decisions), I need to know its success rate to trust its outputs for BCI or legal ethics studies.

* How do I evaluate it?

  There are several common methods to evaluate a machine learning model, depending on the task (e.g., classification, regression). Since my project involves predicting binary choices, here’s how I might evaluate my LSTM or neural network model:

1. Split Data into Training and Testing Sets

   - Use a portion of my data for training (e.g., 80%) and reserve the rest for testing (e.g., 20%). This ensures me evaluate on unseen data.

2. Metrics

   - Accuracy
   - Confusion Matrix
   - Precision, Recall, F1-Score

3. Cross-Validation

    (Optional):

   - Split data into multiple folds (e.g., 5-fold cross-validation) and train/test multiple times to get a more robust performance estimate.
   - Useful if my EEG dataset is small.

4. Loss Function

   - Monitor the loss (e.g., sparse_categorical_crossentropy in my code) on both training and test sets. Lower loss indicates better performance, but a big gap between training and test loss suggests overfitting.

5. Visual Inspection

   - Plot training vs. test accuracy/loss over epochs to see how the model learns.

For my project, I could evaluate how well my LSTM predicts binary choices (e.g., "yes" or "no" to food choices) by checking accuracy and confusion matrix on the test EEG data.

#### Q3-What is normalization, why do I need to normalize, and are there any principles or rules for normalization?

Normalization is the process of adjusting data to a specific range, typically [0, 1] or [-1, 1]. In data processing, normalization is a kind of preprocessing. Normalized data has a smaller range, making computations more efficient and speeding up model training.

#### Q4-Is it only when my own data format matches the standard datasets of existing machine learning libraries that I can perform training, loading, and prediction?

No, it’s not strictly necessary for my data format to match the standard datasets (like MNIST) used by machine learning libraries. However, my data needs to be preprocessed and structured in a way that’s compatible with the model’s input requirements for training, loading, and prediction to work effectively.

#### Q5-What is Numpy Array 

Not a hardcore problem, tons of tutorial online, just pick the most popular one.

[NumPy Tutorial](https://www.w3schools.com/python/numpy/default.asp)

## Python-Tuple Review元组复习

<a name="TupleReview"></a>

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



## BackGround - Detailed

### EEG

#### What is EEG

- EEG (Electroencephalography) is a technique that records the electrical activity of the brain by placing electrodes on the scalp. It is primarily used to monitor and analyze the neural activity of the brain’s cortex. EEG is widely applied in medical diagnostics, neuroscience research, and studies of cognition and behavior.
- Supporting Literature: Niedermeyer, E., & da Silva, F. L. (2004). *Electroencephalography: Basic Principles, Clinical Applications, and Related Fields*. Lippincott Williams & Wilkins.

#### Why the BCI Predicting Techniques Research Needs EEG

- In Brain-Computer Interface (BCI) research, EEG is one of the commonly used techniques because it can record brain activity in real-time non-invasively. EEG offers high temporal resolution, capturing rapidly changing electrical signals in the brain, which is crucial for real-time control in BCI systems. Additionally, EEG equipment is relatively portable and cost-effective, making it suitable for both laboratory and practical applications.
- Supporting Literature: Wolpaw, J. R., & Wolpaw, E. W. (2012). *Brain-Computer Interfaces: Principles and Practice*. Oxford University Press.

#### What are EEG's Pros Compared to Invasive Techniques

EEG’s main advantages over invasive techniques (such as Electrocorticography [ECoG] and Deep Brain Stimulation [DBS]) include:

- Non-invasiveness: No surgery is required, avoiding surgical risks and postoperative complications.
- High Safety: It poses no physical harm to subjects, making it suitable for long-term and repeated use.
- Low Cost: Equipment and maintenance costs are relatively low, enabling widespread application.
- Portability: EEG devices can be designed to be highly portable, suitable for use in various environments.
- Supporting Literature: Michel, C. M., & Murray, M. M. (2012). Towards the utilization of EEG as a brain imaging tool. *NeuroImage*, 61(2), 371-385.

### Machine Learning

#### Theory of Machine Learning

- Category of Machine Learning

#### Theory of Neural Network

- What is a Neural Network
- Why Neural Networks Can Be Used in Decision-Making Prediction

#### Theory of RNN and LSTM

- What is RNN (Recurrent Neural Network)
- What is LSTM (Long Short-Term Memory)

### 

