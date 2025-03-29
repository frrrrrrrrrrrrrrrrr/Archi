.global _start
_start:
	@@@@ Initialisation de la machine @@@@
	etat_initial: 
	
	ldr r10, =SEG7D
	mov r1, #0
	str r1, [r10]
	
	bl _afficher_temperature
	
	ldr r11, =LEDS
	str r1, [r11]
	
	
	@@@@ Attente du démarrage de la machine @@@@
	
	ldr r11, =SWITCHES
	mov r1, #1
	
	pas_allume: 
		ldr r0, [r11]
		cmp r0, #1
		bne pas_allume
		
		
	@@@@ Attente de la séléction d'un programme @@@@
	
	ldr r12, =PUSH_BUT
	
	pas_selec:
		bl _verif_eteint
		
		@ On regarde si un cycle a été selectionné
		ldr r2, [r12]
		cmp r2, #0b1
		beq cycle0
		cmp r2, #0b10
		beq cycle1
		cmp r2, #0b100
		beq cycle2
		
		b pas_selec
		
	cycle0:
		bl _remplir
		bl _verif_eteint
			
		mov r1, #3
		bl _chauffer
		bl _verif_eteint
		
		mov r2, #0
		mov r3, #1
		mov r0, #0
		
		lavage_cycle0:
			cmp r0, #2
			bhs fin_lavage_cycle0
			
			mov r1, #0
			bl _tourner_tambour
			mov r1, #1
			bl _tourner_tambour
			
			add r0, r0, #1
			b lavage_cycle0		
		fin_lavage_cycle0:
		bl _verif_eteint
		
		mov r2, #1
		mov r3, #3
		mov r0, #0
		essorage_cycle0:
			cmp r0, #2
			bhs fin_essorage_cycle0
			
			mov r1, #0
			bl _tourner_tambour
			mov r1, #1
			bl _tourner_tambour
			
			add r0, r0, #1
			b essorage_cycle0		
		fin_essorage_cycle0:
		b eteint
		
		
	
	cycle1:
		b eteint
	cycle2:
		b eteint
	
		
	eteint:
		mov r0, #0
		str r0, [r12]
		bl _vider
		b etat_initial

_end: b _end

_verif_eteint:
	stmfd sp!, {r0, lr}
	
	ldr r0, [r11]
	cmp r0, #1
	bne eteint
	
	ldmfd sp!, {r0, pc}
	

@@@@ Question 1 @@@@@

_wait1:
	stmfd sp!, {r0-r1, lr}
	
	mov r0, #0
	ldr r1, =WAIT
	
	while_wait1:
		cmp r0, r1
		bhs fin_wait1
		
		add r0, r0, #1
		b while_wait1
	fin_wait1:
	
	ldmfd sp!, {r0-r1, pc}



@@@@ Question 2 @@@@

_waitn:
	stmfd sp!, {r8, lr}
	
	for_waitn:
		cmp r8, #0
		beq fin_waitn
		
		bl _wait1
		
		sub r8, r8, #1
		b for_waitn
	fin_waitn: 
	
	ldmfd sp!, {r8, pc}
	
	
	
@@@@ Question 3 @@@@

_remplir:
	stmfd sp!, {r0-r1,r8, r10-r11, lr}
	
	ldr r10, =LEDS
	adr r11, cuve_pleine
	mov r8, #5 @variable attente
	
	mov r0, #0b1 @ état des leds
	mov r1, #0 @ indice de boucle
	
	for_remplir:
		cmp r1, #10
		bhi end_remplir
		
		bl _waitn
		
		str r0, [r10]@ affichage des leds
		
		@ Modification de l'état des leds
		lsl r0, #1 
		add r0, r0, #1
		
		add r1, r1, #1
		b for_remplir
	end_remplir:
	
	mov r1, #1
	strb r1, [r11] @ modification de la variable cuve pleine
	
	ldmfd sp!, {r0-r1,r8, r10-r11, pc}
	
