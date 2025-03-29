.global _start
_start:
	adr r1, glider
	
	boucle:
		bl _generation
		b boucle
	
_end: b _end



_voisines:
	stmfd sp!, {r2-r5, lr}
	
	mov r0, #0
	@ r1-16 r1-17 r1-15 r1+16 r1+15 r1+17 r1+1 r1-1
	mov r5, #86
	
	@ verif cellule avant r1
	sub r2, r1, #1
	ldrb r3, [r2]
	@strb r5, [r2]
	cmp r3, #111 @ 111 = 'o'
	addeq r0, #1
	
	@verif cellule après r1
	ldrb r3, [r1, #1]
	@strb r5, [r1, #1]
	cmp r3, #111
	addeq r0, #1
	
	
	mov r2, #15
	for_up_down:
		cmp r2, #17
		bhi end_up_down

		@comparaison voisine dessous
		ldrb r3, [r1, r2]
		@strb r5, [r1, r2]
		cmp r3, #111
		addeq r0, #1
		
		@comparaison voisine dessus
		sub r4, r1, r2
		ldrb r3, [r4]
		@strb r5, [r4]
		cmp r3, #111
		addeq r0, #1
		
		add r2, r2, #1
		b for_up_down
	end_up_down:
	
	ldmfd sp!, {r2-r5, pc}
	
	
	
_calcul:
	stmfd sp!, {r0-r4, r10, lr}
	
	adr r10, population
	
	mov r3, #1
	
	add r1, r1, #16 @saut de la première ligne
	add r10, r10, #16
	
	for_lignes:
		cmp r3, #15
		bhs end_lignes
		
		add r1, r1, #1 @saut de la première case
		add r10, r10, #1
		
		mov r4, #1
		for_cases:
			cmp r4, #15
			bhs end_cases
			
			bl _voisines @ compte du nombre de voisine
			
			strb r0, [r10]
			
			add r1, r1, #1 @on passe à la case suivante
			add r10, r10, #1
			
			add r4, r4, #1
			b for_cases
		end_cases:
		
			
		
		add r3, r3, #1
		b for_lignes
	end_lignes:
	
	ldmfd sp!, {r0-r4, r10, pc}
	
	
_generation:
	stmfd sp!, {r0-r10, lr}
	
	bl _calcul
	
	adr r10, population
	
	mov r8, #111 @caractère vivante
	mov r9, #32 @caractère morte
	
	mov r3, #1
	
	add r1, r1, #16 @saut de la première ligne
	add r10, r10, #16
	
	for_lignesg:
		cmp r3, #15
		bhs end_lignesg
		
		add r1, r1, #1 @saut de la première case
		add r10, r10, #1
		
		mov r4, #1
		for_casesg:
			cmp r4, #15
			bhs end_casesg
			
			ldrb r6, [r1]
			cmp r6, r8 @ verif si cellule vivante
			beq vivante
			pas_vivante:
			
				ldrb r7, [r10] @ verif nb voisins
				cmp r7, #3
				bne fin_vivante
				strb r8, [r1] @ la cellule renait
				
			
			b fin_vivante
			vivante:
			
				ldrb r7, [r10] @ verif nb voisins
				cmp r7, #3
				beq fin_vivante
				cmp r7, #2
				beq fin_vivante
				strb r9, [r1] @ la cellule meurt 
				
			
			fin_vivante:
			
			add r1, r1, #1 @on passe à la case suivante
			add r10, r10, #1
			
			add r4, r4, #1
			b for_casesg
		end_casesg:
		
			
		
		add r3, r3, #1
		b for_lignesg
	end_lignesg:
	
	
	
	
	ldmfd sp!, {r0-r10, pc}


grille:
.ascii "  o  o          "
.ascii "  ooo    ooo  o "
.ascii "o o     ooo o   "
.ascii "    o o o o o  o"
.ascii "o    ooo o      "
.ascii "       o oo     "
.ascii "     ooo        "
.ascii "       o  o o o "
.ascii " o   o     o    "
.ascii "o   oo ooo o    "
.ascii "o     oo        "
.ascii "     o   o     o"
.ascii "oo o  o     o o "
.ascii "    oo    o     "

blinker:
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "     o          "
  .ascii "    ooo         "
  .ascii "     o          "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "

  .ascii "                "
glider:
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "    ooo         "
  .ascii "      o         "
  .ascii "     o          "
  .ascii "                "
  .ascii "                "
  .ascii "                "

population: .fill 16*16,1,0


