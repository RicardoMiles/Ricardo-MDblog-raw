# Q1

> I can open my project again by double-clicking the `.uproject` file, but I still can't launch it properly from Xcode without manually fixing the scheme each time.
>
> My questions are:
>
> 1. Why is the automatically generated scheme always broken like this?
> 2. Why do I have to manually delete the cache, regenerate the project files, rebuild the modules, and then fix the scheme every time after I change a `.cpp` file?
> 3. Why does the build fail every time I make changes to the code?
> 4. Should I actually be launching the `BabyDemo` or the `BabyDemoEditor` target in Xcode?

------

##  Answer：

###  1. 为什么自动生成的 scheme 一直有问题？

因为 **Unreal 的 `GenerateProjectFiles.sh` 脚本并不会正确设置好 Xcode 的 scheme 里的 Executable、Arguments、Working Directory。**

- 它只是生成 `.xcodeproj` 文件，没有配置调试信息。
- Xcode 默认假设我是 Mac 平台的普通 App（比如 iOS 项目），所以它会把 `Executable` 设成 `BabyDemo.app`，而不是 `UnrealEditor.app`。
- 但 Unreal 的 C++ 项目 **运行时是依赖 UnrealEditor + .uproject**，而不是独立的 `.app`。

这不是我操作错，是 Unreal 本身生成 Xcode 文件这部分设计不完善。

------

###  2. 为什么每次改 cpp 就需要手动清理、重新生成项目、手动编译 module？

不应该每次都要清理。

但出现这种情况的可能原因是：

- 修改了 `.h` 头文件，尤其是带 `UCLASS()`、`USTRUCT()`、`UFUNCTION()`、`UPROPERTY()` 这些宏时，**必须重新运行 `UnrealHeaderTool`（UHT）**。
- `Intermediate/` 里生成的 `.gen.cpp` 是基于我的头文件的，如果这个被搞乱了（例如中途断电、Unreal 卡死），就会导致后续 Build 出错。
- `GenerateProjectFiles.sh` 不会主动帮我跑 UHT，只有 Build 的时候才会自动跑。

⚠ 如果我改的是 `.cpp` 里普通函数，不涉及 UPROPERTY/UFUNCTION，那么理论上不需要重建。

------

###  3. 为什么一改动就 Build 失败？

主要是：

- Unreal 的 `UHT` 生成的 `.gen.cpp` 和 `.generated.h` 文件在 `Intermediate/` 里。
- 改动头文件后，如果这些不匹配，就会导致各种奇怪的编译错误。
- **尤其是改了类名、加了新的 `UCLASS()`，如果旧的 `Intermediate/` 没更新，就会导致找不到类、符号未定义等问题。**

------

###  4. 到底应该启动 `BabyDemo` 还是 `BabyDemoEditor`？

正确答案：**我应该启动 `BabyDemoEditor`**。

- `BabyDemo` 是用来 build 我的游戏的 Shipping 版本（如果要打包最终可执行程序）。
- `BabyDemoEditor` 是专门为 UnrealEditor 编译的模块，用来和 Unreal Editor 一起运行（开发用的 Debug/Development 版本）。
- 我改 C++ 后编译的 `dylib` 是 `BabyDemoEditor.dylib`，所以要启动 Editor。

------

## Easier Develop Workflow：

1. 改 `.cpp` 文件 → 直接 Build 不用清理。

2. 如果改了 `.h` 头文件带 `UCLASS()` / `USTRUCT()` → 推荐：

   - 先关闭 Unreal Editor。

   - 跑：

     ```bash
     ./Build.sh BabyDemoEditor Mac Development "/Users/puhonghan/Desktop/BabyDemo/BabyDemo.uproject"
     ```

3. 只需要在第一次设置好 Xcode Scheme：

   - Executable: `UnrealEditor.app`
   - Arguments: `"/Users/puhonghan/Desktop/BabyDemo/BabyDemo.uproject"`
   - Working Directory: 手动设置为项目路径（不是默认的变量）。

