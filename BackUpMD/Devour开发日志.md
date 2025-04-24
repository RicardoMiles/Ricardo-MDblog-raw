---
title: Devour开发日志
date: 2025-04-24 17:59:10
tags:

---

---

# 空白模板方案参考

### **搭建 2.5D 游戏场景 from scratch**

2.5D 游戏通常是 2D 角色在 3D 环境中移动，视角固定或受限。我们先创建一个简单的 2.5D 场景，包含地面和基本环境。

#### 2.1 设置摄像机
为了实现 2.5D，我们需要一个固定的侧视摄像机。

1. **在编辑器中创建摄像机**：
   - 打开 `Level Editor`，点击 `Create > Camera > CineCameraActor`，将其拖入场景。
   - 设置摄像机位置，例如 `X=0, Y=-500, Z=200`（面向场景）。
   - 设置旋转，例如 `Pitch=0, Yaw=90, Roll=0`（侧视）。
   - 在 `Details` 面板中，锁定摄像机视角（`Lock Viewport to Actor`），以便测试。

2. **配置玩家摄像机**：
   - 打开 `Project Settings > Maps & Modes`，设置 `Default Pawn Class` 为 `None`（稍后我们会创建自定义角色）。
   - 在 `GameMode` 中，创建一个新的 `GameModeBase`（C++ 或 Blueprint）。
     - 如果用 C++：
       - 在 VSCode 中，创建新文件 `MyGameMode.h`：
         ```cpp
         #pragma once
         #include "CoreMinimal.h"
         #include "GameFramework/GameModeBase.h"
         #include "MyGameMode.generated.h"
         
         UCLASS()
         class YOURPROJECT_API AMyGameMode : public AGameModeBase
         {
             GENERATED_BODY()
         public:
             AMyGameMode();
         };
         ```
       - 对应 `MyGameMode.cpp`：
         ```cpp
         #include "MyGameMode.h"
         
         AMyGameMode::AMyGameMode()
         {
             // 留空，稍后扩展
         }
         ```
       - 编译项目（`Cmd + Shift + B`）。
     - 在编辑器中，基于 `MyGameMode` 创建一个 Blueprint（右键 `MyGameMode` > Create Blueprint）。
     - 在 Blueprint 中，设置 `Default Pawn` 为 `None`，并将摄像机绑定到玩家（我们稍后会用 C++ 实现）。

3. **保存场景**：
   - 创建一个新关卡（`File > New Level > Empty Level`）。
   - 将摄像机拖入关卡，保存为 `Level1`。

#### 2.2 创建地面
- 在编辑器中，添加一个 `Cube`（`Create > Basic > Cube`）。
- 调整尺寸为长条形地面，例如 `X=1000, Y=100, Z=10`。
- 添加材质：
  - 在 `Content Browser` 中，创建新材质（`Add New > Material`）。
  - 命名为 `M_Ground`，设置简单颜色（例如绿色）。
  - 应用到 Cube 上。

**扩展性提示**：将地面和摄像机放入单独的 Blueprint 或 Actor 类，方便复用和修改。

---

### **创建玩家角色和核心操作from scratch**
我们创建一个简单的 2.5D 角色，支持左右移动和跳跃，限制在 2D 平面（X-Z 平面）。

