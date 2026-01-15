.data
buffer: .space 50       # space to store string (max 49 chars + null)
input_prompt: .asciiz "Enter a string: "
output_prompt: .asciiz "The entered string is: "

.text
.globl main
main:
    # print prompt
    li $v0, 4
    la $a0, input_prompt
    syscall

    # read string
    li $v0, 8           # syscall 8 = read string
    la $a0, buffer      # where to store
    li $a1, 50          # max size
    syscall
    j print_input_string
print_input_string:
    li $v0,4
    la $a0,output_prompt
    syscall
    li $v0,4
    la $a0, buffer
    syscall
    # exit
    li $v0, 10
    syscall
