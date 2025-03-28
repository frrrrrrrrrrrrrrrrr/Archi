.global _start
_start:
	adr r2, tab
	mov r3, #0
	mov r4, #0

for: 
	cmp r3, #10
	bhs fin_for
	ldrb r1, [r2, r3]
	
	bl _est_palindrome
	
	add r4, r4, r0
	add r3, r3, #1
	b for
	
fin_for:
	
	
_exit : b _exit
	
_est_palindrome:
	stmfd sp!, {r3-r7}

	mov r5, #0
	mov r2, #0b00000001
	mov r6, #0b10000000
	mov r7, #7
	mov r0, #1
	
for2:
	cmp r5, #4
	bhs fin_for2
	
	and r3, r1, r2
	and r4, r1, r6
	mov r4, r4, lsr r7
	cmp r4, r3
	movne r0, #0
	
	sub r7, r7, #2
	
	mov r2, r2, lsl#1
	mov r6, r6, lsr#1
	
	add r5, r5, #1
	b for2
	
fin_for2:
		
	
	ldmfd sp!, {r3-r7}
	mov pc, lr

tab: .byte 0xc2, 0b11000011, 9, 252, 0xFF, 0x81, 0b10, 63, 0b11000101, 219
