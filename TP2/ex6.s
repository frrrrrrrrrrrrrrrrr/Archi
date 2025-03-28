.global _start
_start:

	adr r3, tab
	mov r0, #0
	
	
for1:
	cmp r0, #M
	bhs fin_for1
	
	mov r1, r0
	
	add r2, r0, #1
for2:
	cmp r2, #N
	bhs fin_for2
	
	ldr r4, [r3, r2, lsl #2]
	ldr r5, [r3, r1, lsl #2]
	
	cmp r4, r5
	movlt r1, r2
	
	add r2, r2, #1
	b for2
fin_for2:

	cmp r1, r0
	beq end_if
	
	ldr r4, [r3, r0, lsl#2]
	ldr r5, [r3, r1, lsl#2]
	str r5, [r3, r0, lsl#2]
	str r4, [r3, r1, lsl#2]
	
	
end_if:
	
	add r0, r0, #1
	b for1
fin_for1:

_exit:
	b _exit

	tab: .word 22, -12, 0, 9, 5, -1, 5, 43, 10, -10
	
	.equ N, 10
	.equ M, 9
	

	
	
	
	

	