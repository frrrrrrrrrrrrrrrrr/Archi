.global _start
_start:
	a: .byte 8
	b: .byte 12
	somme: .fill 1,1
	
	adr r5, somme
	
	adr r0, a
	ldrb r1, [r0]
	adr r2, b
	ldrb r3, [r1]
	
	add r4, r1, r3
	
	str r4, [r5]
	
	
	

_exit:
	b _exit



	
	
	
	

	