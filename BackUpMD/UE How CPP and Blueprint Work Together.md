# Unreal Engine: How C++ and Blueprint Work Together

## Introduction

In Unreal Engine projects, especially C++-based ones, understanding how C++ code and Blueprint interact is crucial for writing flexible and maintainable game logic. This tutorial explains:

- How C++ and Blueprint changes affect each other.
- Which one takes precedence if they conflict.
- How to confirm whether a variable or function is exposed to Blueprint.
- How to identify if a function is designed to be overridden.

## 1. Interaction Between C++ and Blueprint

### Core Idea

- **C++ defines the base logic and behaviour.**
- **Blueprint can override or extend the C++ logic at the class or instance level.**

### Which One Takes Precedence?

- If **both C++ and Blueprint define the same variable or function**, Blueprint usually takes precedence **at runtime**.
- **When?** This depends on the exposure settings (`UPROPERTY`, `UFUNCTION`) and the execution order (constructor, `BeginPlay`, etc.).

### Example:

```cpp
UPROPERTY(BlueprintReadWrite, EditAnywhere)
float Speed;
```

- If C++ sets `Speed = 100.f;` in the constructor, but Blueprint sets it to `200.f`, the final value depends on **when each assignment happens**.

## 2. How to Confirm if a Variable or Function Is Exposed to Blueprint

### For Variables:

Check for these macros:

- `UPROPERTY(BlueprintReadOnly)` → Readable in Blueprint.
- `UPROPERTY(BlueprintReadWrite)` → Readable and writable in Blueprint.
- `EditAnywhere`, `VisibleAnywhere` control where you can see/edit the variable in the editor.

### For Functions:

Look for these:

- `UFUNCTION(BlueprintCallable)` → Callable from Blueprint.
- `UFUNCTION(BlueprintPure)` → Callable but does not change state.
- `UFUNCTION(BlueprintImplementableEvent)` → Must be implemented in Blueprint.
- `UFUNCTION(BlueprintNativeEvent)` → Can be overridden in Blueprint or C++.

### For Classes:

- `UCLASS(Blueprintable)` → Can be subclassed in Blueprint.
- `UCLASS(BlueprintType)` → Can be used as a variable type in Blueprint.

## 3. How to Confirm if a Function Is Designed to Be Overridden

### In C++:

- Check if the function is declared `virtual`.
- If it is **pure virtual** (e.g., `virtual void MyFunction() = 0;`), subclasses **must override** it.

### In Blueprint:

- `UFUNCTION(BlueprintNativeEvent)` → Overridable in Blueprint and C++.
  - C++ overrides use `FunctionName_Implementation()`.
- `UFUNCTION(BlueprintImplementableEvent)` → Intended to be implemented only in Blueprint.

### Example:

```cpp
UFUNCTION(BlueprintNativeEvent)
void OnDamageTaken();

// To override in C++:
void AMyActor::OnDamageTaken_Implementation()
{
    // Custom logic here
}
```

## 4. Summary Flowchart

![Image](https://github.com/user-attachments/assets/9a0ae95c-abe7-4fb0-8812-0291a0fbe3dd)