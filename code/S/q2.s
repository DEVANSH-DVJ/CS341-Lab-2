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

  div $a1, $a0
  mflo $t0
  mul $t1, $t0, $s0
  sub $v0, $s1, $t1

  move $v1, $s0

  jr $ra

L1:
  addi $v0, $zero, 0
  addi $v1, $zero, 1
  jr $ra


# $s0 -> a
# $s1 -> m
# $t0 -> x
# $t1 -> y
# $s2 -> res
# $s3 -> c

main:
  # printf("Enter a: ");
  li $v0, 4
  la $a0, enter_a
  syscall

  # scanf("%i", &n);
  li $v0, 5
  syscall
  move $s0, $v0

  # printf("Enter m: ");
  li $v0, 4
  la $a0, enter_m
  syscall

  # scanf("%i", &m);
  li $v0, 5
  syscall
  move $s1, $v0

  # x, y = inv(a, m);
  addi $sp, $sp, -8
  sw $s0, 0($sp)
  sw $s1, 4($sp)

  move $a0, $s0
  move $a1, $s1
  jal inv
  move $t0, $v0
  move $t1, $v1

  lw $s0, 0($sp)
  lw $s1, 4($sp)
  addi $sp, $sp, 8

  # res = (x % m + m) % m;
  div $t0, $s1
  mfhi $t1
  add $t1, $t1, $s1
  div $t1, $s1
  mfhi $s2