4. 之后只需要 Build → Run，不需要每次都 Generate Project Files。



# Q2

> From the Finder view, there is no such thing as `BabyDemoEditor` — this seems to be something that only exists in Xcode’s structure. Why is that?

------

## Answer：

完全正确！

- **在磁盘（Finder）层面，确实没有 `Source/BabyDemoEditor/` 这个文件夹**。
- 这个 `BabyDemoEditor` 是 **Xcode 里的 Target（目标），不是物理上的文件夹**。

------

### 为什么 Xcode 里会有 `BabyDemoEditor` 这个 Target？

因为 **Unreal Engine 会自动为我的项目生成两个 Target**：

1. **`BabyDemo` → 游戏模块（Game module）**
   - 这是我的游戏逻辑代码、角色、控制器、Actor 的编译目标。
   - 对应 `BabyDemo.Build.cs`。
2. **`BabyDemoEditor` → 编辑器模块（Editor module）**
   - 这个模块是给 Unreal Editor 用的，目的是为了：
     - 把我的 `BabyDemo` 模块编译成一个插件，挂载进 UnrealEditor。
     - 让我的游戏模块能在 UnrealEditor 里工作（不是 standalone app）。
   - 对应 `BabyDemoEditor.Target.cs`（注意是 `Target.cs` 不是 `Build.cs`）。
   - 它不会有 `Source/BabyDemoEditor/` 这种路径，除非我自己手写 editor 插件。

**但即使没有这个文件夹，`BabyDemoEditor` 这个 Target 会在编译时调用 `BabyDemo` 的代码！**
 只是在 Xcode 里，它显示成了两个不同的 Target。

### 为什么 Finder 里没有 `BabyDemoEditor` 文件夹？

- Unreal Engine 默认只有 `Source/BabyDemo/`。

- `BabyDemoEditor.Target.cs` 只是告诉 Unreal：

  > “帮我生成一个 Editor 模块，把 `BabyDemo` 编译进 Unreal Editor 里。”

并不会自动创建 `Source/BabyDemoEditor/` 这个物理文件夹。

**如果我真的写 Editor 扩展（比如自定义蓝图节点、编辑器工具栏按钮），我自己才会创建这个目录。**
 普通 gameplay 开发完全不需要。

------

## Target, Module and Code

| 看起来是两个 Target                    | 实际上都编译的是 `Source/BabyDemo/` 里的代码       |
| -------------------------------------- | -------------------------------------------------- |
| `BabyDemo` → 打包 standalone 游戏      | 编译我的 Game 逻辑代码                             |
| `BabyDemoEditor` → 给 Unreal Editor 用 | 也是编译我的 Game 逻辑代码（+ 可能的 Editor 扩展） |

------

**Target → Module → 文件夹结构的关系图**



# Q3

> Where should I modify my project code? `BabyDemo` or `BabyDemoEditor`?
>
> Which scheme should I build and run to test? `BabyDemo` or `BabyDemoEditor`?

---

## Answer：

1. **我写代码（修改、添加） → 都是在 `Source/BabyDemo/` 里**
    （不管我选 Xcode 侧栏的 `BabyDemo` 还是 `BabyDemoEditor`，写代码的地方永远是 `Source/BabyDemo/`）
2. **编译 & 测试（Play 运行） → 必须选择 `BabyDemoEditor` 这个 Target**
    因为：
   - `BabyDemo` Target 编译出来的是 standalone 游戏（打包成一个 .app）。
   - `BabyDemoEditor` Target 编译出来的是给 UnrealEditor 用的模块（`.dylib`），只有这个能被 UnrealEditor 加载。

------

## Summary

> **写代码 → `Source/BabyDemo/`**
>  **编译测试 → 选择 `BabyDemoEditor` Target → Build → Run（唤起 UnrealEditor）**

我在 Xcode 侧栏里看到 `BabyDemo` 和 `BabyDemoEditor` 只是 Target（工程配置），
 不影响我写代码的位置（写代码的位置永远是 `Source/BabyDemo/`）。

 【图示理解】：

