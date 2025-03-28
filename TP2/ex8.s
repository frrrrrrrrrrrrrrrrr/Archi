.global _start
_start:

	adr r0, chaine1
	adr r1, chaine2
	
	mov r2, #0
	mov r3, #0
	
while:
	ldrb r4, [r0, r2]
	cmp r4, #0
	beq fin_while
	
	@ comparaison pour savoir si le caractère nous interesse
	cmp r4, #A
	blo fin_if
	cmp r4, #z
	bhi fin_if
	
	@ si le caractère nous intresse, on le stock dans chaine2 (et on icremente l'indice j)
	
	strb r4 [r1, r3], #1
	
fin_if:
	add r2, r2, #1
	
fin_while:

	@ on finit la chaine de caractère
	mov r4, #0
	strb r4 [r1, r3]
	
	
	
_exit:
	b _exit
	
chaine1: .asciz "JLkd2nj345bnzApdd0j9"
chaine2: .fill 255,1

while(chaine1[i]!= '\0'){
	if(A<=chaine1[i]<=z){
		chaine2[j] = chaine [i]
		j++
	}
	i++
}