# 📘 Datatypes and Their Representation in RISC-V Assembly

## 🛡️ `const` and `volatile`

### **Const** :
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

However, we can do a bit of **"pointer black magic"** to modify the value at the address of `var`:

```c
int sidhesh() {
    const float var = 5.0;
    // Creating a pointer of float type
    float *pVar = &var;
    // Dereferencing (assigning) a value to the address of the variable
    *pVar = 10.123;
    return 0;
}
```

The compiler throws a warning, as we have committed some mischief here:

```bash
c-asm.c: In function 'sidhesh':
c-asm.c:4:19: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    4 |     float *pVar = &var;
      |                   ^
```

> ⚠️ **Note**: Even though the code compiles with just a warning, modifying a `const` value via a pointer leads to **undefined behavior** and should be avoided in practice.

---

### **Volatile** :

Let's consider an example to better understand the volatile:

```c
int sidhesh(){
    int i = 10;

    i = i + 1;
    i = i + 10;
    
    return i;
}
```
> Note turn enable the optimization to beter see the example:
update the make file for `-01` optimization level. 


The assembly representation for the above looks like :
```
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
	li	a0,21
	ret
	.size	sidhesh, .-sidhesh
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"

```
* Here you can see that there are no instructions to do the addition operations, as they have been optimized. The compiler has done some optimization and has returned 21.
i.e.
```c
int sidhesh(){
    
    return 21;
}
```

