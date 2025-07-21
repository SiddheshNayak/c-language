# 🧠 `static` Keyword in C (Variables & Functions)

The `static` keyword in C changes the **linkage** or **lifetime** of variables and functions.

---

## 📌 1. Static Local Variable

- **Retains value between function calls**
- **Lifetime**: Entire execution of the program
- **Scope**: Limited to the function/block

### ✅ Example

```c
#include <stdio.h>

int foo() {
  /* Initialized only once */
  static char b = 0;
  /* Incremented with retained value */
  b = b + 1;

  printf("Entering %s %d\n", __FUNCTION__, b);
  return 0;
}

int main(void) {
  foo();  // b = 1
  foo();  // b = 2
  foo();  // b = 3
  return 0;
}
```

### 🧾 Output

```bash
Entering foo 1
Entering foo 2
Entering foo 3
```

---

## 📌 2. Static Global Variable

- **Scope**: Limited to the file (internal linkage)
- **Lifetime**: Entire execution of the program

### ✅ Example

```c
// file1.c
#include <stdio.h>

static int counter = 0;

void increment() {
  counter++;
  printf("counter = %d\n", counter);
}
```

```c
// file2.c
extern void increment();

int main() {
  increment();  // ✅ allowed
  // printf("%d\n", counter); ❌ Error: counter is not visible here
  return 0;
}
```

> `counter` is **file-local** to `file1.c`, and not accessible in `file2.c`.

---

## 📌 3. Static Function

- **Scope**: File-local (internal linkage)
- Cannot be called from another translation unit

### ✅ Example (with Violation)

#### 📄 `file1.c`

```c
#include <stdio.h>

static void secret() {
  printf("This is a static function\n");
}

void call_secret() {
  secret();  // ✅ Allowed within the same file
}
```

#### 📄 `file2.c`

```c
int main() {
  secret();  // ❌ Error: 'secret' is not visible here
  return 0;
}
```

### 🔥 Compilation Error

```bash
file2.c:4:5: error: implicit declaration of function ‘secret’
/usr/bin/ld: undefined reference to ‘secret’
```

---

## 📌 Summary Table

| Type                 | Scope            | Lifetime              | Linkage       | Notes                                         |
|----------------------|------------------|------------------------|---------------|-----------------------------------------------|
| Static local var     | Block/function   | Entire program         | No linkage    | Retains value across calls                    |
| Static global var    | File             | Entire program         | Internal      | Not accessible from other files               |
| Static function      | File             | Entire program         | Internal      | Cannot be used from other files               |

---

## 🧠 Tip

Use `static` to:
- Avoid name clashes across files
- Preserve local state across function calls
- Limit scope of helper functions

```c
static int helper() { return 42; } // Private to this file
```
