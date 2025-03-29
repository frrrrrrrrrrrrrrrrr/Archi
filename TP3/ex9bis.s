.global _start
_start:
	adr r10, tab
	
	mov r2, #0
	mov r3, #0
	
	for_tab:
		cmp r2, #N
		bhs end_tab
		
		ldrb r1, [r10, r2]

		bl _palindrome
		
		add r3, r0
		
		add r2, r2, #1
		b for_tab
	end_tab:
	
_end: b _end

_palindrome:
	stmfd sp!, {r1-r6, lr}
	
	mov r0, #1
	mov r2, #0x01
	mov r3, #0x80
	
	mov r6, #7
	
	lecture:
		cmp r6, #1
		blt fin_palindrome
		
		and r4, r2, r1
		and r5, r3, r1
		lsr r5, r6
		
		cmp r5, r4 @ Verif les bits opposés sont similaires
		movne r0, #0
		bne fin_palindrome
		
		lsl r2, #1
		lsr r3, #1
		sub r6, r6, #2
		b lecture
		
	fin_palindrome:

	ldmfd sp!, {r1-r6, pc}
	

tab: .byte 0xc2, 0b11000011, 9, 252, 0xFF, 0x81, 0b10, 63, 0b11000101, 219
.equ N, 10
.align