.global _start
_start:

	adr r10, chaine1
	adr r11, chaine2
	
	for_chaine1:
		ldrb r0, [r10], #1
		cmp r0, #0
		beq end_chaine1
		
		cmp r0, #57
		bhi ecrire
		cmp r0, #48
		blo ecrire
		b nombre
		
		ecrire:
			strb r0, [r11], #1
		nombre:
		
		b for_chaine1
	end_chaine1:
		
	
_end: b _end

chaine1: .asciz "JLkd2nj345bnzApdd0j9"
chaine2: .fill 255,1