#### 3.1 创建玩家角色（C++）
1. **新建角色类**：
   - 在 VSCode 中，创建 `MyCharacter.h`：
     ```cpp
     #pragma once
     #include "CoreMinimal.h"
     #include "GameFramework/Character.h"
     #include "MyCharacter.generated.h"
     
     UCLASS()
     class YOURPROJECT_API AMyCharacter : public ACharacter
     {
         GENERATED_BODY()
     public:
         AMyCharacter();
     
         virtual void Tick(float DeltaTime) override;
         virtual void SetupPlayerInputComponent(class UInputComponent* PlayerInputComponent) override;
     
     protected:
         void MoveRight(float Value);
         void Jump();
     
     private:
         UPROPERTY(VisibleAnywhere, Category = "Components")
         class USpringArmComponent* SpringArm;
     
         UPROPERTY(VisibleAnywhere, Category = "Components")
         class UCameraComponent* Camera;
     };
     ```
   - 对应 `MyCharacter.cpp`：
     ```cpp
     #include "MyCharacter.h"
     #include "Components/CapsuleComponent.h"
     #include "GameFramework/SpringArmComponent.h"
     #include "Camera/CameraComponent.h"
     #include "GameFramework/CharacterMovementComponent.h"
     
     AMyCharacter::AMyCharacter()
     {
         PrimaryActorTick.bCanEverTick = true;
     
         // 设置角色碰撞
         GetCapsuleComponent()->InitCapsuleSize(42.f, 96.f);
     
         // 设置移动组件（限制为 2D 平面）
         GetCharacterMovement()->bOrientRotationToMovement = false;
         GetCharacterMovement()->bConstrainToPlane = true;
         GetCharacterMovement()->ConstrainPlaneNormal = FVector(0.f, 1.f, 0.f); // 限制 Y 轴
         GetCharacterMovement()->GravityScale = 1.f;
         GetCharacterMovement()->JumpZVelocity = 600.f;
         GetCharacterMovement()->AirControl = 0.2f;
     
         // 创建摄像机臂
         SpringArm = CreateDefaultSubobject<USpringArmComponent>(TEXT("SpringArm"));
         SpringArm->SetupAttachment(RootComponent);
         SpringArm->TargetArmLength = 500.f;
         SpringArm->SetRelativeRotation(FRotator(0.f, -90.f, 0.f));
         SpringArm->bDoCollisionTest = false;
     
         // 创建摄像机
         Camera = CreateDefaultSubobject<UCameraComponent>(TEXT("Camera"));
         Camera->SetupAttachment(SpringArm, USpringArmComponent::SocketName);
     }
     
     void AMyCharacter::Tick(float DeltaTime)
     {
         Super::Tick(DeltaTime);
     }
     
     void AMyCharacter::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent)
     {
         Super::SetupPlayerInputComponent(PlayerInputComponent);
     
         PlayerInputComponent->BindAxis("MoveRight", this, &AMyCharacter::MoveRight);
         PlayerInputComponent->BindAction("Jump", IE_Pressed, this, &AMyCharacter::Jump);
     }
     
     void AMyCharacter::MoveRight(float Value)
     {
         if (Value != 0.f)
         {
             AddMovementInput(FVector(1.f, 0.f, 0.f), Value);
         }
     }
     
     void AMyCharacter::Jump()
     {
         Super::Jump();
     }
     ```
   - 替换 `YOURPROJECT_API` 为你的项目名称（在 `.Build.cs` 文件中定义）。

2. **编译项目**：
   - 在 VSCode 中运行构建任务（`Cmd + Shift + B`）。
   - 如果遇到错误，检查 `#include` 路径或重新生成项目文件。

#### 3.2 配置输入
1. **设置输入绑定**：
   - 打开 `Project Settings > Input`。
   - 添加以下绑定：
     - **Axis Mappings**：
       - `MoveRight`：绑定到 `A`（-1.0）、`D`（1.0）。
     - **Action Mappings**：
       - `Jump`：绑定到 `Space Bar`。
   - 保存设置。

2. **更新 GameMode**：
   - 打开你的 `MyGameMode` Blueprint（或 C++）。
   - 设置 `Default Pawn Class` 为 `MyCharacter`。
   - 在 `Project Settings > Maps & Modes` 中，确保 `Default GameMode` 是你的 `MyGameMode`。

#### 3.3 测试角色
- 返回编辑器，打开 `Level1`。
- 将 `MyCharacter` 拖入场景，放置在地面上方（例如 `X=0, Y=0, Z=100`）。
- 点击 `Play`，用 `A`/`D` 左右移动，`Space` 跳跃。
- 确认摄像机跟随角色，且移动限制在 X-Z 平面。

**扩展性提示**：
- `MyCharacter` 类可以扩展为基类，派生出不同角色类型。
- 输入绑定可以移到单独的输入配置文件，方便修改。
- 摄像机参数（如 `SpringArm` 长度）可以暴露为 UPROPERTY，允许编辑器调整。

---

### **优化和扩展准备**
现在你有了一个基本的 2.5D 场景和可控角色。以下是为扩展性做的准备：

1. **模块化代码**：
   - 创建一个基类 `BaseCharacter`，让 `MyCharacter` 继承它：
     ```cpp
     UCLASS(Abstract)
     class YOURPROJECT_API ABaseCharacter : public ACharacter
     {
         GENERATED_BODY()
     public:
         virtual void MoveRight(float Value);
         virtual void Jump();
     };
     ```
   - 将通用逻辑（如移动限制）放入 `BaseCharacter`，让子类实现特定行为。

2. **场景管理**：
   - 创建一个 `LevelManager` 类，管理关卡切换和场景元素：
     ```cpp
     UCLASS()
     class YOURPROJECT_API ALevelManager : public AActor
     {
         GENERATED_BODY()
     public:
         UFUNCTION(BlueprintCallable)
         void LoadLevel(FName LevelName);
     };
     ```

