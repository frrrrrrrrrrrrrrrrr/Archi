.global _start
_start:
	
	
_end: b _end

_voisines:
	stmfd sp!, {r2}
	
	mov r0, #0
	
	ldrb r2, [r1, #1]
	cmp r2, #'o'
	addeq r0, r0, #1
	
	ldrb r2, [r1, #-1]
	cmp r2, #'o'
	addeq r0, r0, #1
	
	ldrb r2, [r1, #16]
	cmp r2, #'o'
	addeq r0, r0, #1
	
	ldrb r2, [r1, #-16]
	cmp r2, #'o'
	addeq r0, r0, #1
	
	
	ldmfd sp!, {r2}
	mov pc, lr
	
_calcul:
	stmfd sp!, {r1, r2}
	
	adr r2, population
	
	mov r3, r1
	add r3, r3, #16
	
	mov r4, #1
	
for1:
	cmp r4, #15
	bhs fin_for1
	
	add r1, r3, r4
	bl _voisines
	
	strb r0, [r2]
	add r4, r4, #1
	
	b for1
fin_for1:
	
	ldmfd sp!, {r2}
	mov pc, lr
	