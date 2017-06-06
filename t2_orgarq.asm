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

li $t0, 0    #contador
li $t1,1 #auxiliar
li $t8,0 #auxiliar
lw $a3, NUM #loop externo (não esquecer de multiplicar por 4 o NUM,$a3)
li $t2, 0 #tamanho de cada linha
li $a2, -4

  addiu $sp, $sp, -4
  sw    $ra, 0($sp)
  	#colocar seu codigo
	jal dig_1
	lw    $ra, 0($sp)
	addiu $sp, $sp, 4
	li	  $v0, 10
	syscall
  jr    $ra		 

dig_1:


  addiu $sp, $sp, -4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
	sw    $ra, 0($sp)
		
	li $t9,10 #para o caulculo do somador
  	li $a1,11 #para o cálculo do resultado
	li $t3, 0 #somador
	mul $s0, $a3, 4 #define o tamanho do loop externo
loopExterno:
	addi $t2,$t2, 44 #linha interna
	addi $a2, $a2, 4 #j++
	beq $a2,$s0, resultado

loop: 
	lw $t4, CPF($t0) #carrega o valor do CPF no registrador
	sub $t5, $t9, $t0 #10-i  #t5 é uma variavel auxiliar de results
	mul $s1, $t4, $t5 #CPF[pos][i]*10-i
	add $t3, $t3, $s1 #somador total
	
	addi $t0, $t0, 4 #i++
	bne $t0, $t2, loop #se não é o fim do loop continua
	beq $t0,$t2, loopExterno #se chegar no fim do i vai pro loop externo
	
resultado:
	
	rem $t5, $t3, 11 #resultado

verificacaoResultado:
beqz $t5, retornaZero
beq $t5, $t1, retornaZero

sub $v0, $a1, $t5 #return 11-resultado;

retornaZero:
li $v0, 0

#v0 TEM O RESULTADO!!!!!!

lw    $ra, 0($sp)
addiu $sp, $sp, 4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
 jr    $ra

dig_2:
  addiu $sp, $sp, -4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
	sw    $ra, 0($sp)
	# Colocar aqui o seu codigo!
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
