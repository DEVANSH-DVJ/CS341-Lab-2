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

L1:
  addi $v0, $zero, 1
  jr $ra

