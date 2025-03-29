.global _start
_start:
	@@@@@@@ Question 1 @@@@@@@@
	mov r1, #N
	mov r0, #1
	
	for: cmp r1, #0
		bls end_for
		
		lsl r0, #1
		
		sub r1, r1, #1
		b for
	end_for:
	
	@ plus efficace, sans boucle
	mov r2, #1
	lsl r2, #N
	
	@@@@@@ Question 2 @@@@@@@@@
	
	for2: cmp r0, #1
		bls end_for2
		
		lsr r0, #1
		
		add r1, r1, #1
		b for2
	end_for2:
	
	
		
		
_end: b _end

.equ N, 5
