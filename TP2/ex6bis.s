.global _start
_start:

	adr r10, tab @ r10 = tab
	mov r11, #N
	sub r3, r11, #1 @ r3 = N - 1
	mov r0, #0 @ r0 = i
	
	
	for1:
		cmp r0, r3
		bhs end_for1
		
		mov r1, r0 @ r1 = minindex
		add r2, r0, #1 @ r2 = j = i + 1
		for2:
			cmp r2, #N
			bhs end_for2
			
			ldr r4, [r10, r2, lsl#2] @ r4 = tab[j]
			ldr r5, [r10, r1, lsl#2] @ r5 = tab[minindex]
			
			cmp r4, r5
			movlt r1, r2
			
			add r2, r2, #1
			b for2
		end_for2:
		
		cmp r1, r0
		beq end_if
			ldr r4, [r10, r0, lsl#2] @ r4 = tmp = tab[i]
			ldr r5, [r10, r1, lsl#2] @ r5 = tab[minindex]
			
			str r5, [r10, r0, lsl#2] @ tab[i] = tab[minindex]
			str r4, [r10, r1, lsl#2] @ tab[minindex] = tab[i]
		end_if:
		
	
		add r0, r0, #1
		b for1
	end_for1:
	
	
_end: b _end

tab: .word 22, -12, 0, 9, 5, -1, 5, 43, 10, -10
.equ N, 10
.align