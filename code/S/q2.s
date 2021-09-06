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

L1:
  addi $v0, $zero, 0
  addi $v1, $zero, 1
  jr $ra

