.global _start
_start:
	adr r2, tab
	mov r3, #0
	mov r4, #0

for: 
	cmp r3, #10
	bhs fin_for
	ldrb r1, [r2, r3]
	add r3, r3, #1
	bl _est_palindrome
	
	add r4, r4, r0
	
	b for
	
fin_for:
	
	
_exit : b _exit
	
_est_palindrome:
	stmfd sp!, {r3, r4}
	
	mov r0, #1
	
	@ verification du 1er et 8eme bit
	and r3, r1, #1
	and r4, r1, #0b10000000
	mov r4, r4, lsr#7
	cmp r4, r3
	movne r0, #0
	
	@ verification du 2eme et 7eme bit
	and r3, r1, #0b10
	and r4, r1, #0b01000000
	mov r4, r4, lsr#5
	cmp r4, r3
	movne r0, #0
	
	@ verification du 3eme et 6eme bit
	and r3, r1, #0b100
	and r4, r1, #0b00100000
	mov r4, r4, lsr#3
	cmp r4, r3
	movne r0, #0
	
	@ verification du 4eme et 5eme bit
	and r3, r1, #0b1000
	and r4, r1, #0b00010000
	mov r4, r4, lsr#1
	cmp r4, r3
	movne r0, #0
		
	
	ldmfd sp!, {r3,r4}
	mov pc, lr

tab: .byte 0xc2, 0b11000011, 9, 252, 0xFF, 0x81, 0b10, 63, 0b11000101, 219
