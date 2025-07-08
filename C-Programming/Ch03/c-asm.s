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
