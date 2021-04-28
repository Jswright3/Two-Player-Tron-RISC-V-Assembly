 .globl _start

_start:

	lw t1,SSP
	csrrw zero,64,t1
		
	lw a2, RED
	lw s9, BLUE
	la a3, BMPD
	addi s2,a3,508
	addi a3,a3,512
	li a4,4
	li a7,-4
	li t3,131072
	add s2,s2,t3
	add a3,a3,t3

	
	la t0,inthandler
	csrrw zero,5,t0
	lw t0,KEYBSA
	addi t1,x0,2
	sw t1,0(t0)
	addi t1,zero,0x100
	csrrs x0,4,t1
	csrrsi zero,0,1
	
loop:
	jal wait
	
	jal findx
	jal findy
	
	jal findx2
	jal findy2
	
	lw s10,(a3)
	beq s10,a2,end
	beq s10,s9,end
	lw s10,(s2)
	beq s10,a2,end
	beq s10,s9,end
	
	li s11,255
	beqz a5,end
	beqz s7,end
	beq a5,s11,end
	beq s7,s11,end
	li t6,1
	beq a6,t6,end
	beq a6,s11,end
	beq s8,t6,end
	beq s8,s11,end
	
	sw s9,(s2)
	sw a2,(a3)
	add a3,a3,a4
	add s2,s2,a7
	j loop
	
findx:
	li t0,1024
	div t3,a3,t0
	mul t3,t3,t0
	sub a5,a3,t3
	li t4,4
	div a5,a5,t4
	jr ra
findy:
	li t6,1024
	li t5, 0x10010000
	sub t5,a3,t5
	div a6,t5,t6	
	jr ra
	
	
findx2:
	li t0,1024
	div t3,s2,t0
	mul t3,t3,t0
	sub s7,s2,t3
	li t4,4
	div s7,s7,t4
	jr ra
findy2:
	li t6,1024
	li t5, 0x10010000
	sub t5,s2,t5
	div s8,t5,t6	
	jr ra
	
wait:
	li t2, -8000	#SPEED ADJUSTMENT  the greater the negative number the slower gameplay is, to speed up raise this while remaining negative
waitloop:
	addi t2,t2,1
	bltz t2, waitloop
	jr ra

end:
	li a7,93
	ecall

W:
	li s3,256	
	li s4,-4
	mul a4,s3,s4
	b noevent

A:
	li s3,1
	li s4,-4
	mul a4,s3,s4
	b noevent
S:
	li s3,256	
	li s4,4
	mul a4,s3,s4
	b noevent
D:
	li s3,1
	li s4,4
	mul a4,s3,s4
	b noevent
	
	
I:
	li s3,256	
	li s4,-4
	mul a7,s3,s4
	b noevent

J:
	li s3,1
	li s4,-4
	mul a7,s3,s4
	b noevent
K:
	li s3,256	
	li s4,4
	mul a7,s3,s4
	b noevent
L:
	li s3,1
	li s4,4
	mul a7,s3,s4
	b noevent
	
inthandler:
	csrrw sp,64,sp
	sw ra,12(sp)
	sw t0,8(sp)
	
	csrrw t0,66,zero
	bgtz t0, noevent
	lw a1, KEYBDA
	lw a0,0(a1)
	li s3, 'w'
	li s4, 'a'
	li s5, 's'
	li s6, 'd'
	beq a0,s3,W
	beq a0,s4,A
	beq a0,s5,S
	beq a0,s6,D
	
	li s3, 'i'
	li s4, 'j'
	li s5, 'k'
	li s6, 'l'
	beq a0,s3,I
	beq a0,s4,J
	beq a0,s5,K
	beq a0,s6,L
	
noevent:
	lw ra,12(sp)
	lw t0, 8(sp)
	csrrw sp, 64, sp
	uret


.data
BMPD: .word 0x10010000
RED: .word 0x00ff0000
SSP: .word 0xfffffff0
KEYBDA: .word 0xffff0004
KEYBSA: .word 0xffff0000
BLUE: .word 0x00ffff