```
Xcode Targets:
 ├── BabyDemo           → 打包游戏 (Shipping)
 └── BabyDemoEditor     → 开发阶段，在 UnrealEditor 里测试

代码位置：
 /Source/BabyDemo/
    ├── BabyDemoGameMode.cpp
    ├── BabyDemoCharacter.cpp
    ├── MyPlayerController.cpp
    └── ...（我的所有 C++ 类）
```

误区提醒：

- **不是在左边 Xcode 侧栏选择哪个 folder 来控制 build！**
- 是我上方的 **Scheme 选择 `BabyDemoEditor`（靠近 Run/Stop 按钮那里）**。

# Q4

> I figured it out — when I ran the build manually in the terminal, the error message told me that I was including a class I had already deleted. After removing that `#include` line, the problem was solved.
>  However, my question is: why do the classes I create through Unreal Editor’s GUI automatically appear in Xcode, but if I manually create `.cpp` and `.h` files using `vim` in the terminal, they don’t show up in Xcode’s project folder?

------

## Answer：

### 为什么用 Unreal Editor GUI 新建的类，会自动出现在 Xcode 里？

因为 **Unreal Editor 在我点击“Add New C++ Class”时：**

1. **会自动写入这些文件到 `Source/BabyDemo/`**。
2. **同时会自动更新我的 `.uproject` 文件和 `.xcodeproj` 工程文件**（触发了 `GenerateProjectFiles.sh`）。

所以 **新加的文件就被 Xcode 工程识别了**，并且会显示在左侧的 Project Navigator 里。

------

### 为什么手动用 `vim` 新建 `.cpp` / `.h` 文件，Xcode 里看不到？

因为 **Xcode 工程文件（`.xcodeproj`）并不会自动监控磁盘上的新文件。**
 手动加的文件，除非我手动拖到 Xcode 里，或者重新跑 `GenerateProjectFiles.sh`，否则不会被加进工程索引。

Unreal 的 `GenerateProjectFiles.sh` 脚本会：

- 读取 `.uproject` 里的模块（`*.Build.cs`）
- 遍历 `Source/` 目录
- 更新 `.xcodeproj`

如果我只在 Finder 或终端新建，没有告诉 Xcode 这个文件存在，Xcode 就不会知道。**

------

### 手动新建 C++ 文件后，怎么让 Xcode 识别？

我有两个选择：

方式 1（手动拖拽）：

- 在 Xcode 左侧 Project Navigator 右键 → `Add Files to "BabyDemo"`
- 把我 `vim` 写好的 `.h` 和 `.cpp` 文件拖进去。

方式 2（推荐）：重新生成 Xcode 工程文件：

```bash
/Users/Shared/Epic\ Games/UE_5.5/Engine/Build/BatchFiles/Mac/GenerateProjectFiles.sh -project="/Users/puhonghan/Desktop/BabyDemo/BabyDemo.uproject"
```

这样：

- 我新写的 `.cpp` / `.h` 就会被加进 `.xcodeproj`。
- Xcode 里的索引自动更新。

------

### 为什么 UnrealEditor GUI 能做到这一点？

因为 GUI 新建 C++ 类的时候，Unreal **不仅创建文件，还调用了 `GenerateProjectFiles` 自动刷新 Xcode 工程。**
 手动写是纯磁盘操作，没触发工程刷新。

------

## Summary

| 创建方式                 | 是否自动出现在 Xcode 工程里？                            |
| ------------------------ | -------------------------------------------------------- |
| Unreal Editor GUI 新建   | ✅ 是，自动刷新 `.xcodeproj`                              |
| 手动 `vim` / Finder 新建 | ❌ 否，除非我手动拖入 Xcode 或重新 Generate Project Files |



# Q5

> If I’ve only modified an existing class’s `.h` and `.cpp` files — for example, `ProjectNameCharacter.h` and `ProjectNameCharacter.cpp` in the Third Person template — can I just compile and run the project directly?

------

## Answer:

### 是的，我可以直接编译运行。

 只要我没有做这些事：

