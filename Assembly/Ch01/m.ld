/* 
 * Linker Script for RISC-V Bare Metal Program
 * Target: QEMU's 'virt' machine 
 * Memory layout based on QEMU default for riscv32
 */

/* Define memory regions used by the program */
MEMORY
{
    /* 
     * QEMU 'virt' machine starts RAM at 0x80000000.
     * We allocate 4 KB (4096 bytes) for our program here.
     */
    RAM (rx) : ORIGIN = 0x80000000, LENGTH = 4K
}

/* Define how different sections of the program are placed in memory */
SECTIONS
{
    /* 
     * Place the .text section (code) in RAM starting at 0x80000000.
     * The wildcard matches any section with a name starting with .text
     * including .text, .text.startup, .text._start, etc.
     */
    .text : 
    {
        *(.text*)
    } > RAM
}

/* 
 * Summary:
 * The .text section is linked at address 0x80000000, 
 * which matches the start of RAM in QEMU's virtual memory layout.
 */