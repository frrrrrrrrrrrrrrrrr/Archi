.global _start
_start:

	adr r10, message
	adr r2, dec
	ldrb r1, [r2] @ r1 = dec
	
	for_message:
		ldrb r2, [r10]
		cmp r2, #0 @ 3 pour '\0'
		beq end_message
		
		sub r2, r2, r1 @ r1 -= dec
		
		cmp r2, #65 @ 65 pou 'A'
		addlo r2, r2, #26 @ si r1 < A, on revient à la fin de l'alphabet
		
		strb r2, [r10], #1
		
		b for_message
	end_message:
		
	
_end: b _end

message: .asciz "DTCXQXQWURQWXGBRCUUGTCNGZGTEKEGUWKXCPV"
dec: .word 2