3. **资产组织**：
   - 在 `Content Browser` 中，按文件夹组织资源：
     - `Blueprints/`：存放角色、GameMode 等。
     - `Materials/`：存放材质。
     - `Maps/`：存放关卡。
   - 使用命名规范，例如 `BP_` 前缀表示 Blueprint。

4. **版本控制**：
   - 初始化 Git 仓库，忽略 `Binaries/`、`Intermediate/` 等文件夹。
   - 提交代码和 `.uproject` 文件。

---

### **测试和调试**
- 在编辑器中运行 `Level1`，确保：
  - 角色可以左右移动和跳跃。
  - 摄像机稳定跟随。
  - 地面碰撞正常。
- 如果有问题：
  - 检查 `Output Log`（编辑器底部）。
  - 在 VSCode 中设置断点，调试 `MyCharacter` 的 `MoveRight` 或 `Jump`。

---

### **下一步学习尝试**
1. **添加 sprite 角色**：
   - 使用 Paper2D 插件，创建 2D sprite 替代默认网格。
   - 在 `MyCharacter` 中添加 `UPaperSpriteComponent`。

2. **扩展输入**：
   - 添加冲刺、攻击等动作，绑定新键。

3. **丰富场景**：
   - 添加平台、障碍物，测试跳跃和碰撞。

4. **状态管理**：
   - 创建 `PlayerState` 和 `GameState`，管理生命值、分数等。



# 初学者如何开始（零基础UE5 + C++）

由于你不熟悉虚幻引擎，我建议分阶段学习和开发，先通过编辑器熟悉基本操作，再用C++实现核心逻辑。以下是具体步骤：

#### 步骤1：熟悉虚幻编辑器

1. 启动编辑器

   ：

   - 在Xcode中编译ProjectNameEditor(Mac)，启动虚幻编辑器。
   - 编辑器启动后，你会看到第三人称模板的默认关卡（一个简单的场景，包含一个角色和一些平台）。

2. 探索编辑器界面

   ：

   - **视口（Viewport）**：中间的3D场景窗口，用于预览和编辑关卡。
   - **内容浏览器（Content Browser）**：底部的资源管理器，包含你的蓝图、模型、材质等。
   - **细节面板（Details Panel）**：右侧，用于调整选中对象的属性。
   - **工具栏**：顶部有“Play”按钮，用于测试游戏。

3. 运行模板项目

   ：

   - 点击工具栏的“Play”按钮，测试第三人称模板。
   - 你会看到一个默认角色（Mannequin）可以移动、跳跃，摄像机跟随角色。

4. 保存项目

   ：

   - 确保你的项目保存在一个固定路径（如~/Documents/Unreal Projects/YourProjectName）。
   - 定期保存（File -> Save All）。

#### 步骤2：调整摄像机为2.5D视角

第三人称模板的摄像机是跟随角色移动的3D视角，我们需要改为固定俯视角：

1. 打开角色蓝图

   ：

   - 在内容浏览器中，找到Content/ThirdPerson/Blueprints/BP_ThirdPerson（这是默认的角色蓝图）。
   - 双击打开蓝图编辑器。

2. 修改摄像机位置

   ：

   - 在蓝图的“组件（Components）”面板中，找到CameraBoom（弹簧臂组件，控制摄像机距离）和FollowCamera（摄像机组件）。

   - 选择

     CameraBoom

     ，在右侧“细节”面板中：

     - 设置Target Arm Length为800-1000（拉远摄像机）。
     - 设置Rotation为X=-45，Y=0，Z=0（俯视45度角）。

   - 选择FollowCamera，确保它绑定到CameraBoom。

3. 锁定摄像机

   ：

   - 在蓝图中，禁用CameraBoom的“Use Pawn Control Rotation”（防止角色旋转影响摄像机）。
   - 这会让摄像机固定在一个俯视角度。

4. 测试

   ：

   - 保存蓝图，回到主编辑器，点击“Play”测试。
   - 确保摄像机现在是固定俯视角，而不是跟随角色旋转。

#### 步骤3：限制角色移动为2D平面

为了让角色像《Don't Starve》一样在2D平面上移动：

