.global _start
_start:
	mov r1, #5
	mov r0, #1
	mov r2, #0
for: 
	cmp r2, r1
	bhs end_for
	mov r0,r0, lsl#1
	add r2, r2, #1
	b for
	
end_for:
	mov r3, r0
	mov r2, #0
	
while_log:
	cmp r3, #1
	ble end_while
	mov r3, r3, lsr#1
	add r2, r2, #1
	b while_log
end_while:
	