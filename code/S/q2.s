.data

enter_a:
  .asciiz "Enter a: "

enter_m:
  .asciiz "Enter m: "

prompt_continue:
  .asciiz "Wish to continue?: "

print_ast:
  .asciiz "*"

print_mod:
  .asciiz " = 1 (mod "

end_mod:
  .asciiz ")\n"

newline:
  .asciiz "\n"

.text

# $a0 -> a
# $a1 -> b
# $s0 -> x1
# $s1 -> y1
# $v0 -> x
# $v1 -> y

inv:
  beq $a0, $zero, L1

  addi $sp, $sp, -12
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)

  move $t0, $a0
  divu $a1, $a0
  mfhi $a0
  move $a1, $t0
  jal inv
  move $s0, $v0
  move $s1, $v1

  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  addi $sp, $sp, 12
L1:
  addi $v0, $zero, 0
  addi $v1, $zero, 1
  jr $ra

