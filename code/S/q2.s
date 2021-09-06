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
  # if (a == 0) goto L1;
  beq $a0, $zero, L1

  # x1, y1 = comb(b % a, a);
  addi $sp, $sp, -12
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)

  move $t0, $a0 # t0 -> a
  divu $a1, $a0
  mfhi $a0 # a0 -> b % a
  move $a1, $t0 # a1 -> a
  jal inv
  move $s0, $v0
  move $s1, $v1

  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  addi $sp, $sp, 12

  # x = y1 - (b / a) * x1;
  div $a1, $a0
  mflo $t0 # t0 -> (b / a)
  mul $t0, $t0, $s0 # t0 -> (b / a) * x1
  sub $v0, $s1, $t0 # v0 -> y1 - (b / a) * x1

  # y = x1;
  move $v1, $s0 # v1 -> x1

  # return x, y;
  jr $ra

L1:
  # return 0, 1;
  addi $v0, $zero, 0 # v0 -> 0
  addi $v1, $zero, 1 # v1 -> 1
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
  mfhi $t2 # t2 -> x % m
  add $t2, $t2, $s1 # t2 -> x % m + m
  div $t2, $s1
  mfhi $s2 # s2 -> (x % m + m) % m

  # printf("%i", a);
  li $v0, 1
  move $a0, $s0
  syscall

  # printf("*");
  li $v0, 4
  la $a0, print_ast
  syscall

  # printf("%i", x);
  li $v0, 1
  move $a0, $s2
  syscall

  # printf(" = 1 (mod ");
  li $v0, 4
  la $a0, print_mod
  syscall

  # printf("%i", m);
  li $v0, 1
  move $a0, $s1
  syscall

  # printf(")\n");
  li $v0, 4
  la $a0, end_mod
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

  # if c == 'Y' goto main;
  addi $t0, $zero, 'Y'
  beq $s3, $t0, main

  # return 0;
  li $v0 10
  syscall
