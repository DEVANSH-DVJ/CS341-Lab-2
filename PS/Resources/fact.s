.data

prompt:
  .asciiz "Input an integer x: "

result:
  .asciiz "! = "

newline:
  .asciiz "\n"

.text

factorial:
  # adjust stack pointer to store return address and argument
  addi $sp, $sp, -8
  sw $ra, 4($sp)
  sw $a0, 0($sp)

  bne $a0, 0, else # if x != 1 goto else;

  # base case
  addi $v0, $zero, 1 # return 1
  j fact_return

else:
  addi $a0, $a0, -1
  jal factorial # factorial(x-1)

  # Reload stack variables
  lw $ra, 4($sp)
  lw $a0, 0($sp)

  # when we get here, we already have v0 = (x-1)!
  mul $v0, $a0, $v0 # return x * (x-1)!
  j fact_return

fact_return:
  addi $sp, $sp, 8
  jr $ra

main:
  # printf("Input an integer x: ");
  li $v0, 4
  la $a0, prompt
  syscall

  # scanf("%i", x);
  li $v0, 5
  syscall
  move $t0, $v0

  # res = factorial(x);
  move $a0, $t0
  jal factorial
  move $t1, $v0

  # printf("%i", x);
  li $v0, 1
  move $a0, $t0
  syscall

  # printf("x! = ");
  li $v0, 4
  la $a0, result
  syscall

  # printf("%i", res);
  li $v0, 1
  move $a0, $t1
  syscall

  # print("\n");
  li $v0, 4
  la $a0, newline
  syscall