- 没新建类
- 没修改 `.Build.cs` 或 `.Target.cs`
- 没删模块、换模块名

那么我只需要：

------

### 正确的操作流程

如果我只是改了 `.cpp` 文件（例如加逻辑）：

- 可以直接在 Xcode 里 Build（`Cmd + B`）或手动用命令行 `Build.sh` 编译。
- 编译成功后，直接用 Unreal Editor 打开 `.uproject` → 点击 `Play` 进行验证。

如果我还改了 `.h` 文件（例如加了新的 UFUNCTION、UPROPERTY）：

- Unreal 会在编译时调用 `UnrealHeaderTool`（UHT）自动生成 `.gen.cpp` 文件。
- 所以只要我通过 **完整的 `Build.sh BabyDemoEditor`** 编译就没问题。
- **不需要重新生成 `.xcodeproj`**，也不需要删缓存，除非遇到报错。

### 注意事项：



| 改动类型                            | 需不需要重启 Unreal Editor？ | 需不需要重新生成项目文件？      |
| ----------------------------------- | ---------------------------- | ------------------------------- |
| 改 `.cpp` 逻辑代码（无新类）        | ❌ 不需要                     | ❌ 不需要                        |
| 改 `.h`（含 UFUNCTION / UPROPERTY） | ✅ 推荐重启 Unreal Editor     | ❌ 不需要                        |
| 新增 C++ 类                         | ✅ 推荐重启 + Rebuild         | ✅ 需要重新 GenerateProjectFiles |

------

### 建议操作顺序（通用流程）：

1. 修改 `.cpp` / `.h` 文件

2. 终端运行：

   ```bash
   ./Build.sh BabyDemoEditor Mac Development "/Users/xxx/YourProject.uproject"
   ```

3. 成功后 → 双击 `.uproject` 打开 Unreal Editor（或 Xcode 启动 `BabyDemoEditor` Scheme）

4. 点 `Play` 验证效果

------

如果我想验证是否真的生效，可以在 `BeginPlay()` 加个 `UE_LOG`，例如：

```cpp
UE_LOG(LogTemp, Warning, TEXT("MyCharacter BeginPlay triggered!"));
```

# Q6

> If I’ve only modified an existing class’s `.h` and `.cpp` files — for example, `ProjectNameCharacter.h` and `ProjectNameCharacter.cpp` in the Third Person template — can I just compile and run the project directly?
>
> - 我已经正确取消了：
>   - `CameraBoom->bUsePawnControlRotation = false;`
>   - `LookAction` 也注释掉了（鼠标不再控制 Controller 旋转）。
> - 我已经改了 `Move()`，不再用 `Controller->GetControlRotation()`。
>
> **但是为什么摄像头（CameraBoom + FollowCamera）还在转？**

## Answer:

------

### 真正的原因：

> **`CameraBoom` 默认的 `bInheritPitch`, `bInheritYaw`, `bInheritRoll` 都是 `true`！**
>  这会导致 **即使不跟随 Controller，CameraBoom 也跟随 `Pawn` 自身的旋转（因为是挂在 `RootComponent` 上的）**。

所以：

- 角色一转身（因为 `bOrientRotationToMovement = true;`），
- `CameraBoom` 就继承了角色的 `Yaw` 旋转，
- 我的摄像头还是在动。

------

### 解决方法（最关键的补丁）：

在我的 **`ABabyDemoCharacter::ABabyDemoCharacter()`** 构造函数里加：

```cpp
// 关键补丁：阻止摄像机臂继承角色旋转
CameraBoom->bInheritPitch = false;
CameraBoom->bInheritYaw   = false;
CameraBoom->bInheritRoll  = false;
```

**这一句才是让摄像机不跟着角色转的核心！**

------

### 修改后的构造函数核心部分应长这样：

```cpp
// 摄像机臂不跟随控制器
CameraBoom->bUsePawnControlRotation = false;

// 摄像机臂不继承角色的旋转
CameraBoom->bInheritPitch = false;
CameraBoom->bInheritYaw   = false;
CameraBoom->bInheritRoll  = false;
```

