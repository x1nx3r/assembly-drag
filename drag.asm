section .data
    primes db 100 dup(0) ; an array to store the first 100 prime numbers
    fmt db "Elapsed time: %lld cycles",0 ; format string for printing the elapsed time
section .text
    global _start
    extern printf

_start:
    ; initialize the variables
    mov rdi, 2 ; rdi is the candidate prime number
    mov ecx, 0 ; ecx is the number of prime numbers found
    rdtsc ; start timing

.loop:
    ; check if rdi is a prime number
    mov rbx, 2 ; rbx is the divisor
    mov rax, rdi
    xor edx, edx
    div rbx ; divide rdi by 2
    cmp rax, 1 ; if the quotient is 1, rdi is prime
    je .prime

    ; if rdi is not prime, try the next candidate
    inc rdi
    jmp .loop

.prime:
    ; rdi is prime, check if it is one of the first 100 prime numbers
    mov rbx, 0 ; rbx is the index in the primes array
    cmp ecx, 100 ; have we found 100 primes yet?
    jge .done

.check_next:
    ; check if rdi is a prime we're looking for
    cmp rbx, ecx ; have we checked all the primes found so far?
    je .add_prime

    ; check if rdi is divisible by the prime at the current index
    mov rax, rdi
    mov rdx, 0 ; clear rdx for the upcoming division
    mov rbx, [primes + rbx] ; load the current prime from the array
    div rbx ; divide rdi by the current prime
    cmp rdx, 0 ; if the remainder is zero, rdi is not prime
    je .not_prime

    ; try the next prime in the array
    inc rbx
    jmp .check_next

.add_prime:
    ; rdi is one of the first 100 primes, add it to the array
    mov [primes + rcx*8], rdi ; multiply ecx by 8 to get the byte offset
    inc ecx ; increment the number of primes found
    inc rdi ; try the next candidate
    jmp .loop

.not_prime:
    ; rdi is not prime, try the next candidate
    inc rdi
    jmp .loop

.done:
    ; stop timing and print the elapsed time
    rdtsc
    sub rax, rdx ; calculate the elapsed time in cycles
    mov rdi, fmt ; load the format string
    mov rsi, rax ; load the elapsed time
    xor rax, rax ; rax must be zero for the printf call
    call printf ; print the elapsed time

    ; exit the program
    xor eax, eax
    ret