@@@@ Question 4 @@@@

_vider:
	stmfd sp!, {r0-r1, r10-r11, lr}
	
	ldr r10, =LEDS
	adr r11, cuve_pleine
	
	mov r0, #0x01ff @ état des leds
	mov r1, #0
	
	for_vider:
		cmp r1, #10
		bhi end_vider
		
		bl _waitn
		
		str r0, [r10] @ on modifie les leds
		
		lsr r0, #1 @ on enlève une leds
	
		
		add r1, r1, #1
		b for_vider
	end_vider:
	
	mov r1, #0
	
	strb r1, [r11] @ modification de la variable cuve_pleine
	
	
	ldmfd sp!, {r0-r1, r10-r11, pc}
	
@@@@ Question 5 @@@@

_afficher_temperature:
	stmfd sp!, {r0-r2, r10, lr}
	
	ldr r10, =SEG7G
	mov r0, #0b00111111 @  code affichage du 0
	
	cmp r1, #0
	moveq r2, r0
	
	cmp r1, #1
	moveq r2, #0b00000110
	
	cmp r1, #2
	moveq r2, #0b01011011
	
	cmp r1, #3
	moveq r2, #0b01001111
	
	cmp r1, #4
	moveq r2, #0b01100110
	
	cmp r1, #5
	moveq r2, #0b01101101
	
	cmp r1, #6
	moveq r2, #0b01111101
	
	lsl r2, #8
	add r2, r2, r0 @ on ajoute le 0 après le chiffre des dizaines
	
	str r2, [r10] @ affichage du nombre
	
	ldmfd sp!, {r0-r2, r10, pc}
	
_chauffer:
	stmfd sp!, {r0-r1, r8, lr}
	
	mov r0, r1
	mov r1, #0
	mov r8, #5
	
	for_chauffer:
		cmp r1, r0
		bhi fin_chauffer
		
		bl _afficher_temperature
		
		bl _waitn
		
		add r1, r1, #1
		b for_chauffer
	fin_chauffer:
	
	ldmfd sp!, {r0-r1, r8, pc}
	
	
	
	
@@@@ Question 6 @@@@

_tourner_tambour:
	stmfd sp!, {r0-r11, lr}
	
	adr r10, positions_tambour
	ldr r11, =SEG7D
	
	@ set-up de la vitesse
	cmp r2, #0
	moveq r8, #5
	movne r8, #1
	
	@ set-up du sens de lecture
	cmp r1, #0
	bne gauche
	droite:
		mov r4, #0 @ debut
		mov r5, #8 @ fin
		mov r6, #1 @ pas
	b fin_set_up
	gauche:
		mov r4, #8 @ debut
		mov r5, #0 @ fin
		mov r6, #-1 @ pas
	fin_set_up:
	
	
	for_nb_tours:
		cmp r3, #0
		beq fin_tourner_tambour
		
		mov r7, r4 @ remise à zéro du compteur
		for_etapes_tour:
			cmp r7, r5
			beq fin_etapes_tour
			
			ldr r9, [r10, r7, lsl#2] @lecture position tambour
			str r9, [r11] @ affichage position tambour
			
			bl _waitn
			
			add r7, r7, r6
			b for_etapes_tour
		fin_etapes_tour:
		
		sub r3, r3, #1
		b for_nb_tours
	fin_tourner_tambour:
	
	ldmfd sp!, {r0-r11, pc}
	
	





	
.equ WAIT, 0x1FFFF
.equ LEDS, 0xFF200000
.equ SEG7D, 0xFF200020
.equ SEG7G, 0xFF200030
.equ SWITCHES, 0xFF200040
.equ PUSH_BUT, 0xFF200050 

cuve_pleine: .byte 0
.align
positions_tambour: .word 0x3000, 0x2100, 0x0101, 0x0003, 0x0006, 0x000c, 0x0808, 0x1800, 0x3000
	