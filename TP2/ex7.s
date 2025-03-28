
	
.global _start
_start:
	adr r0, message
	adr r2, dec
	ldrb r1, [r2]
	
	mov r2, #0
	
while:
	ldrb r3, [r0, r2]
	cmp r3, #0
	beq end_while
	
	add r3, r3, r1
	
	cmp r3, #'Z'
	subhi r3, r3, #26
	
	strb r3, [r0, r2]
	
	add r2, r2, #1
	b while
	
end_while:	
	
_exit:
	b _exit
	
message: .asciz "DTCXQXQWURQWXGBRCUUGTCNGZGTEKEGUWKXCPV"
dec: .word 2
