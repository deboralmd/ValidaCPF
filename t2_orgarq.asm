# --------------------------
# --      Trabalho 2      --
# --------------------------
# Aluno 1: Débora Almeida
# Aluno 2: Renata Soria
# --------------------------
.data
	CPF:	.word	6 4 6 3 1 1 5 8 0 0 0 
            		1 3 7 6 6 1 2 8 8 7 6 
              		8 5 2 7 6 5 4 2 2 5 7 
              		1 7 8 1 8 8 8 7 2 8 8 
              		8 2 2 4 3 4 1 5 0 0 3 
             		3 5 7 5 9 0 4 2 5 0 2 
              		1 1 1 5 8 1 3 3 3 1 6 
		        2 1 7 3 6 0 4 1 3 9 8 
        		0 3 3 1 5 2 8 5 1 8 1 
           		4 7 6 3 2 4 5 2 8 7 7 
            		2 4 0 7 4 8 1 4 6 1 7 
              		0 1 6 7 6 8 5 7 9 8 8 
              		6 4 1 0 1 3 1 5 3 4 5 
              		3 8 0 7 5 3 2 5 6 8 7
              		4 1 2 2 2 4 9 3 6 8 3
	NUM:        .word 15
	SIZE:       .word 11
	ponto:      .asciiz "."
	traco:      .asciiz "-"
	novaLinha: .asciiz "\n"
	
.text                   
.globl  main

main:
#s0 - NUM = Pos
#s1 = digito 1
#s2 = digito 2

	addiu $sp, $sp, -4
	sw    $ra, 0($sp)

#Arrumar o Num
	lw  $s0, NUM 
	mul $s0, $s0, 44
	sub $s0, $s0, 44 #coloca no início  da ultima linha
	li  $t0, 0 #contador das linhas, vai até $s0

loopMain:
	addi $t1, $t0, 44 #final da linha a ser percorrida

	#Arrumar nona e décima posição
	addi $t2, $t0, 32
	addi $t3, $t0, 36
	lw $a0, CPF($t2)
	lw $a1, CPF($t3)

	jal dig_1
	move $s1, $v0
	jal dig_2
	move $s2, $v0

	bne $s1, $a0, incremen
	bne $s2, $a1, incremen

	jal imprime_cpf

incremen: 
	addi $t0, $t0, 44 	# vai para a próxima linha
	ble $t0, $s0, loopMain

	li    $v0, 10
	lw    $ra, 0($sp)
	addiu $sp, $sp, 4
	syscall
	jr    $ra		 

dig_1:
	addiu $sp, $sp, -4
	sw    $ra, 0($sp)

	# Arrumar os componentes dessa função

	move $t4, $t0 # a linha que estou fazendo o loop
	li $a0, 1	# auxiliar; resultado == 1
	li $a1, 0	# auxiliar; resultado == 0
	li $t5, 0	# somador
	li $t6, 10	# para cálculo do somador
	li $t7, 11	# para o calculo do resultado
	li $s7, 0	# contador auxiliar
#Fim da inicialização de registradores

loopdig_1:
	lw  $t8, CPF($t4)		# carrega o valor do CPF no registrador
	sub $t9, $t6, $s7		# 10 - i
	mul $t9, $t8, $t9 		# CPF[pos][i]*10-i
	add $t5, $t5, $t9		# somador += CPF[pos][i]*(10-i);

	addi $t4, $t4, 4		#i++
	addi $s7, $s7, 1
	bne  $t4, $t2, loopdig_1	# vê se chegou no fim da linha

resultado1:
	rem $t9, $t5, $t7	# somador % 11

	beqz $t9, retornaZero1
	beq  $t9, $a0, retornaZero1

	sub $v0, $t7, $t9	# 11 - resultado
	j fim1

retornaZero1:
	li $v0, 0

fim1:
	lw    $ra, 0($sp)
	addiu $sp, $sp, 4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
	jr    $ra

dig_2:
	addiu $sp, $sp, -4 
	sw    $ra, 0($sp)

# Arrumar os componentes dessa função

	move $t4, $t0		# a linha que estou fazendo o loop
	li   $t5, 0 		# inicializa o somador com 0
	li   $s7, 0

loopdig_2:
	lw  $t8, CPF($t4)
	div $s5, $t4, 4
	sub $t9, $t7, $s7		# 11 - i
	mul $t9, $t8, $t9		# CPF[pos][i]*11-i
	add $t5, $t5, $t9		# somador+=CPF[pos][i]*(11-i); 

	addi $t4, $t4, 4		# i++
	addi $s7, $s7, 1
	bne  $t4, $t3, loopdig_2 	# vê se chegou no fim da linha

valor:
	div $t9, $t5, $t7		# somador/11
	mul $t9, $t9, $t7		# valor=(somador/11)*11;  

resultado2:
	sub $t9, $t5, $t9		# resultado=somador-valor; 

	beqz $t9, retornaZero2
	beq  $t9, $a0, retornaZero2

	sub $v0, $t7, $t9		# 11 - resultado

	j fim2

retornaZero2:
	li $v0, 0

fim2:
	lw    $ra, 0($sp)
	addiu $sp, $sp, 4 
	jr    $ra

imprime_cpf:
	addiu $sp, $sp, -4 
	sw    $ra, 0($sp)

	move $t4, $t0		# a linha que estou fazendo o loop
	li   $t5, 0
	li   $t6, 0
	li   $t7, 0

#arruma os valores para o if da linha
	addi $t5, $t4, 8	# 3 posicao
	addi $t6, $t4, 20	# 6 posicao
	addi $t7, $t4, 32	# 9 posicao

loopimprime_cpf:
	lw  $t8, CPF($t4)
	li  $v0, 1
	move $a0, $t8
	syscall

	beq $t4, $t5, colocarPonto
	beq $t4, $t6, colocarPonto
	beq $t4, $t7, colocarTraco

volta:
	addi $t4, $t4, 4
	bne  $t4, $t1, loopimprime_cpf
	beq  $t4, $t1, fimLoop

colocarPonto:
	la $a0, ponto	
	li $v0, 4
	syscall
	j volta

colocarTraco:
	la $a0, traco
	li $v0, 4
	syscall
	j volta

fimLoop:
	la $a0, novaLinha
	li $v0, 4
	syscall

	lw    $ra, 0($sp)
	addiu $sp, $sp, 4 
	jr    $ra
	
