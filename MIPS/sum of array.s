.data
arr: .word 10, 20, 30, 40, 50, 0   # MUST have 0 terminator

.text
.globl main
main:
    la $t1, arr        # pointer
    li  $t0, 0         # count = 0

loop:
    lw $t2, 0($t1)     # load element
    beq $t2, $zero, print   # stop at 0

    add $t0, $t0, $t2        # count++
    addi $t1, $t1, 4        # move pointer
    j loop

print:
    li $v0, 1
    move $a0, $t0       # print count
    syscall

exit:
    li $v0, 10
    syscall
