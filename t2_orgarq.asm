# --------------------------
# --      Trabalho 2      --
# --------------------------
# Aluno 1:
# Aluno 2:
# --------------------------
.data
  CPF:  .word 6 4 6 3 1 1 5 8 0 0 0 
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
	nova_linha: .asciiz "\n"
	
.text                   
.globl  main

main:


  addiu $sp, $sp, -4
  sw    $ra, 0($sp)
  	#colocar seu codigo
	jal dig_1
	move $v1,$s0
	jal dig_2
	move $v1,$s1
	
	
	
	
	lw    $ra, 0($sp)
	addiu $sp, $sp, 4
	li	  $v0, 10
	syscall
  jr    $ra		 

dig_1:

#inicialização de componentes para esta função
li $t0, 0    #contador
li $t1,1 #auxiliar
li $t2, 0 #tamanho de cada linha
li $t3, 0 #somador
li $t5,0 #auxiliar
li $t6,10 #para o caulculo do somador
lw $t7, NUM #POS
li $t8, -4
li $t9,11 #para o cálculo do resultado
# fim da inicialização

  
  addiu $sp, $sp, -4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
  sw    $ra, 0($sp)
		
	
	mul $t0, $t7, 44 #define qual linha de cpf vai ser verificada
	sub $t0, $t0, 44 #tem q diminuir 44 se não sempre vai ficar na próxima linha, considerando o vetor começando em UM
	addi $t2,$t0, 32 #posição final da linha do CPF porque só vai até o nono dígito no dig_1

loop: 
	lw $t4, CPF($t0) #carrega o valor do CPF no registrador
	sub $t5, $t6, $t0 #10-i  #t5 é uma variavel auxiliar de resultados
	mul $t5, $t4, $t5 #CPF[pos][i]*10-i
	add $t3, $t3, $t5 #somador total
	
	addi $t0, $t0, 4 #i++
	bne $t0, $t2, loop #se não é o fim do loop continua

resultado:
	
rem $t5, $t3, 11 #resultado

beqz $t5, retornaZero
beq $t5, $t1, retornaZero


sub $v1, $t9, $t5 #return 11-resultado;

lw    $ra, 0($sp)
addiu $sp, $sp, 4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
 jr    $ra

retornaZero:
li $v1, 0



lw    $ra, 0($sp)
addiu $sp, $sp, 4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
 jr    $ra



dig_2:
  addiu $sp, $sp, -4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
	sw    $ra, 0($sp)
	
#inicialização de componentes para esta função
li $t0, 0    #contador
li $t1,1 #auxiliar
li $t2, 0 #tamanho de cada linha
li $t3, 0 #somador inicializado com 0
li $t4,0 #inicializar
li $t5,0 #auxiliar(resultado)
li $t6,11 #para o caulculo do somador
lw $t7, NUM #POS
li $t8, -4
li $t9,0 #auxiliarde resultados valor
# fim da inicialização

	mul $t0, $t7, 44 #define qual linha de cpf vai ser verificada POS
	sub $t0, $t0, 44 #tem q diminuir 44 se não sempre vai ficar na próxima linha, considerando o vetor começando em UM
	addi $t2,$t0, 36 #posição final da linha do CPF porque só vai até o décimo dígito no dig_1

loop2: 
	lw $t4, CPF($t0) #carrega o valor do CPF no registrador
	sub $t5, $t6, $t0 #11-i  #t5 é uma variavel auxiliar de resultados
	mul $t5, $t4, $t5 #CPF[pos][i]*11-i
	add $t3, $t3, $t5 #somador total
	
	addi $t0, $t0, 4 #i++
	bne $t0, $t2, loop2 #se não é o fim do loop continua no loop
	
calculoValor:

	div $t9, $t3, $t6 #somador/11
	mul $t9, $t9, $t6 #valor=(somador/11)*11; 
	
calculoResultado:
	sub $t5, $t3,$t9 #resultado=somador-valor; 

verificarResultado:

beqz $t5, retornaZero2
beq $t5, $t1, retornaZero2

sub $v1, $t6, $t5 #return 11-resultado;

lw    $ra, 0($sp)
addiu $sp, $sp, 4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
 jr    $ra

retornaZero2:
li $v1, 0







	lw    $ra, 0($sp)
	addiu $sp, $sp, 4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
  jr    $ra

imprime_cpf:
  addiu $sp, $sp, -4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
	sw    $ra, 0($sp)
	# Colocar aqui o seu codigo!
	lw    $ra, 0($sp)
	addiu $sp, $sp, 4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
  jr    $ra
