# 🕳️ `void` in C

The `void` keyword in C is used to indicate **absence of a value or type**. It serves different purposes in function declarations, pointers, and return types.

---

## ✅ 1. `void` as Return Type

When a function doesn't return a value, it is declared with `void` as the return type.

### 🔹 Example:
```c
void greet() {
    printf("Hello, World!\n");
}
```

- This function performs an action but **does not return anything**.
- Using `return;` is optional (and must not return a value).

---

## ✅ 2. `void` as Function Parameter

If a function **takes no arguments**, you can declare it using `void` in the parameter list.

### 🔹 Example:
```c
int getRandomNumber(void) {
    return 42;
}
```

- `void` clearly states that the function accepts **no arguments**.
- In contrast, `int getRandomNumber()` may allow unspecified arguments (in older C).

---

## ✅ 3. `void` Pointers – `void *`

A `void *` is a **generic pointer** that can point to any data type.

### 🔹 Example:
```c
void *ptr;
int num = 10;
ptr = &num; // valid

// Must be typecast before dereferencing
printf("%d", *(int *)ptr);
```

- Useful in **memory management**, **generic functions**, and **APIs** like `malloc()`.
- Cannot be directly dereferenced or incremented without a cast.

---

## 🛑 Invalid Usage – `void` Variables

You **cannot declare a variable** of type `void`.

### 🚫 Invalid:
```c
void x; // ❌ Compilation error
```

---

## 🧠 Summary

| Usage                     | Purpose                                      |
|--------------------------|----------------------------------------------|
| `void` return type        | Function returns no value                    |
| `void` parameter list     | Function takes no arguments                  |
| `void *` pointer          | Generic pointer to any data type             |
| `void` variable           | ❌ Not allowed                               |

---

## 🛠️ Common Use Case – `malloc()`

```c
int *arr = (int *)malloc(5 * sizeof(int));
```

- `malloc()` returns a `void *` which is typecast to appropriate pointer type.

---

Let me know if you'd like to add examples with function pointers or more advanced uses.
