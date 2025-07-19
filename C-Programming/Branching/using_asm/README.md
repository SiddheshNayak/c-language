# 🧪 Demo – `if`, `else if`, `else` and `switch` Effects at the Assembly Level

---

## 🔀 `if`, `else if`, `else` Example

### C Code

```c
void sidhesh()
{
    int i = 11;
    int j = 2;

    if (i == 1) {
        j += 1;
    } else if (i == 2) {
        j += 2;
    } else if (i == 3) {
        j += 3;
    } else {
        j += 100;
    }

    return;
}
```

### Assembly Output

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
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	li	a5,11
	sw	a5,-20(s0)
	li	a5,2
	sw	a5,-24(s0)
	lw	a4,-20(s0)
	li	a5,1
	bne	a4,a5,.L2
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
	j	.L1
.L2:
	lw	a4,-20(s0)
	li	a5,2
	bne	a4,a5,.L4
	lw	a5,-24(s0)
	addi	a5,a5,2
	sw	a5,-24(s0)
	j	.L1
.L4:
	lw	a4,-20(s0)
	li	a5,3
	bne	a4,a5,.L5
	lw	a5,-24(s0)
	addi	a5,a5,3
	sw	a5,-24(s0)
	j	.L1
.L5:
	lw	a5,-24(s0)
	addi	a5,a5,100
	sw	a5,-24(s0)
	nop
.L1:
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	sidhesh, .-sidhesh
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
```

> 🧭 You can attach GDB and set a breakpoint at the start of `sidhesh()` to step through each condition.

---

## 🧮 `switch` Case Example

### C Code

```c
void sidhesh()
{
    int i = 2;
    int j = 2;

    switch (i)
    {
    case 1:
        j += 1;
        break;
    case 2:
        j += 2;
        break;
    case 3:
        j += 3;
        break;
    default:
        j += 100;
    }

    return;
}
```

### Assembly Output

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
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	li	a5,2
	sw	a5,-20(s0)
	li	a5,2
	sw	a5,-24(s0)
	lw	a4,-20(s0)
	li	a5,3
	beq	a4,a5,.L2
	lw	a4,-20(s0)
	li	a5,3
	bgt	a4,a5,.L3
	lw	a4,-20(s0)
	li	a5,1
	beq	a4,a5,.L4
	lw	a4,-20(s0)
	li	a5,2
	beq	a4,a5,.L5
	j	.L3
.L4:
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
	j	.L6
.L5:
	lw	a5,-24(s0)
	addi	a5,a5,2
	sw	a5,-24(s0)
	j	.L6
.L2:
	lw	a5,-24(s0)
	addi	a5,a5,3
	sw	a5,-24(s0)
	j	.L6
.L3:
	lw	a5,-24(s0)
	addi	a5,a5,100
	sw	a5,-24(s0)
.L6:
	nop
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	sidhesh, .-sidhesh
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
```

> 📊 Compare this with the `if-else` assembly: The switch-case version may generate slightly more structured and efficient jump logic, depending on how the compiler optimizes the case values.

---

## 🧪 `switch` Without `break` (Fallthrough Behavior)

### C Code (Missing `break` in Case 1)

```c
void sidhesh()
{
    int i = 2;
    int j = 2;

    switch (i)
    {
    case 1:
        j += 1;

    case 2:
        j += 2;
        break;
    case 3:
        j += 3;
        break;
    default:
        j += 100;
    }

    return;
}
```

### Assembly Output

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
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	li	a5,2
	sw	a5,-24(s0)
	li	a5,2
	sw	a5,-20(s0)
	lw	a4,-24(s0)
	li	a5,3
	beq	a4,a5,.L2
	lw	a4,-24(s0)
	li	a5,3
	bgt	a4,a5,.L3
	lw	a4,-24(s0)
	li	a5,1
	beq	a4,a5,.L4
	lw	a4,-24(s0)
	li	a5,2
	beq	a4,a5,.L5
	j	.L3
.L4:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L5:
	lw	a5,-20(s0)
	addi	a5,a5,2
	sw	a5,-20(s0)
	j	.L6
.L2:
	lw	a5,-20(s0)
	addi	a5,a5,3
	sw	a5,-20(s0)
	j	.L6
.L3:
	lw	a5,-20(s0)
	addi	a5,a5,100
	sw	a5,-20(s0)
.L6:
	nop
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	sidhesh, .-sidhesh
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
```

### 🔍 Observation

- Notice that **`.L4:` (case 1)** no longer ends with a `jump` to `.L6`.
- Instead, execution **falls through to `.L5:` (case 2)**.
- This is the direct assembly effect of **omitting `break;`** in C.

> 🧠 **Tip**: Always use `break;` in switch-cases unless intentional fallthrough is needed. Compilers can catch accidental fallthroughs with warnings if `-Wimplicit-fallthrough` is enabled.

---