------

## 验证效果：

- **角色转向（WSAD）✅**
- **摄像机完全不转 ✅**
- **画面保持不动 ✅**



# Q7

> I am working on an Unreal C++ game project in Xcode. During execution, it suddenly stopped for no apparent reason. The Unreal Editor remained open, but Xcode switched focus and showed the `ObjectPtr.h` file, with a green line displaying `Thread 5: breakpoint 3.1 (1)`.
>  The issue is that I didn’t set any breakpoints or do anything that should have caused this.

## Answer

### Possible Pitfalls

这种情况可能是因为：

1. **Unreal 的源码里本身带有断点**
    有时候 Unreal 引擎的某些内部检查会在源码里用 `ensure()`、`check()` 或类似机制，如果条件不满足，可能会触发断点（即使我自己没有设断点）。
2. **崩溃或非法内存访问触发了调试器**
    比如空指针解引用、访问非法内存区域，Xcode 会自动帮我停在崩溃位置（可能是 `ObjectPtr.h` 里的某个函数或模板）。
3. **线程问题（Thread 5）**
    这说明是在多线程环境中，某个线程（不是主线程）遇到了问题。可能是后台线程做了某个非法操作。
4. **日志检查**
    可以在 Unreal Editor 的 Output Log 或 Xcode 的 debug console 里看有没有更具体的报错或警告。

## Case Specifies Analysis

> The execution stopped at
>  `if (!IsObjectHandleTypeSafe(ObjectPtr.GetHandle()))`.
>  On the left side of Xcode, it shows the following call stack:

