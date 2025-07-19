generateassembly: c-asm.c
	riscv64-unknown-elf-gcc -O0 -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tm.ld c-asm.c -S

siddhesh: c-asm.c m.s
	riscv64-unknown-elf-gcc -O0 -ggdb -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tm.ld m.s c-asm.c -o main.elf
	riscv64-unknown-elf-objcopy -O binary main.elf main.bin

printbinaray: main.bin
	xxd -e -c 4 -g 4 main.bin

startqemu: main.elf
	qemu-system-riscv32 -S -M virt -nographic -bios none -kernel main.elf -gdb tcp::1234

connectgdb: main.elf
	gdb-multiarch main.elf -ex "target remote localhost:1234" -ex "break _start" -ex "continue" -q

clean:
	rm -rf *.out *.bin *.elf *c-asm.s

help:
	echo "generateassembly"
	echo "siddhesh"
	echo "machinecode"
	echo "printbinaray"
	echo "startqemu"
	echo "connectgdb"