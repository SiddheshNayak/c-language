# 🧪 Demo – `do-while`, `while`, `for` Effects at the Assembly Level

---

## 🔀 `do-while` Example

### ✅ C Code

```c
void sidhesh() {
  int i = 10;
  int j = 2;

  do {
    j = j + 1;
    i = i - 1;
  } while (i > 0);

  return;
}
```

---

### ⚙️ Assembly Output

```asm
sidhesh:
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	li	a5,10
	sw	a5,-20(s0)
	li	a5,2
	sw	a5,-24(s0)
.L2:
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	addi	a5,a5,-1
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	bgt	a5,zero,.L2
	nop
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
```

---

### 🔍 Observations

- The loop body **executes first** before the condition is checked, as expected from `do-while`.
- The conditional check (`i > 0`) occurs **after** the body executes.
- Label `.L2:` marks the loop start, and the loop continues while `i > 0`.

---

### 🧭 Debug Tip

You can attach GDB and set a breakpoint at the start of `sidhesh()` to step through each instruction and observe control flow.

---

## 🔀 `while` Example

### ✅ C Code

```c
void sidhesh() {
  int i = 1;
  int j = 2;

  while (i == 2) {
    j = j + 1;
  }

  return;
}
```

---

### ⚙️ Assembly Output

```asm
sidhesh:
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	li	a5,1
	sw	a5,-24(s0)
	li	a5,2
	sw	a5,-20(s0)
	j	.L2
.L3:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a4,-24(s0)
	li	a5,2
	beq	a4,a5,.L3
	nop
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
```

---

### 🔍 Observations

- The `while` loop checks the condition **before entering** the body.
- Since `i == 1`, and the condition is `i == 2`, the body never executes.
- `j .L2` represents the conditional check loop entry.

---

## 🔀 `for` Example

### ✅ C Code

```c
void sidhesh() {
  int j = 2;
  for (int i = 1; i <= 2; i++) {
    j = j + 1;
  }
  return;
}
```

---

### ⚙️ Assembly Output

```asm
sidhesh:
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	li	a5,2
	sw	a5,-20(s0)
	li	a5,1
	sw	a5,-24(s0)
	j	.L2
.L3:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L2:
	lw	a4,-24(s0)
	li	a5,2
	ble	a4,a5,.L3
	nop
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
```

---

### 🔍 Observations

- Initialization, condition, and increment are clearly visible.
- Loop body and increment happen inside `.L3`.
- `.L2` is the condition check.
- Final `nop` is filler after the loop exits.

---

## 🔁 `for` with `goto`

### ✅ C Code

```c
void sidhesh() {
  int j = 2;
  for (int i = 1; i <= 10; i++) {
    if (i == 5) {
      goto end;
    }
    j = j + 1;
  end:
    j = j + 10;
  }
  return;
}
```

---

### ⚙️ Assembly Output

```asm
sidhesh:
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	li	a5,2
	sw	a5,-20(s0)
	li	a5,1
	sw	a5,-24(s0)
	j	.L2
.L5:
	lw	a4,-24(s0)
	li	a5,5
	beq	a4,a5,.L7
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	j	.L4
.L7:
	nop
.L4:
	lw	a5,-20(s0)
	addi	a5,a5,10
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L2:
	lw	a4,-24(s0)
	li	a5,10
	ble	a4,a5,.L5
	nop
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
```

---

### 🔍 Observations

- `goto end` causes early exit to label `.L7`.
- `.L4` contains code common to both paths, following the `goto` and normal flow.
- Use of labels simulates structured control transfer.
- ⚠️ **Important:** `goto` can only jump to labels **within the same function** — it cannot jump across different functions.

---

## 🔁 `for` with `continue`

### ✅ C Code

```c
void sidhesh() {
  int j = 2;
  for (int i = 1; i <= 10; i++) {
    j = j + 1;
    if (i == 5) {
      continue;
    }
    j = j + 10;
  }
  return;
}
```

---

### ⚙️ Assembly Output

```asm
sidhesh:
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	li	a5,2
	sw	a5,-20(s0)
	li	a5,1
	sw	a5,-24(s0)
	j	.L2
.L5:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	lw	a4,-24(s0)
	li	a5,5
	beq	a4,a5,.L7
	lw	a5,-20(s0)
	addi	a5,a5,10
	sw	a5,-20(s0)
	j	.L4
.L7:
	nop
.L4:
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L2:
	lw	a4,-24(s0)
	li	a5,10
	ble	a4,a5,.L5
	nop
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
```

---

### 🔍 Observations

- The `continue` skips the block `j = j + 10` when `i == 5`.
- `.L7` is the continuation path skipping over extra addition.
- The loop structure remains intact; increment still happens.

---