![Image](https://github.com/user-attachments/assets/4a013ce8-0a0b-4001-b5d1-86ea77d25b1c)

这次断在了 **`IsObjectHandleTypeSafe`**，这是 Unreal 引擎的内部对象安全检查。

- 这通常说明：**`ObjectPtr` 里的句柄 (`Handle`) 不合法** 或者 **已经被销毁（invalid / stale pointer）**。
- Unreal 使用 `TObjectPtr` 来做垃圾回收安全的指针管理，`GetHandle()` 返回一个句柄（handle），如果 handle 是悬空（dangling）或类型不对，就会在这里断。

**我的调用栈：**

```cpp
ABabyDemoCharacter::Move
EnhancedInputUnifiedDelegate
UEEnhancedPlayerInput::EvaluateInputDelegates
```

说明是在我的 **`Move()`** 函数里触发了这个问题，很可能是：

1. **我在 `Move()` 里访问了一个已经被销毁或未初始化的 UObject。**
2. **这个对象是通过 `TObjectPtr` 管理的，但是它已经失效。**

------

### 可能的排查方向

- 检查我 `ABabyDemoCharacter::Move()` 函数里：
  - 有没有访问 `nullptr`？
  - 有没有用 `TObjectPtr<MyActor>` 或类似的指针？
  - 有没有调用 `.Get()` 或 `GetHandle()` 时，这个对象其实已经不在场景中了？
- 检查这个对象是否是 **`Blueprint`** 实例出来的，某些情况下蓝图会在销毁过程中被尝试访问。

### My Move() Function

```cpp
void ABabyDemoCharacter::Move(const FInputActionValue& Value)
{
    FVector2D MovementVector = Value.Get<FVector2D>();

    if (Controller != nullptr)
    {
        const FVector ForwardDirection = FVector(1.0f, 0.0f, 0.0f);  // 世界 X 轴是前
        const FVector RightDirection   = FVector(0.0f, 1.0f, 0.0f);  // 世界 Y 轴是右

        AddMovementInput(ForwardDirection, MovementVector.Y);
        AddMovementInput(RightDirection, MovementVector.X);
    }
}
```

这是我取代Unreal Third Person模板而写的自定义Move()函数

我的 `Move()` 函数本身逻辑看起来 **没有明显的问题**。
 不过，**`AddMovementInput`** 最终会调用到角色移动组件（`CharacterMovementComponent`）和控制器（`Controller`）的逻辑，可能这些对象存在问题。

### 重点怀疑：

- **`Controller` 指针虽然不是 nullptr，但可能已经被销毁（悬空指针 / Dangling Pointer）**
- Unreal 的 `Controller` 是 `UObject` 类型，我访问它时会用 `TObjectPtr` 机制，这正是我之前断在 `IsObjectHandleTypeSafe()` 的原因。

------

### 尝试排查：

1. **在 `if (Controller != nullptr)` 这一行，换成更安全的检查：**

   ```cpp
   if (IsValid(Controller))
   {
       const FVector ForwardDirection = FVector(1.0f, 0.0f, 0.0f);
       const FVector RightDirection   = FVector(0.0f, 1.0f, 0.0f);
   
       AddMovementInput(ForwardDirection, MovementVector.Y);
       AddMovementInput(RightDirection, MovementVector.X);
   }
   ```

   注意：`IsValid()` 不仅检查是否为 nullptr，还检查 UObject 是否已经被标记为 `Pending Kill`。

------

### 为什么这样可能解决问题：

- `Controller != nullptr` 只是判断指针不为空。
- Unreal 的对象即使指针不空，内部可能已经被 `GC` 标记为即将销毁（`Pending Kill`）。
- `IsValid()` 会额外检查这一点，防止访问非法内存。
- 改成 `IsValid(Controller)` 看问题还会不会复现。
- 如果还有问题，可以在 `Move()` 开头 `UE_LOG` 输出一下 `Controller` 的指针地址，以及 `IsValid(Controller)` 的结果，确认到底是不是 Controller 这一块出问题。

## 破案了

重点是 `Controller != nullptr` **不能保证 Controller 这个 UObject 还活着**。
 Unreal Engine 里的 `Controller` 是一个 `UObject`，可能在 GC 过程中已经被销毁，但指针还没有被清空（悬空指针 / dangling pointer）。

这就是为什么我会在 `IsObjectHandleTypeSafe(ObjectPtr.GetHandle())` 那里断掉。

用 `IsValid(Controller)` 替换掉 `Controller != nullptr`。

改成这样：

```c++
void ABabyDemoCharacter::Move(const FInputActionValue& Value)
{
    FVector2D MovementVector = Value.Get<FVector2D>();

    if (IsValid(Controller))
    {
        const FVector ForwardDirection = FVector(1.0f, 0.0f, 0.0f);
        const FVector RightDirection   = FVector(0.0f, 1.0f, 0.0f);

        AddMovementInput(ForwardDirection, MovementVector.Y);
        AddMovementInput(RightDirection, MovementVector.X);
    }
}
```

**为什么这样更安全：**

- `IsValid()` 检查不仅是指针是否为空，还检查：
  - 这个 UObject 有没有被 GC 标记为 “`Pending Kill`”。
  - 如果被标记了，`IsValid()` 会返回 `false`，避免非法访问。

# Q8

> Is the `IsValid()` function built into Unreal Engine, or do I need to implement it myself?

---

## Answer

### No Need to Build that Function Again

**`IsValid()` 是 Unreal Engine 内置函数**，不需要我自己实现。

它定义在：

```cpp
#include "UObject/UObjectGlobals.h"
```

###  Basic Usage of `IsValid()` Function\

```cpp
if (IsValid(SomeUObjectPointer))
{
    // 安全访问这个对象
}
```

### 适用

- `AActor*`
- `UObject*`
- 任何继承自 `UObject` 的类型（`ACharacter`, `AController`, `UActorComponent`, 等等）

# Q9

> I've realised that the reason I fell into this rabbit hole is that I know C++, but actually know nothing about the Unreal API or its features.

## Answer

### 1. **What is `UObject`?**

- `UObject` is the **base class** for most of Unreal Engine's object types.
- All Unreal classes that use features like **Garbage Collection (GC)**, **Reflection**, **Blueprint Integration**, or **Serialization** inherit from `UObject`.
- `AActor` (for game objects) is a subclass of `UObject`.

### 2. **How does Unreal deal with `UObject` lifetime?**

- Unreal uses its **own Garbage Collector (GC)** system, not the manual `delete` and destructors you know from standard C++.
- You almost never `delete` a `UObject` directly.
- If no valid reference remains (including Blueprints, gameplay code, etc.), GC will automatically clean it up.
- When an object is scheduled for destruction, it will be marked as **`Pending Kill`**, and `IsValid()` will return `false` even if the pointer is not `nullptr`.

### 3. **How is this different from normal C++ OOP?**



| Feature               | Normal C++                                          | Unreal `UObject` System                                      |
| --------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| Memory Management     | Manual `new` / `delete`                             | Automatic Garbage Collection                                 |
| Reflection / Metadata | Usually absent or via templates/macros              | Built-in Reflection System (`UCLASS`, `UPROPERTY`, etc.)     |
| Type Safety           | `dynamic_cast` for RTTI (Run-Time Type Information) | `Cast<T>()`, Reflection-based casting                        |
| Object Creation       | `new` / `malloc`                                    | `NewObject<T>()`, `SpawnActor<T>()`                          |
| Destruction           | Destructor                                          | `BeginDestroy()`, `ConditionalBeginDestroy()`, GC handles cleanup |

### **4. What is `AActor`**

- **`AActor` is the base class for all gameplay objects that can be placed or spawned in the level/world.**
- In Unreal, **everything that exists in the game world (visibly or invisibly)** is usually an `AActor` or a subclass of `AActor`.

| Class                            | What it represents                                           |
| -------------------------------- | ------------------------------------------------------------ |
| `ACharacter`                     | A character with movement and collision (like your player)   |
| `APawn`                          | A controllable actor (but may not have character logic)      |
| `AStaticMeshActor`               | An actor with a static mesh (for placing objects like cubes, walls, props) |
| `AController`                    | Controls a `Pawn` (e.g., AIController, PlayerController)     |
| `ASkyLight`, `ADirectionalLight` | Environment lights (they are also Actors!)                   |
| `ATriggerBox`                    | A trigger area in the world                                  |

## Summary

- `UObject` is Unreal's version of "base object" with built-in memory management and metadata.
- Lifetime is controlled by Unreal’s **Garbage Collector**, not manual `delete`.
- Unreal OOP is **C++ plus reflection and GC** — it feels familiar but has extra safety and automation layers.





# Q10

> 我现在鼠标点击地面只实现朝那个方向转身啊，人物没有调用Move()方法吗？
> **鼠标点击了地面 → 角色转身了，但没有真正走过去（没有位移）**。

------

## Answer

### Reason

原因是我用了：

```cpp
ControlledPawn->AddMovementInput(Direction, 1.0f);
```

* 这个 `AddMovementInput()` 只是给 Character Movement Component 一个方向，它需要 **每一帧持续调用** 才能走过去（相当于一直按着方向键）。

* 但我的 `HandleMouseClick()` 逻辑只在点击的那一帧调用了一次。
* **没有持续给力，所以只转了个身，没走。**

### 解决思路

我需要：

- 存一个 **目标位置（TargetLocation）**。
- 每帧去判断：**当前位置 → 目标位置**，如果还没到，就持续 `AddMovementInput()`。
- 到了就停。

| 状态              | 行为                  |
| ----------------- | --------------------- |
| 点击地面          | 记录目标位置          |
| 每帧判断 → 还没到 | 持续 AddMovementInput |
| 到了              | 停止移动              |

### 原先的逻辑

在原来的 `Move()` 函数

```cpp
void ABabyDemoCharacter::Move(const FInputActionValue& Value)
{
    FVector2D MovementVector = Value.Get<FVector2D>();

    if (Controller != nullptr)
    {
        const FRotator Rotation = Controller->GetControlRotation();
        const FRotator YawRotation(0, Rotation.Yaw, 0);

        const FVector ForwardDirection = FRotationMatrix(YawRotation).GetUnitAxis(EAxis::X);
        const FVector RightDirection   = FRotationMatrix(YawRotation).GetUnitAxis(EAxis::Y);

        AddMovementInput(ForwardDirection, MovementVector.Y);
        AddMovementInput(RightDirection, MovementVector.X);
    }
}
```

#### 这个逻辑背后的思路是：

- 【`W`】键：`MovementVector.Y = 1` → **每一帧都调用 `AddMovementInput(ForwardDirection, 1.0)`**。
- 【`S`】键：`MovementVector.Y = -1`。
- 【`A`】【`D`】：`MovementVector.X` 控制左右。

重点：**是每一帧持续 AddMovementInput。**

如果我鼠标点击那一帧只调用了一次：

```cpp
AddMovementInput(Direction, 1.0f);  // 调用了一次，下一帧就没了
```

角色就只会转个身（因为模板默认有 `bOrientRotationToMovement = true`），但不会走过去。

#### 原写法的移动逻辑本质：



| 来自哪儿               | 逻辑                                                       |
| ---------------------- | ---------------------------------------------------------- |
| Player Input（WASD）   | 每一帧调用 `Move()` → 每一帧 AddMovementInput              |
| 鼠标点击（我自己加的） | 只有点击那一帧调用 AddMovementInput → 角色转身但不持续移动 |

------

### 为什么转了身

因为这一行：

```cpp
GetCharacterMovement()->bOrientRotationToMovement = true;
```

Unreal Character 自带逻辑：**只要 `AddMovementInput()` 传了方向，哪怕一次，也会面朝那个方向转。**

但我没有持续 AddMovementInput → 不会位移。

### 我现在需要的逻辑

> **鼠标点击 → 记录目标位置 → 每一帧判断和移动 → 持续 AddMovementInput → 到了以后停下。**

这就是我刚才给我写的 `MoveTowardsTarget()` 那个逻辑。

在 `DevourPlayerController.h` ：

```cpp

protected:
    // 存储鼠标点击的目标位置
    FVector MoveTargetLocation;

    // 是否正在移动到目标
    bool bIsMovingToTarget = false;
    // Mouse Handler
    void HandleMouseClick();
    // 每帧判断并移动
    void MoveTowardsTarget();

```

------

在我的 `DevourPlayerController.cpp`：

```cpp
void ADevourPlayerController::PlayerTick(float DeltaTime)
{
    Super::PlayerTick(DeltaTime);

    if (WasInputKeyJustPressed(EKeys::LeftMouseButton))
    {
        HandleMouseClick();
    }

    // 每帧持续移动
    MoveTowardsTarget();
}

void ADevourPlayerController::HandleMouseClick()
{
    FHitResult HitResult;
    GetHitResultUnderCursor(ECollisionChannel::ECC_Visibility, false, HitResult);

    if (HitResult.bBlockingHit)
    {
        AActor* HitActor = HitResult.GetActor();
        FVector HitLocation = HitResult.Location;

        if (HitActor && HitActor->Implements<UInteractableInterface>())
        {
            IInteractableInterface::Execute_Interact(HitActor, GetPawn());
        }
        else
        {
            APawn* ControlledPawn = GetPawn();
            if (ControlledPawn)
            {
                MoveTargetLocation = HitLocation;
                bIsMovingToTarget = true;
            }
        }
    }
}

void ADevourPlayerController::MoveTowardsTarget()
{
    if (!bIsMovingToTarget) return;

    APawn* ControlledPawn = GetPawn();
    if (!ControlledPawn) return;

    FVector CurrentLocation = ControlledPawn->GetActorLocation();
    FVector ToTarget = MoveTargetLocation - CurrentLocation;
    float Distance = ToTarget.Size2D();

    if (Distance > 10.0f)  // 10.0f 是到达的容差，可以调大或调小
    {
        FVector Direction = ToTarget.GetSafeNormal2D();
        ControlledPawn->AddMovementInput(Direction, 1.0f);
    }
    else
    {
        bIsMovingToTarget = false;  // 到达目标，停止移动
    }
}
```