.data
slope: .word 10
intercept: .word 5
Input: .asciiz "Enter the value of x: "
Output: .asciiz "The value of y is "

.text
.globl main
main:
    # Print input prompt
    li $v0, 4
    la $a0, Input
    syscall

    # Read integer x
    li $v0, 5
    syscall
    move $t2, $v0    # $t2 = x

    # Load slope and intercept
    lw $t0, slope     # $t0 = slope
    lw $t1, intercept # $t1 = intercept

    # Compute y = slope*x + intercept
    mul $t3, $t2, $t0 # $t3 = slope*x
    add $t3, $t3, $t1 # $t3 = slope*x + intercept

    # Print output message
    li $v0, 4
    la $a0, Output
    syscall

    # Print y
    move $a0, $t3
    li $v0, 1
    syscall

    # Exit
    li $v0, 10
    syscall
