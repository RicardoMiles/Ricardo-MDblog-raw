# matplotlib两种画图区别

New approach to draw charts

```Python
fig, ax = plt.subplots()
```

compared with previous approach provided by ChatGPYT

```python
plt.plot(data)
```

Difference and their own goings:

### 区别：

1. **`plt.plot()` 方法：**
   - 这是 Matplotlib 的高级接口，简化了绘图的步骤。在大多数情况下，它非常方便，尤其是当你只需要快速绘制简单的图时。
   - 它直接调用 `matplotlib.pyplot` 中的各种快捷方式函数，如 `plt.plot()`、`plt.title()`、`plt.xlabel()` 等等，这些函数会在后台自动创建图形和轴对象，无需手动创建。
2. **`fig, ax = plt.subplots()` 方法：**
   - 这是 Matplotlib 的面向对象（OO）接口，提供了更多控制和灵活性。
   - `fig` 是图形对象，`ax` 是轴对象。通过这种方式，你可以对图表的细节进行更精确的控制，比如设置多子图、调整布局等。
   - 面向对象的方法更适合复杂的图形绘制或多个图形对象的管理。

### 好处和区别：

- **简单性（`plt.plot()`）**：
  - `plt.plot()` 是 Matplotlib 的简化接口，适用于简单的、快速的绘图需求。
  - 不需要显式创建 `fig` 和 `ax` 对象，代码更简洁。
  - 如果你只需要创建一个简单的折线图，这种方法通常是首选。
- **灵活性（`fig, ax = plt.subplots()`）**：
  - `plt.subplots()` 方法提供了更大的灵活性，适合复杂图表的绘制，例如你想要添加多个子图或对轴、图形进行更多自定义设置时。
  - `ax` 是轴对象，你可以通过它设置许多细节，如调整刻度、标题、标签、子图布局等。这在需要对图形的布局和样式进行精细调整时非常有用。
  - 如果你计划创建多个子图、共享轴、或者想要在同一个绘图区域内进行更复杂的操作，这种面向对象的方法是更好的选择。

### 具体示例：

- **简单绘图（`plt.plot()`）**：
  
  ```
  python复制代码plt.plot(data)
  plt.title("Simple Line Plot")
  plt.show()
  ```
  
  - 这种方式适用于简单绘图，快速方便。

- **复杂绘图（`plt.subplots()`）**：
  
  ```
  python复制代码fig, ax = plt.subplots()
  ax.plot(data)
  ax.set_title("Line Plot with Object-Oriented Approach")
  ax.set_xlabel("Time")
  ax.set_ylabel("Rainfall")
  plt.show()
  ```
  
  - 这种方式让你可以更精确地控制图表，适合复杂或需要多子图的场景。例如，如果你想要绘制多个子图，可以这么做：
  
  ```
  python复制代码fig, (ax1, ax2) = plt.subplots(1, 2)  # 创建两个子图
  ax1.plot(data)
  ax2.plot(data * 2)
  plt.show()
  ```

### 总结：

- 如果你需要快速生成简单的图表，`plt.plot()` 是一个快捷方式，简单直观。
- 如果你需要对图表进行更多控制（比如创建多子图、定制化标签、刻度、图形布局等），`fig, ax = plt.subplots()` 提供了更灵活的接口和更多功能。