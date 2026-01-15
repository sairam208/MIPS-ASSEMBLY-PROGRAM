.data
buffer: .asciiz "Hello, world!"   # string to print

.text
.globl main
main:
    la $t0, buffer       # pointer to string

loop:
    lb $t1, 0($t0)      # load 1 byte (character)
    beq $t1, $zero, exit # stop at null terminator

    li $v0, 11           # syscall 11 = print character
    move $a0, $t1
    syscall

    addi $t0, $t0, 1     # move to next character
    j loop

exit:
    li $v0, 10           # exit
    syscall
