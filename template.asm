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
	# Colocar aqui o seu codigo!
	lw    $ra, 0($sp)
	addiu $sp, $sp, 4
	li	  $v0, 10
	syscall
  jr    $ra		 

dig_1:
  addiu $sp, $sp, -4 # Atualizar o tamanho da pilha de acordo com os seus registradores!
	sw    $ra, 0($sp)
	# Colocar aqui o seu codigo!
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
