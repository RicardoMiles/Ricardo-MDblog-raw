---
title: The simplest UE-VSCode & UE&XCode workflow
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
* Refresh or Generate Visual Studio Code project in Tool pane of Unreal Editor
* Double click the `MyProject.code-workspace ` file in the project folder, VSCode will open the project automatically
* Build and Compile the project in VSCode Run&Debug pane, choose the `Launch MyProjectEditor (Development)(Workspace)` to call Unreal Engine Editor

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
### XCode
We can open the project folder in Xcode, when we create a project at first time, the Xcode will be called to open the project. The linker function between Xcode Call and Unreal Project creation is fine. However, there are issues with Unreal Engine project generation with Xcode. Xcode will face build failure or UnrealEditor calling failure. We have to manually change the run scheme setting. Edit scheme setting by `Product` pane on the top, then `scheme` - `edit scheme` in the drop-off menu.
* Change Scheme Executable to `UnrealEditor.app`，
* Change Working Directory - `ProjectName/` (By specifying it to custom)
* Arguments 包含 `ProjectName.uproject` (Absolute Path)

#### Executable Modification

Click the `Info` pane of `Run` section.

The default executable file linked by Unreal Engine Xcode Project generator is always wrong, it will be `ProjectName.app`. Actually, there is no application on our MacBook laptop called `ProjectName.app`, the executable we wanna call is always `UnrealEditor.app`.

But we ought to avoid choosing the `UnrealEditor.app` in the drop-down menu(Example Shown in screenshot below), because it will use Relative Path which leads to failure of calling Editor.

<img width="1512" alt="Image" src="https://github.com/user-attachments/assets/f0b188f0-6f71-427c-a5fe-c2b9b95ee8a4" />

Instead, we should choose the `UnrealEditor.app` by manually locating its installed Path or Finder GUI. Then we specify the `Location` option to `Absolute Path`.

<img width="1512" alt="Image" src="https://github.com/user-attachments/assets/0f0dd8d8-6dc4-4e13-a622-f51fb2ab4cc7" />

#### Working Directory Modification
<img width="1512" alt="Image" src="https://github.com/user-attachments/assets/dcf570a8-e744-4f61-87d4-085d563ef5ff" />
Click the `Option` pane of `Run` section, do modification as shown above.

Click the `Use custom working directory` first, then copy and paste the absolute path of Project Folder.


#### Argument pane Modification

<img width="1512" alt="Image" src="https://github.com/user-attachments/assets/47c9a629-e1bf-4d74-974a-633f20824dcf" />

Click the `Argument` pane of `Run` section, do modification as shown above. Copy the absolute path of `ProjectName.uproject`, leave the
`Expand Varaible By` as `None`.

### VSCode
Auto-generated VSCode projects have issues on macOS, no matter with Apple Silicon or Intel Chip, no matter choosing `Refresh VSCode Project` option (after we update source code editor preference for UE) or  choosing `Generate VSCode Project` option in a C++ UE projcet from scratch.

The project could be generated or refreshed, the workspace file always call Xcode tho. And we couldn't do compile, build or debugging inside VSCode to call the UnrealEditor. The whole workspace file for VSCode was empty... The resolution to link VSCode and UE for a workflow is totally different from the solution on Windows.

I even copy the project generated on Windows platform, the workspace file could call VSCode smoothly while all the linking in the file is specified to Windows. I gave up eventually after install mono and tried to generate again. It turns out to be that UE5.5 can't generate VSCode Project properly.
