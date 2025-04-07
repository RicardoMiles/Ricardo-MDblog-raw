---
title: Google Colab & Jupyter Tutorial
date: 2024-10-31 15:23:33
tags:
---
# 不同类型单元格之间的转换快捷键

以下是常见单元格类型的快捷键：

- **代码单元格**：按`Esc`，然后按`Y`。
- **Markdown单元格**：按`Esc`，然后按`M`。
- **纯文本单元格**（Raw）**：** 按`Esc`，然后按`R`

在代码单元格里写Python代码，按`Shift+Enter`就可以运行，运行结果会直接显示在代码单元格的下方。

# Importing a library that is not in Colaboratory

To import a library that's not in Colaboratory by default, you can use `!pip install` or `!apt-get install`.

# 从本地文件系统上传文件

`files.upload` 会返回已上传文件的字典。 此字典的键为文件名，值为已上传的数据。

```python
from google.colab import files

uploaded = files.upload()

for fn in uploaded.keys():

  print('User uploaded file "{name}" with length {length} bytes'.format(

      name=fn, length=len(uploaded[fn])))
```

# 将文件下载到本地文件系统

`files.download` 会通过浏览器将文件下载到本地计算机。

```python
from google.colab import files

with open('example.txt', 'w') as f:

  f.write('some content')

files.download('example.txt')
```

**项目运行**  
怎么运行在github上别人的项目呢？

先要把别人的项目和所需的数据集传到自己的谷歌云盘里之后，再用colab执行。  
注意谷歌云盘的免费空间只有15G，如果你的数据集很大，要小心在执行的过程中可能产生一些图片从而导致空间过载，这样会报错的。可以买一个会员，十块钱不到100G，我感觉还是比百度云那种限速的好用多了.

1.挂载谷歌云，刚才讲过了

```bash
from google.colab import drive
drive.mount('/content/gdrive')
```

2.转到要处理的项目地址

```bash
import os
os.chdir("/content/gdrive/My Drive/3dclassification/3DUnetCNN-master")
```

3.安装好所需要的库  
用`pip`命令一个一个安装也行，不过大部分项目都有requirements.txt文件，你可以直接

```bash
! pip install -r requirements.txt
```

一次性安装好所有要求的库。  
4.执行项目程序

```bash
! python train.py
```

训练网络

```bash
! python evaluate.py 
```