generateassembly: main.c
	riscv64-unknown-elf-gcc -O0 -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tm.ld main.c -S -o m.s

printbinaray: main.bin
	xxd -e -c 4 -g 4 main.bin

startqemu: main.elf
	qemu-system-riscv32 -S -M virt -nographic -bios none -kernel main.elf -gdb tcp::1234

connectgdb: main.elf
	gdb-multiarch main.elf -ex "target remote localhost:1234" -ex "break _start" -ex "continue" -q

clean:
	rm -rf *.out *.bin *.elf *.s

help:
	echo "generateassembly"
	echo "machinecode"
	echo "printbinaray"
	echo "startqemu"
	echo "connectgdb"