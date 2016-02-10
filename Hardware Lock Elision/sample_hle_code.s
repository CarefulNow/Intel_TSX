    .file   "test.cpp"
    .section    .text.unlikely,"ax",@progbits
.LCOLDB0:
    .section    .text.startup,"ax",@progbits
.LHOTB0:
    .p2align 4,,15
    .globl  main
    .type   main, @function
main:
.LFB2216:
    .cfi_startproc
    movl    $1, %edx
    .p2align 4,,10
    .p2align 3
.L2:
    movl    lock_var(%rip), %eax
    cmpl    $1, %eax
    je  .L2
    movl    %edx, %eax
    xacquire xchgl  lock_var(%rip), %eax
    cmpl    $1, %eax
    je  .L2
    xrelease movl   $0, lock_var(%rip)
    xorl    %eax, %eax
    ret
    .cfi_endproc
.LFE2216:
    .size   main, .-main
    .section    .text.unlikely
.LCOLDE0:
    .section    .text.startup
.LHOTE0:
    .globl  lock_var
    .bss
    .align 4
    .type   lock_var, @object
    .size   lock_var, 4
lock_var:
    .zero   4
    .ident  "GCC: (Debian 4.9.2-10) 4.9.2"
    .section    .note.GNU-stack,"",@progbits