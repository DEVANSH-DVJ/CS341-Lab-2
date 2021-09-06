.data

enter_n:
  .asciiz "Enter n: "

enter_r:
  .asciiz "Enter r: "

continue:
  .asciiz "Wish to continue?: "

printC:
  .asciiz "C"

colon:
  .ascii ": "

newline:
  .asciiz "\n"

.text

# $a0 -> n
# $a1 -> r
# $s0 -> res1
# $s1 -> res2
# $v0 -> output

.comb:
  beq $a0, $a1, L1
  beq $a0, $zero, L1

  addi $sp, $sp, -12
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)

  addi $a0, $a0, -1
  addi $a1, $a1, -1
  jal comb
  move $s0, $v0

  addi $sp, $sp, 12
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)

  addi $sp, $sp, -16
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)
  sw $s0, 12($sp)

  addi $a0, $a0, -1
  addi $a1, $a1, 0
  jal comb
  move $s1, $v0

  addi $sp, $sp, -20
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  lw $s0, 12($sp)

  addi $v0, $s0, $s1
  jr $ra

L1:
  addi $v0, $zero, 1
  jr $ra

