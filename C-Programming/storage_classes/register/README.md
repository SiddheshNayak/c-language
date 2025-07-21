# 🚀 `register` Storage Class in C

The `register` keyword is a storage class specifier that **hints** the compiler to store the variable in a **CPU register** instead of RAM for faster access.

> ⚠️ Modern compilers usually ignore this keyword, as they optimize register usage automatically.

---

## ✅ Example Code

```c
int main(void) {
  int x = 11;
  /* This tells the compiler to try to allocate variable as a CPU register.
   * Scope - local (within the block)
   */
  register int a = 10;
  a = a + 1;
  x = x + 1;

  return a;
}
```

---

## 🛠️ Generate RISC-V Assembly

```bash
riscv64-unknown-elf-gcc -O0 -S main.c
```

- `-O0`: No optimization to observe actual variable usage
- `-S`: Outputs `.s` file with assembly

---

## 🧾 Assembly Output (main.s)

```asm
	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	s0,24(sp)
	sd	s1,16(sp)
	addi	s0,sp,32
	li	a5,11
	sw	a5,-20(s0)
	li	s1,10
	addiw	a5,s1,1
	sext.w	s1,a5
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
	mv	a5,s1
	mv	a0,a5
	ld	s0,24(sp)
	ld	s1,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
```

---

## 🔍 Observations

- The variable `x` is loaded into a register and then stored to stack at `-20(s0)` using `sw`.
- To increment `x`, the compiler loads it back from memory using `lw`, increments it, and stores it again.

- For the register variable `a`:

    - The value 10 is loaded into register `s1`.
    - `addiw a5,s1,1` performs `a = a + 1`, and the result is stored back into `s1`.
    - No load or store from memory is used for `a`.

This shows the compiler chose to keep a in a register (as hinted), while `x` was memory-bound.

---

## 📌 Summary: `register` Storage Class

| Property             | Description                                              |
|----------------------|----------------------------------------------------------|
| Scope                | Local (within a block/function)                         |
| Lifetime             | Till end of block (same as `auto`)                      |
| Storage Location     | Suggests CPU register (compiler may ignore it)          |
| Address Access       | `&variable` is **not allowed** with `register`          |
| Use Case             | Fast access for frequently used local variables         |

---

## 🚫 Notable Limitations

- You **cannot take the address** of a `register` variable:
  ```c
  register int a = 5;
  int *ptr = &a;  // ❌ Error: address of register variable requested
  ```
- Ignored in global scope or in modern compilers with aggressive optimization.

---



