.data

enter_n:
  .asciiz "Enter n: "

enter_r:
  .asciiz "Enter r: "

prompt_continue:
  .asciiz "Wish to continue?: "

printC:
  .asciiz "C"

colon:
  .asciiz ": "

newline:
  .asciiz "\n"

.text

# $a0 -> n
# $a1 -> r
# $s0 -> res1
# $s1 -> res2
# $v0 -> output

comb:
  beq $a0, $a1, L1
  beq $a1, $zero, L1

  addi $sp, $sp, -12
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)

  addi $a0, $a0, -1
  addi $a1, $a1, -1
  jal comb
  move $s0, $v0

  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  addi $sp, $sp, 12

  addi $sp, $sp, -16
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)
  sw $s0, 12($sp)

  addi $a0, $a0, -1
  addi $a1, $a1, 0
  jal comb
  move $s1, $v0

  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  lw $s0, 12($sp)
  addi $sp, $sp, 16

  add $v0, $s0, $s1
  jr $ra

L1:
  addi $v0, $zero, 1
  jr $ra


# $s0 -> n
# $s1 -> r
# $s2 -> res
# $s3 -> c

main:
  # printf("Enter n: ");
  li $v0, 4
  la $a0, enter_n
  syscall

  # scanf("%i", &n);
  li $v0, 5
  syscall
  move $s0, $v0

  # printf("Enter r: ");
  li $v0, 4
  la $a0, enter_r
  syscall

  # scanf("%i", &r);
  li $v0, 5
  syscall
  move $s1, $v0

  # res = comb(n, r);
  addi $sp, $sp, -8
  sw $s0, 0($sp)
  sw $s1, 4($sp)

  move $a0, $s0
  move $a1, $s1
  jal comb
  move $s2, $v0

  lw $s0, 0($sp)
  lw $s1, 4($sp)
  addi $sp, $sp, 8

  # printf("%i", n);
  li $v0, 1
  move $a0, $s0
  syscall

  # printf("C");
  li $v0, 4
  la $a0, printC
  syscall

  # printf("%i", r);
  li $v0, 1
  move $a0, $s1
  syscall

  # printf(": ");
  li $v0, 4
  la $a0, colon
  syscall

  # printf("%i", res);
  li $v0, 1
  move $a0, $s2
  syscall

  # printf("\n");
  li $v0, 4
  la $a0, newline
  syscall

  # printf("Wish to continue?: ");
  li $v0, 4
  la $a0, prompt_continue
  syscall

  # scanf("%s", &c);
  li $v0, 12
  syscall
  move $s3, $v0
  li $v0, 12
  syscall

  # printf("\n");
  li $v0, 4
  la $a0, newline
  syscall
