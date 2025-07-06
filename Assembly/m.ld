# Memory Layout
# The Qemu indicates the Code address to be 0x80000000 and a memory of 4k

MEMORY
{
    RAM : ORIGIN = 0X80000000, LENGTH = 4K
}

# Here we indicate the sections, and the location of the sections

SECTIONS
{
.text : {
    *(.text*)
  } > RAM
}

# so the .text section is located at 0x80000000 (i.e. > RAM)