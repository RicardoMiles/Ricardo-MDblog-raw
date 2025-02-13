---
title: Python Distribution Packaging
date: 2025-02-13 01:32:25
tags:
 - CS Learning
 - Python
 - SLA
categories:
 - Coding
excerpt: "Two common methods to package a Python program into a cross-platform application"
---

When I developed a Python GUI application, I found it is trivial for users who do not have Python installed. This guide share a step-by-step process of converting my Python script into a standalone executable and distributing it efficiently.

Also, it provides two way to build Linux & macOS & Windows applications from Python script.

---

## PyInstaller

### **Step 1: Installing PyInstaller**

PyInstaller, a widely used tool for bundling Python applications.

First, install PyInstaller using pip:

```
pip install pyinstaller
```

---

### **Step 2: Creating an Executable**

Navigate to the directory where your script is located and run the following command:

```
pyinstaller --onefile --noconsole your_script.py
```

#### **Explanation of Options:**

- `--onefile`: Packages everything into a single `.exe` file.

- `--noconsole`: Prevents a terminal window from appearing (useful for GUI apps).

Once the process completes, you’ll find a `dist` folder containing the generated `.exe` file.

---

### **Step 3: Including a Custom Icon (Optional)**

Add an icon to application, prepare an `.ico` file and run:

```
pyinstaller --onefile --noconsole --icon=your_icon.ico your_script.py
```

This will embed the icon into the executable.

---

### **Step 4: Locating the Output File**

After PyInstaller completes, there is two new folders in the directory:

- `build/`: Temporary files used during the packaging process (you can ignore this).

- `dist/`: Contains the final `.exe` file that will be distributed.

The only file need to be released is inside the `dist` folder.

### Step 5: Using the `.spec` File for Advanced Configuration

When we package a script with PyInstaller for the first time, it generates a `.spec` file, which contains all the packaging configurations. We can manually edit this file for advanced customization.

#### Generating a .spec File

Run the following command to generate a `.spec` file:

```
pyinstaller --onefile --noconsole your_script.py
```

This will generate a `your_script.spec` file in the current directory.

#### Editing the .spec File

The `.spec` file is a Python script that can be edited directly. Below is an example of a typical `.spec` file:

```python
# your_script.spec
# -*- mode: python ; coding: utf-8 -*-

block_cipher = None

# Adding data files
added_files = [
    ('data/file1.txt', 'data'),  # Package data/file1.txt into the data directory
    ('images/icon.ico', 'images') # Package images/icon.ico into the images directory
]

a = Analysis(
    ['your_script.py'],  # Main script
    pathex=['/path/to/your/script'],  # Script path
    binaries=[],  # Binary files (e.g., .dll or .so)
    datas=added_files,  # Data files
    hiddenimports=[],  # Hidden imported modules
    hookspath=[],  # Custom hook paths
    runtime_hooks=[],  # Runtime hooks
    excludes=[],  # Excluded modules
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
)

# Package into a single file
pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

# Generate the executable file
exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='your_script',  # Executable name
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,  # Use UPX compression
    console=False,  # Whether to show the console (set to False for Windows GUI applications)
    icon='images/icon.ico',  # Icon file
)

# Package as a folder (optional)
coll = COLLECT(
    exe,
    a.binaries,
    a.zipfiles,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name='your_script',  # Output folder name
)
```

#### Repackaging

After modifying the `.spec` file, run the following command to repackage:

```bash
pyinstaller your_script.spec
```

#### Adding Data Files

If the application requires additional data files (such as images, configuration files, etc.), we can add them in the following ways:

1. Use the `--add-data` parameter to specify data files:

```bash
pyinstaller --onefile --noconsole --add-data "data/file1.txt:data" your_script.py
```

- `data/file1.txt` is the source file path.

- `data` is the destination path in the packaged executable (relative to the executable file).
2. Using the .spec File

Add the `datas` parameter in the `Analysis` section of the `.spec` file:

```python
added_files = [
    ('data/file1.txt', 'data'),  # Package data/file1.txt into the data directory
    ('images/icon.ico', 'images') # Package images/icon.ico into the images directory
]

a = Analysis(
    ['your_script.py'],
    datas=added_files,  # Adding data files
    ...
)
```

#### Handling Hidden Imports

If PyInstaller fails to detect certain modules (e.g., dynamically imported modules), you can manually add them as follows:

1. Using the Command Line

Use the `--hidden-import` parameter to specify hidden imports:

```bash
pyinstaller --onefile --noconsole --hidden-import=module_name your_script.py
```

2. Using the .spec File

Add the `hiddenimports` parameter in the `Analysis` section of the `.spec` file:

```Python
a = Analysis(
    ['your_script.py'],
    hiddenimports=['module_name'],  # Adding hidden imports
    ...
)
```

#### Excluding Unnecessary Modules

To reduce the size of the executable file, you can exclude unnecessary modules:

1. Using the Command Line

Use the `--exclude-module` parameter to exclude modules:

