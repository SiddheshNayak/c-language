# 🌐 `extern` Storage Class in C

The `extern` storage class is used to **declare** a global variable or function that is **defined in another file** or location. It tells the compiler: “this variable/function exists, but it’s defined elsewhere.”

---

## ✅ Example: Using `extern` Across Two Files

### 📄 main.c

```c
#include <stdio.h>

/* This tells the compiler not to allocate memory for 'a' here,
   but to search for it in another file (external linkage) */
extern int a;

extern int foo();

int main(void)
{
    a = a + 1;
    printf("%d\n", a);

    foo();
    return 0;
}
```

---

### 📄 anotherFile.c

```c
#include <stdio.h>

/* Memory is allocated and 'a' is defined here */
int a = 10;

int foo()
{
    a = a + 1;
    printf("%d\n", a);

    return 0;
}
```

---

## 🛠️ Compilation & Linking

To compile both files and link them together:

```bash
riscv64-unknown-elf-gcc -O0 -o myprogram main.c anotherFile.c
```

Or with gcc for testing on your host machine:

```bash
gcc -o myprogram main.c anotherFile.c
```

---

## 📌 Summary: `extern` Storage Class

| Property             | Description                                                        |
|----------------------|--------------------------------------------------------------------|
| Scope                | Global (can be accessed across files)                              |
| Lifetime             | Entire program duration                                            |
| Storage Location     | Refers to the location defined elsewhere                           |
| Purpose              | To declare a variable or function without defining it              |
| Use Case             | Share a global variable across multiple C files                    |

---

## 🚫 Common Mistakes

- Declaring `extern int a;` **without defining** `int a = 5;` anywhere will lead to a **linker error**:
  ```
  undefined reference to `a`
  ```
- Declaring `extern` **inside a function** is legal but rarely used — its use is most common at the global level.

---

## 🔍 Quick Visual Flow

```text
+----------------+             +----------------------+
|    main.c      |             |   anotherFile.c      |
|----------------|             |----------------------|
| extern int a;  |  <--------  |  int a = 10;         |
|                |             |                      |
+----------------+             +----------------------+
```

---

Let me know if you'd like the `.s` assembly output or Doxygen-compatible comments!
