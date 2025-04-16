---
title: The simplest UE-VSCode workflow
date: 2025-04-16 15:58:59
categories:
  - Coding
tags: 
- Handy-Trick
- CPP
- Unreal
excerpt: Unreal Engine lightest editor workflow share.
---

## Windows

* Install VSCode and Unreal Engine
* Install MSVC and .net framework SDK 4.8.1
* Install C/C++ and C# dev kit in VSCode extension
* Create a new C++ project with Unreal GUI,  change editor preference in the GUI
* Choose source code editor to Visual Studio Code, then restart the Unreal Editor
* Refresh or Generate Visual Studio Code project in Tool Panel of Unreal Editor
* Double click the `MyProject.code-workspace ` file in the project folder, VSCode will open the project automatically
* Build and Compile the project in VSCode Run&Debug Panel, choose the `Launch MyProjectEditor (Development)(Workspace)` to call Unreal Engine Editor

### Source Code Editor Choice

We create a C++ project at first because it is the only way we can get entry of editor preference.

![Image](https://github.com/user-attachments/assets/3dea22f2-fa6e-4a46-9918-740cd9c2d4e0)

![Image](https://github.com/user-attachments/assets/70d40f33-a02b-4ba1-a25e-fc09026b1677)

![Image](https://github.com/user-attachments/assets/a1b9e3db-4cb1-4bf7-9b30-abb40590f6bc)

Step-by-step operation is shown above.

### MSVC and Dotnet 4.8.1 SDK

The best way to get them is using Visual Studio Installer. There is no independent package we can get in 2025 from Microsoft official site. 

Choose the component MSVC latest instead of full installation of C++ desktop dev kit. Same as dotnet

### MSVC activation

Add the MSVC compiler to PATH, we need manually add it to PATH bc most of the time the script doesn't work. Also, if we use the script in buildtool folder, we need to repeat it again and again.

## macOS

