.data
arr: .word 10, 30, 20, 50, 40
newline: .asciiz "\n"

.text
.globl main
main:

    la $s0, arr        # base address
    li $s1, 5          # number of elements

outer_loop:
    addi $s1, $s1, -1  # n = n - 1
    blez $s1, start_print     # if n <= 0 → print

    la $t0, arr        # pointer reset
    move $t2, $s1      # inner count

inner_loop:
    lw $t3, 0($t0)     # a[i]
    lw $t4, 4($t0)     # a[i+1]

    ble $t3, $t4, noswap   # if a[i] <= a[i+1], no swap

    # swap
    sw $t4, 0($t0)
    sw $t3, 4($t0)

noswap:
    addi $t0, $t0, 4       # next element
    addi $t2, $t2, -1
    bgtz $t2, inner_loop

    j outer_loop

start_print:
    la $t0, arr        # base address
    li $t1, 5          # number of elements

print_loop: # while($t1!=0)
    beq $t1, $zero, exit_print

    lw $t2, 0($t0)

    li $v0, 1          # print integer
    move $a0, $t2
    syscall

    li $v0, 4          # print newline
    la $a0, newline
    syscall

    addi $t0, $t0, 4
    addi $t1, $t1, -1
    j print_loop


exit_print:
    li $v0, 10
    syscall
