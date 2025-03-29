.global _start
_start:
	adr r0, a
	adr r1, b
	adr r2, somme
	
	ldrb r3, [r0]
	ldrb r4, [r1]
	
	add r3, r3, r4
	
	strb r3, [r2]

_end: b _end

a: .byte 8
b: .byte 12
somme: .fill 1,1
