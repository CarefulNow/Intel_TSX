	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp0:
	.cfi_def_cfa_offset 16
Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp2:
	.cfi_def_cfa_register %rbp
	movl	$8, %ecx
	movl	$1, %eax
	jmp	LBB0_2
LBB0_1:                                 ## %.loopexit
                                        ##   in Loop: Header=BB0_2 Depth=1
	leal	-1(%rcx), %edx
	testl	%ecx, %ecx
	cmovel	%ecx, %edx
	movl	%edx, %ecx
	.align	4, 0x90
LBB0_2:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB0_15 Depth 2
	cmpl	$0, _lock_var(%rip)
	jne	LBB0_2
## BB#3:                                ##   in Loop: Header=BB0_2 Depth=1
	cmpl	$1, %eax
	jne	LBB0_4
## BB#7:                                ##   in Loop: Header=BB0_2 Depth=1
	xbegin	LBB0_9
## BB#8:                                ##   in Loop: Header=BB0_2 Depth=1
	movl	$-1, %eax
LBB0_9:                                 ##   in Loop: Header=BB0_2 Depth=1
	cmpl	$-1, %eax
	je	LBB0_10
## BB#14:                               ##   in Loop: Header=BB0_2 Depth=1
	testl	%ecx, %ecx
	setne	%al
	movzbl	%al, %eax
	.align	4, 0x90
LBB0_15:                                ##   Parent Loop BB0_2 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpl	$0, _lock_var(%rip)
	jne	LBB0_15
	jmp	LBB0_1
LBB0_4:
	movl	$1, %ecx
	.align	4, 0x90
LBB0_5:                                 ## %.preheader
                                        ## =>This Inner Loop Header: Depth=1
	movl	_lock_var(%rip), %eax
	cmpl	$1, %eax
	je	LBB0_5
## BB#6:                                ##   in Loop: Header=BB0_5 Depth=1
	xorl	%eax, %eax
	lock
	cmpxchgl	%ecx, _lock_var(%rip)
	cmpl	$1, %eax
	je	LBB0_5
LBB0_10:                                ## %.thread
	xtest
	je	LBB0_12
## BB#11:
	cmpl	$0, _lock_var(%rip)
	jne	LBB0_18
LBB0_12:
	xtest
	je	LBB0_16
## BB#13:
	xend
	jmp	LBB0_17
LBB0_16:
	movl	$0, _lock_var(%rip)
LBB0_17:
	xorl	%eax, %eax
	popq	%rbp
	retq
LBB0_18:
	xabort	$1
	.cfi_endproc

	.globl	_lock_var               ## @lock_var
.zerofill __DATA,__common,_lock_var,4,2

.subsections_via_symbols
