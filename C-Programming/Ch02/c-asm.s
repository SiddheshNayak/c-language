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
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC0)
	lw	a5,%lo(.LC0)(a5)
	sw	a5,-20(s0)
	li	a5,0
	mv	a0,a5
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	sidhesh, .-sidhesh
	.section	.rodata
	.align	2
.LC0:
	.word	1073741824
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
