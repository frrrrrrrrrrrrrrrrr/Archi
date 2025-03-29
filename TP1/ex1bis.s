.global _start
_start:
	
	mov r1, #nb1
	mov r2, #nb2
	
	while: cmp r1, r2
		beq fin_while
		
		addhi r2, r2, #nb2
		addlo r1, r1, #nb1
		
		b while
	fin_while:
	
_end: b _end
	
.equ nb1, 9
.equ nb2, 6