# 📦 Storage Classes in C

In C programming, **storage classes** define **scope**, **lifetime**, **visibility**, and **default initial value** of variables. There are four main storage classes:

---

## 1. `auto`

### 🔹 Description:
- Default storage class for **local variables**.
- Automatically created when the block is entered and destroyed when it exits.

### 🔹 Scope:  
Block (local to the function or code block)

### 🔹 Lifetime:  
Automatic (until the block/function ends)

### 🔹 Linkage:  
None (not accessible outside the function)

### 🔹 Default Initial Value:  
Garbage (undefined)

### ✅ Example:
```c
void func() {
    auto int x = 10; // same as: int x = 10;
    printf("%d", x);
}
```

---

## 2. `register`

### 🔹 Description:
- Suggests the variable be stored in a **CPU register** for faster access.
- Cannot take the address (`&`) of a register variable.

### 🔹 Scope:  
Block (local)

### 🔹 Lifetime:  
Automatic

### 🔹 Linkage:  
None

### 🔹 Default Initial Value:  
Garbage (undefined)

### ✅ Example:
```c
void func() {
    register int count = 0;
    for (register int i = 0; i < 5; i++) {
        count += i;
    }
}
```

📌 *Note: It's just a hint to the compiler; modern compilers often ignore it.*

---

## 3. `static`

### 🔹 Description:
- Retains the variable's value **between function calls**.
- Can also restrict visibility of global variables/functions to **file scope**.

### 🔹 Scope:  
- Local variable: Block
- Global variable or function: File

### 🔹 Lifetime:  
Entire program execution

### 🔹 Linkage:  
- Internal (if declared globally)
- None (if declared inside a function)

### 🔹 Default Initial Value:  
Zero

### ✅ Example 1 – Persistent Local Variable:
```c
void counter() {
    static int count = 0;
    count++;
    printf("Count: %d\n", count);
}
```

Calling `counter()` multiple times will increment the same `count`.

### ✅ Example 2 – File Scope Restriction:
```c
static int internalVar = 100; // Not accessible in other files

static void helperFunction() {
    // Only usable in this file
}
```

---

## 4. `extern`

### 🔹 Description:
- Declares a **global variable or function** defined in **another file**.
- Used for sharing variables/functions between C files.

### 🔹 Scope:  
Global

### 🔹 Lifetime:  
Entire program execution

### 🔹 Linkage:  
External

### 🔹 Default Initial Value:  
Zero (for uninitialized global vars)

### ✅ Example – Multiple File Usage:

📁 **file1.c**
```c
int sharedCounter = 0;
```

📁 **file2.c**
```c
extern int sharedCounter;

void increment() {
    sharedCounter++;
}
```

---

## 🧠 Summary Table

| Storage Class | Scope         | Lifetime         | Linkage   | Default Value | Notes                                   |
|---------------|---------------|------------------|-----------|----------------|-----------------------------------------|
| `auto`        | Local         | Until block ends | None      | Garbage        | Default for local vars                  |
| `register`    | Local         | Until block ends | None      | Garbage        | Faster access, address not allowed      |
| `static`      | Local / File  | Entire program   | None / Int| 0              | Retains value, file-scoped if global    |
| `extern`      | Global        | Entire program   | External  | 0              | Used for sharing across files           |

---

## ✅ Quick Recap

- Use `auto` implicitly for normal function-local variables.
- Use `register` when you want speed and don’t need address.
- Use `static` to persist data or hide symbols from other files.
- Use `extern` to access globals from another translation unit.

---
