.global _start
_start:
	
	mov r0, #0
	mov r1, #N
	mov r2, #0 @ r2 = r0²
	
	
	while: 
		@ (r+1)² = r² + 2r + 1
		add r2, r2, r0, lsl#1
		add r2, r2, #1
		
		cmp r2, #N
		bhi end_while
		
		add r0, r0, #1
		
		b while
	end_while:
		
	
		
		
_end: b _end

.equ N, 79
