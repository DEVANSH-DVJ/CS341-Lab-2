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

fact_return:
  addi $sp, $sp, 8
  jr $ra
