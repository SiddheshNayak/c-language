# Datatypes and Their Representation in Assembly (RISC-V)

This guide explains how **C data types** like `char`, `int`, and `float` are represented in **RISC-V assembly**, and what really happens under the hood.

---

## 🧪 Case 1: `char` Type

### C Code:
```c
int sidhesh() {
    char c1 = 'A';
    return 3;
}
````

### Assembly Output:

```asm
sidhesh:
    addi    sp, sp, -32          # Allocate 32 bytes stack frame
    sw      s0, 28(sp)           # Save previous s0 (frame pointer)
    addi    s0, sp, 32           # New frame pointer = old sp
    li      a5, 65               # Load ASCII of 'A' into a5
    sb      a5, -17(s0)          # Store a5 as a byte at offset -17
    li      a5, 3                # Load return value into a5
    mv      a0, a5               # Move to return register
    lw      s0, 28(sp)           # Restore s0
    addi    sp, sp, 32           # Deallocate stack
    jr      ra                   # Return to caller
```

### 🔍 Explanation:

* `sb` (Store Byte) is used to store a `char` (1 byte).
* Offset `-17(s0)` is used for alignment or reserved space.
* Even though `char` is small, the stack frame size is large (32 bytes) due to alignment and ABI convention.

---

## 🧪 Case 2: `int` Type

### C Code:

```c
int sidhesh() {
    int var = 1234;
    return 3;
}
```

### Assembly Output:

```asm
sidhesh:
    addi    sp, sp, -32
    sw      s0, 28(sp)
    addi    s0, sp, 32
    li      a5, 1234
    sw      a5, -20(s0)          # Store full 4-byte integer
    li      a5, 3
    mv      a0, a5
    lw      s0, 28(sp)
    addi    sp, sp, 32
    jr      ra
```

### 🔍 Explanation:

* `sw` (Store Word) is used to store a 32-bit `int`.
* Offset `-20(s0)` indicates space reserved in the stack for the variable.

---

## 🧪 Case 3: `float` Type

### C Code:

```c
int sidhesh() {
    float var = 1234.0256;
    return 3;
}
```

### Assembly Output:

```asm
sidhesh:
    addi    sp, sp, -32
    sw      s0, 28(sp)
    addi    s0, sp, 32
    lui     a5, %hi(.LC0)        # Load upper address of float literal
    lw      a5, %lo(.LC0)(a5)    # Load float value into a5
    sw      a5, -20(s0)          # Store the float into stack (binary representation)
    li      a5, 3
    mv      a0, a5
    lw      s0, 28(sp)
    addi    sp, sp, 32
    jr      ra

.section .rodata
.align 2
.LC0:
    .word   1150959826           # Binary representation of 1234.0256 (IEEE 754)
```

### 🔍 Explanation:

* Floating-point constants are stored in the **`.rodata`** (read-only data) section.
* `lui` + `lw` pair is used to load the full address and then the value.
* `sw` stores the float to memory — still a 32-bit value in RISC-V.

> 📌 `1150959826` is the IEEE 754 single-precision representation of `1234.0256`.

---

## 💡 Observations Across Types

| Type    | Stored Using                 | Instruction       | Bytes | Memory Access |
| ------- | ---------------------------- | ----------------- | ----- | ------------- |
| `char`  | Register → Stack             | `sb`              | 1     | `-17(s0)`     |
| `int`   | Register → Stack             | `sw`              | 4     | `-20(s0)`     |
| `float` | Literal in `.rodata` → Stack | `sw` via `lui+lw` | 4     | `-20(s0)`     |

---

## 🧠 Summary

* RISC-V uses **byte (`sb`)** or **word (`sw`)** store instructions depending on data type size.
* Stack allocation size is often larger than needed to preserve alignment and frame convention.
* Float literals are handled differently — stored as **binary representations** in a `.rodata` section and loaded at runtime.
* The **frame pointer (`s0`)** is used as a reference base for accessing local variables.


