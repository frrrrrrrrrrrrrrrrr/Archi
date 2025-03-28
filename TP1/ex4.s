.global _start
_start:
	mov r1, #0b111000101010
	mov r2, #7
	mov r3, #2
	
	lsr r1, r1, r3
	mov r0, r1
	
	sub r2, r2, r3
	sub r2, r2, #1
	lsr r1, r1, r2
	lsl r1, r1, r2
	sub r0, r0, r1

_exit:
	b _exit



	
	
	
	

	