.global _start
_start:

	@intitialisation
	mov r1, #0
	bl _afficher_temperature
	
	ldr r4, =SESEGD
	ldr r5, =LEDS
	str r1, [r4]
	str r1, [r5]
	
	
	@ Attendre que le bouton on soit allumé
	ldr r0, =SWITCHES
	
	pas_allume:
		ldr r4, [r0]
		cmp r4, #1
		beq allume
	
		b pas_allume
	allume:
		mov r4, #0x2FF
		str r4, [r0]
	
	@ Attendre qu'un programme soit séléctionné
	
	ldr r2, =PUSHB
	pas_selec:
		ldr r4, [r0]
		cmp r4, #0
		bne selec
	
		b pas_selec
	selec:
		mov r5, #0x2FF
		str r5, [r0]
		
	cmp r4, #1
	bleq _cycle0
	
	cmp r4, #02
	bleq _cycle1
	
	cmp r4, #04
	bleq _cycle2
	
	
_end: b _end
	
	
	
_wait1:
	stmfd sp!, {r0, r1, lr}
	
	mov r0, #0
	
	ldr r1, = #WAIT
	
	for_wait1:
		cmp r0, r1
		bhi fin_for_wait1
		
		add r0, r0, #1
		
		b for_wait1
	fin_for_wait1:
	
	ldmfd sp!,{r0, r1, lr}
	mov pc, lr



	
_waitn:
	stmfd sp!, {r8, lr}
	
	for_waitn:
		cmp r8, #0
		ble end_for_waitn
		
		bl _wait1
		sub r8, r8, #1
		
		b for_waitn
	end_for_waitn:
	
	ldmfd sp!, {r8, lr}
	mov pc, lr



_remplir:
	stmfd sp!, {r0-r2, r8, lr}
	
	ldr r0, =LEDS
	mov r1, #0
	mov r2, #1
	mov r8, #5

	
	for_remplir:
		cmp r1, #10
		bgt fin_for_remplir
		
		mov r8, #5
		bl _waitn
		
		str r2, [r0]
		
		lsl r2, r2, #1
		add r2, r2, #1
		
		
		add r1, r1, #1
		
		b for_remplir
	fin_for_remplir:
		
	
	adr r0, cuve_pleine
	mov r1, #1
	
	strb r1, [r0]
	
	ldmfd sp!,{r0-r2, r8, lr}
	mov pc, lr
	
	
	
_vider:
	stmfd sp!, {r0-r2, r8, lr}
	
	ldr r0, =LEDS
	mov r1, #0
	ldr r2, = #0b1111111111
	mov r8, #5
	
	for_vider:
		cmp r1, #10
		bhi fin_for_vider
		
		str r2, [r0]
		
		mov r2, r2, lsr#1
		
		bl _waitn
		add r1, r1, #1
		
		b for_vider
	fin_for_vider:
		
	
	adr r0, cuve_pleine
	mov r1, #0
	
	str r1, [r0]
	
	ldmfd sp!,{r0-r2, r8, lr}
	mov pc, lr
	
	
_afficher_temperature:
	stmfd sp!, {r0-r2,lr}
	ldr r0, =SESEGG
	

	cmp r1, #0
	ldreq r2, =0b0011111100111111
	
	cmp r1, #1
	ldreq r2, =0b0000011000111111
	
	cmp r1, #2
	ldreq r2, =0b0101101100111111
	
	cmp r1, #3
	ldreq r2, =0b0100111100111111
	
	cmp r1, #4
	ldreq r2, =0b0110011000111111
	
	cmp r1, #5
	ldreq r2, =0b0110110100111111
	
	cmp r1, #6
	ldreq r2, =0b0111110100111111
	
	str r2, [r0]
	
	ldmfd sp!,{r0-r2, lr}
	mov pc, lr
	
	
	
	
_chauffer:
	stmfd sp!, {r0, r1, r8,lr}
	
	mov r0, r1
	mov r1, #0
	mov r8, #5
	
	for_chauffer: cmp r1, r0
		bhi fin_for_chauffer
		
		bl _afficher_temperature
		
		bl _waitn
		
		add r1, r1, #1
		b for_chauffer
	fin_for_chauffer:

	ldmfd sp!,{r0, r1, r8, lr}
	mov pc, lr
	

_tourner_tambour:
	stmfd sp!, {r0-r9,lr}
	
	adr r0, positions_tambour
	ldr r9, =SESEGD
	
	@set-up de la vitesse
	cmp r2, #0
	moveq r8, #5
	movne r8, #1

	
	for_nb_tour:
		cmp r3, #0
		bls fin_for_nb_tour
		
		@set-up du sens
		cmp r1, #0
		moveq r5, #1 @ pas de la boucle
		moveq r4, #0 @ position de dep (début du tableau)
		moveq r6, #9 @ fin du tableau
	
		movne r5, #-1 @ pas de la boucle
		movne r4, #8 @ position de dep (fin du tableau)
		movne r6, #-1 @ fin du tableau
	
		for_tour_tambour:
			cmp r4, r6
			beq fin_for_tour_tambour

			ldr r7, [r0, r4, lsl#2]
			str r7, [r9]
			bl _waitn

			add r4, r4, r5

			b for_tour_tambour
		fin_for_tour_tambour:
		
		sub r3, r3, #1
		b for_nb_tour
	fin_for_nb_tour:
		
	ldmfd sp!,{r0-r9, lr}
	mov pc, lr
	

cuve_pleine: .byte 0

.equ LEDS, 0xFF200000
.equ WAIT, 0x1ffff
.equ SESEGG, 0xFF200030
.equ SESEGD, 0xFF200020
.equ SWITCHES, 0xFF200040
.equ PUSHB, 0xFF200050
.align 
positions_tambour: .word 0x3000, 0x2100, 0x0101, 0x0003, 0x0006, 0x000c, 0x0808, 0x1800, 0x3000
.align	
	
		
	
	