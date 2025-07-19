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
	li	a5,2
	sw	a5,-24(s0)
	li	a5,2
	sw	a5,-20(s0)
	lw	a4,-24(s0)
	li	a5,3
	beq	a4,a5,.L2
	lw	a4,-24(s0)
	li	a5,3
	bgt	a4,a5,.L3
	lw	a4,-24(s0)
	li	a5,1
	beq	a4,a5,.L4
	lw	a4,-24(s0)
	li	a5,2
	beq	a4,a5,.L5
	j	.L3
.L4:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L5:
	lw	a5,-20(s0)
	addi	a5,a5,2
	sw	a5,-20(s0)
	j	.L6
.L2:
	lw	a5,-20(s0)
	addi	a5,a5,3
	sw	a5,-20(s0)
	j	.L6
.L3:
	lw	a5,-20(s0)
	addi	a5,a5,100
	sw	a5,-20(s0)
.L6:
	nop
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	sidhesh, .-sidhesh
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
