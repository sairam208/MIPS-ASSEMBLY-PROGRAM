.data
buffer:     .space 100            # space for input string
prompt:     .asciiz "Enter a string: "
lower:      .asciiz "LOWERCASE: "
upper:      .asciiz "UPPERCASE: "
newline:    .asciiz "\n"

.text
.globl main
main:
    # -------------------------
    # 1. Read string from user
    # -------------------------
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 8           # syscall 8 = read string
    la $a0, buffer
    li $a1, 100         # max 99 chars + null
    syscall

    # -------------------------
    # 2. Convert to lowercase
    # -------------------------
    la $t0, buffer      # pointer to string

lower_loop:
    lb $t1, 0($t0)      # load character
    beq $t1, $zero, print_lower  # stop at null terminator

    # if 'A' <= char <= 'Z', convert to lowercase
    li $t2, 65          # 'A'
    li $t3, 90          # 'Z'
    blt $t1, $t2, skip_lower
    bgt $t1, $t3, skip_lower
    addi $t1, $t1, 32   # convert to lowercase
    sb $t1, 0($t0)      # store back

skip_lower:
    addi $t0, $t0, 1
    j lower_loop

# -------------------------
# 3. Print lowercase string
# -------------------------
print_lower:
    li $v0,4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, lower
    syscall

    li $v0, 4
    la $a0, buffer
    syscall
    j upper_start

# -------------------------
# 4. Convert to uppercase
# -------------------------
upper_start:
    la $t0, buffer

upper_loop:
    lb $t1, 0($t0)
    beq $t1, $zero, print_upper

    # if 'a' <= char <= 'z', convert to uppercase
    li $t2, 97          # 'a'
    li $t3, 122         # 'z'
    blt $t1, $t2, skip_upper
    bgt $t1, $t3, skip_upper
    addi $t1, $t1, -32  # convert to uppercase
    sb $t1, 0($t0)      # store back

skip_upper:
    addi $t0, $t0, 1
    j upper_loop

# -------------------------
# 5. Print uppercase string
# -------------------------
print_upper:
    li $v0, 4
    la $a0, newline
    syscall
    
    li $v0,4
    la $a0,upper
    syscall
    li $v0, 4
    la $a0, buffer
    syscall
    j exit

# -------------------------
# 6. Exit
# -------------------------
exit:
    li $v0, 10
    syscall
