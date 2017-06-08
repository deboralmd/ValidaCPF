# --------------------------
# --      Trabalho 2      --
# --------------------------
# Aluno 1: Débora Almeida
# Aluno 2: Renata Soria
# --------------------------
.data
 	CPF:  .word	6 4 6 3 1 1 5 8 0 0 0 
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
	sub $s0, $s0, 44 	# coloca no início da ultima linha
	li  $t0, 0 		# contador das linhas; vai até $s0
	li  $t1, 0
	lw  $a3, SIZE
	
loopMain:
	ble $s0, $t0, fimfim

	li   $t6, 10 		# para cálculo do somador
	li   $t7, 11 		# para o cálculo do resultado
	addi $t1, $t0, 44 	# final da linha a ser percorrida

	#Arrumar nona e décima posição
	addi $t2, $t0, 32
	addi $t3, $t0, 36
	lw   $s3, CPF($t2)
	lw   $s4, CPF($t3)

	jal dig_1
	jal dig_2

	bne $s1, $s4, incrementar
	bne $s2, $s3, incrementar

	jal imprime_cpf

incrementar: 
	addi $t0, $t0, 44 	# vai para a próxima linha
	j loopMain

fimfim:
	li $v0, 10
	lw    $ra, 0($sp)
	addiu $sp, $sp, 4
	syscall
	jr    $ra		 

dig_1:
	addiu $sp, $sp, -4
	sw    $ra, 0($sp)

	# Arrumar os componentes dessa função
	move $t4, $t0 			# a linha que estou fazendo o loop
	li $a0, 1 #auxiliar
	li $a1, 0 #auxiliar
	li $t5, 0 #somador
	li $a2, 0 #contador auxiliar
	#Fim da inicialização de registradores

loopdig_1:
	lw  $t8, CPF($t4)	# carrega o valor do CPF no registrador
	sub $t9, $t6, $a2	# 10-i
	mul $t9, $t8, $t9  	# CPF[pos][i]*10-i
	add $t5, $t5, $t9 	# somador += CPF[pos][i]*(10-i);

	addi $t4, $t4, 4 		# i++
	addi $a2, $a2, 1
	blt  $a2, $a3, loopdig_1 	# vê se chegou no fim da linha

resultado1:
	rem $t9, $t5, $t7 	# somador % 11

	beqz $t9, retornaZero1
	beq  $t9, $a0, retornaZero1

	sub $s1, $t7, $t9 	# 11 - resultado
	j fim1

retornaZero1:
	li $s1, 0

fim1:
	lw    $ra, 0($sp)
	addiu $sp, $sp, 4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
	jr    $ra
dig_2:
	addiu $sp, $sp, -4 
	sw    $ra, 0($sp)

	#Arrumar os componentes dessa função

	move $t4, $t0 #a linha que estou fazendo o loop
	li $t5,0 #inicializa o somador com 0
	li $a2, 0

loopdig_2:
	lw  $t8, CPF($t4)
	div $s5, $t4, 4
	sub $t9, $t7, $a2		# 11 - i
	mul $t9, $t8, $t9		# CPF[pos][i]*11-i
	add $t5, $t5, $t9		# somador += CPF[pos][i]*(11-i); 

	addi $t4, $t4, 4 		# i++
	addi $a2, $a2, 1
	blt  $a2, $a3, loopdig_2	# vê se chegou no fim da linha

valor:
	div $t9, $t5, $t7 	# somador/11
	mul $t9, $t9, $t7 	# valor=(somador/11)*11;  

resultado2:
	sub $t9, $t5, $t9 		# resultado = somador-valor; 

	beqz $t9, retornaZero2
	beq  $t9, $a0, retornaZero2

	sub $s2, $t7, $t9 		# 11 - resultado

	j fim2

retornaZero2:
	li $s2, 0

fim2:
	lw    $ra, 0($sp)
	addiu $sp, $sp, 4 
	jr    $ra
	
imprime_cpf:
	addiu $sp, $sp, -4 
	sw    $ra, 0($sp)

	move $t4, $t0 		# a linha que estou fazendo o loop
	li $t5, 3
	li $t6, 6
	li $t7, 9
	li $t8, 0
	li $a2, 1

#arruma os valores para o if da linha
loopimprime_cpf:
	lw   $t8, CPF($t4)
	li   $v0, 1
	move $a0, $t8
	syscall

	beq $a2, $t5, colocarPonto
	beq $a2, $t6, colocarPonto
	beq $a2, $t7, colocarTraco

volta:
	addi $t4, $t4, 4
	addi $a2, $a2, 1
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
	