```
pyinstaller --onefile --noconsole --exclude-module=unnecessary_module your_script.py
```

2. Using the .spec File

Add the `excludes` parameter in the `Analysis` section of the `.spec` file:

```
a = Analysis(    ['your_script.py'],    excludes=['unnecessary_module'],  # Exclude unnecessary modules    ...)
```

## **cx_Freeze**

cx_Freeze is a popular alternative to PyInstaller for converting Python scripts into standalone executables. It is cross-platform (supports Windows, macOS, and Linux) and is relatively easy to use. 

---

### **Step 1: Install cx_Freeze**

First, you need to install cx_Freeze using pip:

```bash
pip install cx_Freeze
```

---

### **Step 2: Basic Usage**

The simplest way to use cx_Freeze is to run it directly from the command line. Navigate to the directory containing your Python script and run the following command:

```bash
cxfreeze script_name.py --target-dir dist
```

#### **Explanation:**

- `script_name.py`: The entry point of application (the main script).

- `--target-dir dist`: Specifies the output directory where the executable and associated files will be placed. In this case, the output will be in a folder named `dist`.

After running the command, cx_Freeze will:

1. Analyze the script and its dependencies.

2. Bundle everything into an executable along with the necessary Python interpreter and libraries.

3. Place the output in the `dist` directory.

---

### **Step 3: Advanced Configuration with `setup.py`**

For more control over the packaging process by using a `setup.py` script: 

This is especially useful if the application has additional data files, dependencies, or requires specific configurations.

#### **Example `setup.py` Script:**

```python
from cx_Freeze import setup, Executable

# Define the base (Windows GUI applications should use "Win32GUI" instead of "Console")
base = None
# Use "Win32GUI" for Windows GUI applications to avoid opening a console window
# base = "Win32GUI"  # Uncomment this line for Windows GUI apps

# List of executables to create
executables = [
    Executable(
        script="your_script.py",  # Your main script
        base=base,               # Base type (Console or GUI)
        target_name="YourApp",   # Name of the output executable
        icon="your_icon.ico"     # Optional: Add an icon (Windows only)
    )
]

# Additional files to include (e.g., data files, images, etc.)
include_files = [
    ("data/", "data/"),  # Include a folder named "data"
    "config.json",       # Include a single file
]

# Packages to include (if cx_Freeze doesn't detect them automatically)
packages = ["os", "sys", "tkinter"]

# Exclude unnecessary packages to reduce the size of the executable
excludes = ["unnecessary_module"]

# Build options
build_options = {
    "packages": packages,
    "excludes": excludes,
    "include_files": include_files,
    "optimize": 2,  # Optimize the bytecode (0 = no optimization, 1 = basic, 2 = full)
}

# Setup configuration
setup(
    name="YourApp",                # Name of your application
    version="1.0",                 # Version number
    description="Your App Description",  # Description
    options={"build_exe": build_options},  # Build options
    executables=executables        # List of executables to create
)
```

#### **Explanation of the `setup.py` Script:**

- **`Executable`**: Defines the main script and options for the executable (e.g., name, icon, base type).

- **`include_files`**: Specifies additional files or folders to include in the build (e.g., data files, images, configuration files).

- **`packages`**: Explicitly lists Python packages to include (useful if cx_Freeze doesn't detect them automatically).

- **`excludes`**: Lists unnecessary packages to exclude to reduce the size of the executable.

- **`build_options`**: Configures the build process (e.g., optimization level, included files, excluded packages).

---

### **Step 4: Build the Executable**

Once your `setup.py` script is ready, you can build the executable by running:

```bash
python setup.py build
```

This will create a `build` directory containing the executable and all necessary files. The structure will look something like this:

```bash
build/
└── exe.<platform>-<python_version>/
 ├── YourApp.exe # The executable
 ├── lib/ # Bundled Python libraries
 ├── data/ # Included data files
 └── ... # Other dependencies
```

---

### **Step 5: Customizing the Build**

#### **1. Adding an Icon (Windows Only)**

To add an icon to your executable, specify the `icon` parameter in the `Executable` object:

```python
executables = [
 Executable(
 script="your_script.py",
 base=base,
 target_name="YourApp",
 icon="your_icon.ico" # Path to your .ico file
 )
]
```

#### **2. Including Hidden Imports**

If cx_Freeze misses some dependencies (e.g., dynamically imported modules), you can explicitly include them using the `packages` or `include` options:

```python
build_options = {
 "packages": ["numpy", "pandas"], # Explicitly include packages
 "include": ["hidden_module"], # Include dynamically imported modules
}
```

#### **3. Excluding Unnecessary Modules**

To reduce the size of the executable, exclude unnecessary modules:

```python
build_options = {
 "excludes": ["tkinter", "unnecessary_module"],
}
```

---

### **Step 6: Cross-Platform Builds**

cx_Freeze can create executables for different platforms, but you need to build on the target platform. For example:

- To build a Windows executable, run cx_Freeze on Windows.

- To build a macOS executable, run cx_Freeze on macOS.
