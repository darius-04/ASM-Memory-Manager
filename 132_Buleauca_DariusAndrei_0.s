.section .note.GNU-stack,"",@progbits

.data
    formatcitire: .asciz "%d"
    formatafisare: .asciz "%d: (%d, %d)\n"
    formatvector: .asciz "%d "
    formatget: .asciz "(%d, %d)\n"
    n: .space 4
    task: .space 4
    aux: .space 4
    nrfisiere: .space 4
    desc: .space 4
    size: .space 4
    vector: .space 4096
    vector_size: .long 1024
    ok: .space 4
    okget: .space 4
    pozi: .space 4
    sizeout: .space 4
    value: .space 4
    start: .space 4
    incape: .space 4
.text
afisare: 
    xor %eax, %eax
    loop_mare:
    cmpl $1024, %eax
    jge end_loop

    movl (%edi, %eax, 4), %ebx
    cmp $0, %ebx
    je next_el
    
    movl %eax, start
    movl %ebx, %edx
    secv:
    incl %eax
    movl (%edi, %eax, 4), %ebx
    cmp %ebx, %edx
    je secv

    print:
    decl %eax
    push %eax
    push start
    push %edx
    push $formatafisare
    call printf
    pop %ebx
    pop %edx
    pop %ebx
    pop %eax

    jmp next_el


    next_el:
    incl %eax
    jmp loop_mare

    end_loop:
    ret

.global main
main:
    
    pushl $n
    pushl $formatcitire
    call scanf
    popl %ebx
    popl %ebx

    movl $1023, %ecx
    xor %eax, %eax
    lea vector, %edi

    init_vector:
    movl %eax, (%edi, %ecx, 4)
    decl %ecx

    cmp $0, %ecx
    jge init_vector

    xor %eax, %eax

loop_citire:
    cmpl $0, n
    je etexit

    push $task
    push $formatcitire
    call scanf
    pop %ebx
    pop %ebx

    xor %edx, %edx
    movl task, %edx
    cmpl $1, %edx
    je ADD
    cmpl $2, %edx
    je GET
    cmpl $3, %edx
    je DELETE
    cmpl $4, %edx
    je DEFRAG
   
decr_n:
    decl n
    jmp loop_citire

ADD:
    push $nrfisiere
    push $formatcitire
    call scanf
    pop %ebx
    pop %ebx

citirefisiere:
    cmpl $0, nrfisiere
    je final

    push $desc
    push $formatcitire
    call scanf
    pop %ebx
    pop %ebx

    push $size
    push $formatcitire
    call scanf
    pop %ebx
    pop %ebx

    transfsize:
    movl size, %eax
    movl $8, %ecx
    xor %edx, %edx
    div %ecx
    
    movl %eax, size

    cmpl $0, %edx
    jg nedivizibil
    jmp divizibil
   
    nedivizibil:
    incl size  

    divizibil:
    
    cmpl $1, size
    jle afisare0

    xor %eax, %eax

    for_mare:
    cmpl $1024,  %eax
    jge afisare0

    verifzero:
    movl (%edi, %eax, 4), %ebx
    cmpl $0, %ebx
    jne inc_i
    
    movl $1, ok
    movl %eax, %ecx
    movl size, %edx
    addl %eax, %edx

    for_mic:
    cmpl %edx, %ecx
    jge verif_ok

    movl (%edi, %ecx, 4), %ebx
    cmpl $0, %ebx
    je inc_j

    movl $0, ok
    jmp verif_ok

    inc_j:
    incl %ecx
    jmp for_mic

    verif_ok:
    cmpl $1, ok
    jne inc_i

    movl %eax, %ecx
    movl size, %edx
    addl %eax, %edx
    movl %ecx, pozi
    movl desc, %ebx

    atribuire_desc:
    cmpl %edx, %ecx
    jge print2
    movl $1, incape 
    movl %ebx, (%edi, %ecx, 4)
    incl %ecx
    jmp atribuire_desc
    
    cmpl $1, incape
    jne afisare0

    print2:
    decl %ecx
    push %ecx
    push pozi
    push desc
    push $formatafisare
    call printf
    pop %ebx
    pop %ebx
    pop %ebx
    pop %ecx
    jmp end_add

    afisare0:
    push $0
    push $0
    push desc
    push $formatafisare
    call printf
    addl $16, %esp
    jmp end_add

    inc_i:
    incl %eax
    jmp for_mare

    end_add:
    decl nrfisiere
    jmp citirefisiere

    final:
    jmp decr_n

GET:
    push $desc
    push $formatcitire
    call scanf
    addl $8, %esp

    xor %ecx, %ecx
    movl %ecx, okget
    find_i:
    cmpl $1024, %ecx
    jge end_get

    movl (%edi, %ecx, 4), %edx
    cmpl %edx, desc
    jne nextget
    
    movl $1, okget
    movl %ecx, start
    get_size:
    movl (%edi, %ecx, 4), %edx
    cmpl %edx, desc
    jne end_get

    incl %ecx
    jmp get_size

    nextget:
    incl %ecx
    jmp find_i

    end_get:
    cmpl $1, okget
    je afisnormal
    jmp afis0

    afis0:
    push $0
    push $0
    push $formatget
    call printf
    addl $12, %esp
    jmp decr_n

    afisnormal:
    decl %ecx
    push %ecx
    push start
    push $formatget
    call printf
    addl $8, %esp
    pop %ecx

    jmp decr_n

DELETE:
    push $desc
    push $formatcitire
    call scanf
    addl $8, %esp
 
    xor %ecx, %ecx

    loopdel:
    cmpl $1024, %ecx
    jge end_del

    movl (%edi, %ecx, 4), %edx
    cmpl %edx, desc
    jne nextdel

    del_desc:

    movl (%edi, %ecx, 4), %edx
    cmpl %edx, desc
    jne end_del

    movl $0, (%edi, %ecx, 4)
    incl %ecx
    jmp del_desc

    nextdel:
    incl %ecx
    jmp loopdel

    end_del:
    call afisare
    jmp decr_n

DEFRAG:
    xor %ecx, %ecx
    xor %eax, %eax
    loopdefrag:
    cmpl $1024, %ecx
    jge fill_0

    movl (%edi, %ecx, 4), %edx
    cmpl $0, %edx
    je nextdefrag

    movl (%edi, %ecx, 4), %ebx
    movl %ebx, (%edi, %eax, 4)
    incl %eax

    nextdefrag:
    incl %ecx
    jmp loopdefrag

    fill_0:
    cmpl $1024, %eax
    jge end_defrag

    movl $0, (%edi, %eax, 4)
    incl %eax

    jmp fill_0

    end_defrag:
    call afisare
    jmp decr_n

etexit:
    pushl $0
    call fflush
    popl %eax 

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
 