.global _start
_start:
	mov r1, #79
	mov r0, #0
	
while:
	add r2, r0, #1
	mul r3, r2, r2
	cmp r3, r1
	bhi end_while
	add r0, r0, #1
	b while
end_while:

	