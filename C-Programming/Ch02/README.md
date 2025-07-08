# 📘 Datatypes and Their Representation in RISC-V Assembly

This document explains how C data types such as `char`, `int`, and `float` are represented in RISC-V Assembly. It also explores how these variables affect the stack and how floating-point numbers conform to the IEEE 754 standard.

---

## 🧮 IEEE 754 Floating Point Representation

The IEEE 754 standard defines the layout of binary floating-point numbers.

| Precision | Total Bits | Sign Bit | Exponent | Fraction (Mantissa) |
|-----------|------------|----------|----------|----------------------|
| `float`   | 32         | 1        | 8        | 23                   |
| `double`  | 64         | 1        | 11       | 52                   |

### 🧪 General Formula

```
Value = (-1)^sign × (1.mantissa) × 2^(exponent - bias)
```

- **Bias for float:** 127  
- **Bias for double:** 1023

---

## 🔢 IEEE 754 Example: Representing `2.0` (float)

```c
int sidhesh(){
    float var = 2.0;
    return 0;
}
```

### 🔍 Step-by-step Breakdown

- Decimal: `2.0`  
- Binary: `10.0` → Normalized: `1.0 × 2^1`  
- Exponent: `1 + 127 = 128 → 0x80`  
- Sign: `0` (positive)  
- Mantissa: `0...0` (23 bits)

### 🧾 Final Bit Representation

| Sign | Exponent | Mantissa               | Hex         |
|------|----------|------------------------|-------------|
| 0    | 10000000 | 00000000000000000000000 | `0x40000000` |

---

### 🧬 Assembly Representation (float)

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
	addi	sp, sp, -32
	sw	s0, 28(sp)
	addi	s0, sp, 32
	lui	a5, %hi(.LC0)
	lw	a5, %lo(.LC0)(a5)
	sw	a5, -20(s0)
	li	a5, 0
	mv	a0, a5
	lw	s0, 28(sp)
	addi	sp, sp, 32
	jr	ra
	.size	sidhesh, .-sidhesh

	.section .rodata
	.align	2
.LC0:
	.word	1073741824

	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
```

- The `.LC0:` label stores the value of `2.0`
  - `1073741824` is the decimal representation
  - When converted to binary:
    - `01000000000000000000000000000000`

---

## 🧪 IEEE 754 Example: Representing `5.0` (double)

```c
int example() {
    double d = 5.0;
    return 0;
}
```

### 🔍 Step-by-step Breakdown

- Decimal: `5.0`  
- Binary: `101.0` → Normalized: `1.01 × 2^2`  
- Exponent: `2 + 1023 = 1025 → 0x401`  
- Sign: `0` (positive)  
- Mantissa: `010000000000...` (52 bits)

### 🧾 Final Bit Representation

| Sign | Exponent      | Mantissa                                                | Hex                 |
|------|---------------|---------------------------------------------------------|---------------------|
| 0    | 10000000001   | 0100000000000000000000000000000000000000000000000000    | `0x4014000000000000` |

> You can verify this by converting `0x4014000000000000` to binary, and interpreting it using the IEEE 754 double format.

---
