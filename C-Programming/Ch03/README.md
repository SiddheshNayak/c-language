# 📘 Datatypes and Their Representation in RISC-V Assembly

## 🛡️ `const` and `volatile`

---

### 🔒 `const`

Let's consider an example:

```c
int sidhesh() {
    const float var = 5.0;
    return 0;
}
```

If we try to modify `var` after its initialization:

```c
int sidhesh() {
    const float var = 5.0;
    var = 10.123;
    return 0;
}
```

The compiler throws an error:

```bash
c-asm.c: In function 'sidhesh':
c-asm.c:3:9: error: assignment of read-only variable 'var'
    3 |     var = 10.123;
      |         ^
make: *** [Makefile:2: generateassembly] Error 1
```

---

However, we can perform a bit of **"pointer black magic"** to modify the value at the address of `var`:

```c
int sidhesh() {
    const float var = 5.0;
    
    // Creating a pointer to float and casting away const
    float *pVar = (float *)&var;
    
    // Dereferencing to assign a new value
    *pVar = 10.123;
    
    return 0;
}
```

This results in a compiler warning:

```bash
c-asm.c: In function 'sidhesh':
c-asm.c:4:19: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    4 |     float *pVar = &var;
      |                   ^
```

> ⚠️ **Note**: Even though the code compiles with just a warning, modifying a `const` value via a pointer results in **undefined behavior**. This should be strictly avoided in real applications.

---

### ⚠️ `volatile`

Let’s understand the behavior of `volatile` using a basic example:

```c
int sidhesh() {
    int i = 10;

    i = i + 1;
    i = i + 10;

    return i;
}
```

> ✅ To observe compiler optimization, enable optimization level `-O1` in the Makefile.

The generated assembly (with optimization enabled) may look like this:

```asm
	.file	"c-asm.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	sidhesh
	.type	sidhesh, @function
sidhesh:
	li	a0, 21
	ret
	.size	sidhesh, .-sidhesh
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
```

> 🔍 You can see that the additions (`i = i + 1` and `i = i + 10`) were **optimized out**. The compiler recognized that the result is constant and returned `21` directly.

Effectively, the compiler sees:

```c
int sidhesh() {
    return 21;
}
```

---

However, if `i` is declared as `volatile`, like so:

```c
int sidhesh() {
    volatile int i = 10;

    i = i + 1;
    i = i + 10;

    return i;
}
```

Then the generated assembly looks like:

```asm
	.file	"c-asm.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	sidhesh
	.type	sidhesh, @function
sidhesh:
	addi	sp, sp, -16
	li	a5, 10
	sw	a5, 12(sp)
	lw	a5, 12(sp)
	addi	a5, a5, 1
	sw	a5, 12(sp)
	lw	a5, 12(sp)
	addi	a5, a5, 10
	sw	a5, 12(sp)
	lw	a0, 12(sp)
	addi	sp, sp, 16
	jr	ra
	.size	sidhesh, .-sidhesh
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
```

Here’s what’s happening step-by-step:

1. The value `10` is loaded into register `a5`
2. It is **stored** at offset `12(sp)` (stack location)
3. The value is **loaded** from the stack into `a5`
4. `1` is added to `a5`
5. The updated value is **stored** back to the stack
6. The value is **loaded** again from the stack
7. `10` is added to `a5`
8. The final result is **stored** back to the stack
9. The result is **loaded** into `a0` and returned

> 📌 **`volatile` tells the compiler**: “Do not optimize this variable. Treat every read and write as meaningful,” because its value could be affected by external sources (e.g., hardware registers, interrupts, or concurrent threads).

---
