### 导出为 requirements 文件

如果你想保存或分享环境配置：

```
pip freeze > requirements.txt
```

文件内容示例：

```
numpy==1.26.4
pandas==2.2.2
requests==2.32.3
```

然后你可以在别的环境中用：

```
pip install -r requirements.txt
```

来完全复现环境。