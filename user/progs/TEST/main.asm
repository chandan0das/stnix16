bits 16

section .text
	global	_main
_main:
	push	bp
	mov	bp, sp
	 sub	sp,         32

section .rodata
L3:
	db	"Hello, ~s ",10
	times	1 db 0

section .text
	mov	ax, [bp+4]
	add	ax, 32
	push	ax
	push	L3
	call	_pformat
	sub	sp, -4
	lea	ax, [bp-30]
	push	ax
	call	_puts
	sub	sp, -2

section .rodata
L4:
	db	"The arguments are:  "
	times	1 db 0

section .text
	push	L4
	call	_puts
	sub	sp, -2
	mov	ax, 0
	mov	[bp-32], ax
L5:
	mov	ax, [bp-32]
	cmp	ax, 4
	jge	L8

section .rodata
L9:
	db	"~s ",10
	times	1 db 0

section .text
	mov	ax, [bp-32]
	imul	ax, ax, 32
	mov	cx, ax
	mov	ax, [bp+4]
	add	ax, cx
	push	ax
	push	L9
	call	_pformat
	sub	sp, -4
L6:
	mov	ax, [bp-32]
	inc	word [bp-32]
	jmp	L5
L8:
	mov	ax, 0
	jmp	L1
	mov	ax, 0
L1:
	leave
	ret


	extern	_pformat
	extern	_puts






