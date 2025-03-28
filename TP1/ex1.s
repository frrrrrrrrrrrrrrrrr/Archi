.global _start
_start:
	mov r1, #10
	mov r2, #20
	mov r0, r1
	mov r3, r2
while: 
	cmp r0, r3
	beq end_while
	addhs r3, r3, r2
	addlo r0, r0, r1
	b while
end_while:
	
	