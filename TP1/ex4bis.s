.global _start
_start:

	mov r1, #0b111000101011
	mov r2, #3
	mov r3, #0
	
	mov r4, #0
	sub r5, r2, r3
	
	for_masque:
		cmp r5, #0
		blt end_for_masque
		
		lsl r4, r4, #1
		add r4, r4, #1
		
		sub r5, r5, #1
		b for_masque
	end_for_masque:
	
	lsl r4, r3
	
	and r0, r1, r4
	
	lsr r0, r3

_end: b _end