1. 修改角色C++代码

   ：

   - 打开Xcode，找到Games/YourProjectName/Source/YourProjectName目录下的YourProjectNameCharacter.h和.cpp文件（这是默认的角色类）。

   - 在

     YourProjectNameCharacter.h

     中，确保类继承自

     ACharacter

     ，并添加以下代码：

     cpp

     

     Copy

     `protected:    virtual void SetupPlayerInputComponent(class UInputComponent* PlayerInputComponent) override;`

   - 在

     YourProjectNameCharacter.cpp

     中，修改

     SetupPlayerInputComponent

     函数，限制Z轴移动：

     cpp

     

     Copy

     `void AYourProjectNameCharacter::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent) {    Super::SetupPlayerInputComponent(PlayerInputComponent);     // 绑定移动输入（仅X和Y轴）    PlayerInputComponent->BindAxis("MoveForward", this, &AYourProjectNameCharacter::MoveForward);    PlayerInputComponent->BindAxis("MoveRight", this, &AYourProjectNameCharacter::MoveRight);     // 禁用跳跃（可选）    // PlayerInputComponent->BindAction("Jump", IE_Pressed, this, &ACharacter::Jump); } void AYourProjectNameCharacter::MoveForward(float Value) {    if (Value != 0.0f)    {        AddMovementInput(GetActorForwardVector(), Value);    } } void AYourProjectNameCharacter::MoveRight(float Value) {    if (Value != 0.0f)    {        AddMovementInput(GetActorRightVector(), Value);    } }`

2. 锁定Z轴

   ：

   - 在

     YourProjectNameCharacter.cpp

     的

     BeginPlay

     函数中，添加代码锁定Z轴：

     cpp

     

     Copy

     `void AYourProjectNameCharacter::BeginPlay() {    Super::BeginPlay();    GetCharacterMovement()->bConstrainToPlane = true;    GetCharacterMovement()->SetPlaneConstraintNormal(FVector(0.0f, 0.0f, 1.0f)); // 锁定Z轴 }`

3. 编译代码

   ：

   - 回到Xcode，选择ProjectNameEditor(Mac)，重新编译。
   - 如果编译失败，检查错误信息，可能需要包含头文件（如#include "GameFramework/CharacterMovementComponent.h"）。

4. 测试

   ：

   - 编译成功后，启动编辑器，测试角色移动。
   - 角色应该只能在X-Y平面上移动，无法跳跃或沿Z轴移动。

#### 步骤4：设计2.5D关卡

1. 创建新关卡

   ：

   - 在编辑器中，点击“File -> New Level”，选择“Empty Level”。
   - 在视口中添加一个平面（Plane）作为地面（在“Place Actors”面板中搜索“Plane”）。
   - 调整地面大小（在“Details”面板中修改Scale）。

2. 添加2.5D元素

   ：

   - 添加一些简单的2D Sprite或3D模型作为环境（树木、岩石等）。
   - 你可以在虚幻市场（Epic Games Marketplace）下载免费的2.5D素材，或者暂时用模板的立方体（Cube）占位。

3. 测试关卡

   ：

   - 将你的角色蓝图拖入关卡，确保它在地面上。
   - 点击“Play”测试，确认角色可以在关卡中移动，摄像机保持俯视角。

#### 步骤5：实现生存机制（简单示例）

为模仿《Don't Starve》的生存机制，你可以用C++添加饥饿值系统：

1. 在角色类中添加饥饿属性

   ：

   - 在

     YourProjectNameCharacter.h

     中：

     cpp

     

     Copy

     `public:    UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "Survival")    float Hunger;     UFUNCTION(BlueprintCallable, Category = "Survival")    void DecreaseHunger(float DeltaTime);`

   - 在

     YourProjectNameCharacter.cpp

     中：

     cpp

     

     Copy

     `AYourProjectNameCharacter::AYourProjectNameCharacter() {    Hunger = 100.0f; // 初始饥饿值 } void AYourProjectNameCharacter::Tick(float DeltaTime) {    Super::Tick(DeltaTime);    DecreaseHunger(DeltaTime); } void AYourProjectNameCharacter::DecreaseHunger(float DeltaTime) {    Hunger -= 10.0f * DeltaTime; // 每秒减少10点    if (Hunger < 0.0f) Hunger = 0.0f;    UE_LOG(LogTemp, Warning, TEXT("Hunger: %f"), Hunger); }`

2. 编译并测试

   ：

   - 编译代码，启动编辑器。
   - 在控制台（Output Log）中查看饥饿值的变化。

3. 扩展

   ：

   - 你可以稍后用蓝图或C++添加UI显示饥饿值，或实现食物收集机制。

------

# Other

官方教程：访问[Unreal Engine Documentation](https://docs.unrealengine.com/)，学习“Getting Started”和“C++ Programming”部分。

YouTube教程：搜索“Unreal Engine 5 C++ Tutorial”或“Unreal Engine 2.5D Game”，推荐渠道如Unreal Sensei
