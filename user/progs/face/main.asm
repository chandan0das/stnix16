
bits 16

section .text
	global	_show_banner
_show_banner:
	push	bp
	mov	bp, sp
	 sub	sp,        396
	push	0
	push	0
	push	10
	call	_style
	sub	sp, -6

section .data
L3:
	db	32
	db	32
	db	219
	db	219
	db	219
	db	219
	db	219
	db	219
	db	219
	db	187
	db	219
	db	219
	db	219
	db	219
	db	219
	db	219
	db	219
	db	219
	db	187
	db	219
	db	219
	db	219
	db	187
	db	32
	db	32
	db	32
	db	219
	db	219
	db	187
	db	219
	db	219
	db	187
	db	219
	db	219
	db	187
	db	32
	db	32
	db	219
	db	219
	db	187
	db	32
	db	32
	db	32
	db	219
	db	219
	db	219
	db	187
	db	32
	db	219
	db	219
	db	219
	db	219
	db	219
	db	219
	db	187
	db	10
	db	32
	db	32
	db	219
	db	219
	db	201
	db	205
	db	205
	db	205
	db	205
	db	188
	db	200
	db	205
	db	205
	db	219
	db	219
	db	201
	db	205
	db	205
	db	188
	db	219
	db	219
	db	219
	db	219
	db	187
	db	32
	db	32
	db	219
	db	219
	db	186
	db	219
	db	219
	db	186
	db	200
	db	219
	db	219
	db	187
	db	219
	db	219
	db	201
	db	188
	db	32
	db	32
	db	32
	db	32
	db	219
	db	219
	db	186
	db	32
	db	219
	db	219
	db	201
	db	205
	db	205
	db	205
	db	188
	db	10
	db	32
	db	32
	db	219
	db	219
	db	219
	db	219
	db	219
	db	219
	db	219
	db	187
	db	32
	db	32
	db	32
	db	219
	db	219
	db	186
	db	32
	db	32
	db	32
	db	219
	db	219
	db	201
	db	219
	db	219
	db	187
	db	32
	db	219
	db	219
	db	186
	db	219
	db	219
	db	186
	db	32
	db	200
	db	219
	db	219
	db	219
	db	201
	db	188
	db	32
	db	32
	db	32
	db	32
	db	32
	db	219
	db	219
	db	186
	db	32
	db	219
	db	219
	db	219
	db	219
	db	219
	db	219
	db	187
	db	10
	db	32
	db	32
	db	200
	db	205
	db	205
	db	205
	db	205
	db	219
	db	219
	db	186
	db	32
	db	32
	db	32
	db	219
	db	219
	db	186
	db	32
	db	32
	db	32
	db	219
	db	219
	db	186
	db	200
	db	219
	db	219
	db	187
	db	219
	db	219
	db	186
	db	219
	db	219
	db	186
	db	32
	db	219
	db	219
	db	201
	db	219
	db	219
	db	187
	db	32
	db	32
	db	32
	db	32
	db	32
	db	219
	db	219
	db	186
	db	32
	db	219
	db	219
	db	201
	db	205
	db	219
	db	219
	db	186
	db	10
	db	32
	db	32
	db	219
	db	219
	db	219
	db	219
	db	219
	db	219
	db	219
	db	186
	db	32
	db	32
	db	32
	db	219
	db	219
	db	186
	db	32
	db	32
	db	32
	db	219
	db	219
	db	186
	db	32
	db	200
	db	219
	db	219
	db	219
	db	219
	db	186
	db	219
	db	219
	db	186
	db	219
	db	219
	db	201
	db	188
	db	32
	db	219
	db	219
	db	187
	db	32
	db	32
	db	32
	db	32
	db	219
	db	219
	db	186
	db	32
	db	219
	db	219
	db	219
	db	219
	db	219
	db	219
	db	186
	db	10
	db	32
	db	32
	db	200
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	188
	db	32
	db	32
	db	32
	db	200
	db	205
	db	188
	db	32
	db	32
	db	32
	db	200
	db	205
	db	188
	db	32
	db	32
	db	200
	db	205
	db	205
	db	205
	db	188
	db	200
	db	205
	db	188
	db	200
	db	205
	db	188
	db	32
	db	32
	db	200
	db	205
	db	188
	db	32
	db	32
	db	32
	db	32
	db	200
	db	205
	db	188
	db	32
	db	200
	db	205
	db	205
	db	205
	db	205
	db	205
	db	188
	db	10
	db	0

section .text
	lea	ax, [bp-338]
	push	ax
	push	L3
	push	337
	call	L4
	sub	sp, -6

section .rodata
L5:
	db	10,"~s",10
	times	1 db 0

section .text
	lea	ax, [bp-338]
	push	ax
	push	L5
	call	_pformat
	sub	sp, -4
	push	0
	push	0
	push	11
	call	_style
	sub	sp, -6

section .rodata
L6:
	db	" STNIX-16  16-BIT OS  ~c",10
	times	1 db 0

section .text
	push	2
	push	L6
	call	_pformat
	sub	sp, -4

section .rodata
L7:
	db	" Copyright (c) 2026, Chandan Das",10
	db	" All rights reserved.",10,10," "
	times	1 db 0

section .text
	push	L7
	call	_pformat
	sub	sp, -2
	mov	ax, 0
	mov	[bp-340], ax
L8:
	mov	ax, [bp-340]
	cmp	ax, 16
	jge	L11
	push	0
	push	0
	push	word [bp-340]
	call	_style
	sub	sp, -6
	push	219
	call	_putchar
	sub	sp, -2
	push	219
	call	_putchar
	sub	sp, -2
L9:
	mov	ax, [bp-340]
	inc	word [bp-340]
	jmp	L8
L11:
	push	0
	push	0
	push	6
	call	_style
	sub	sp, -6

section .rodata
L12:
	db	"           ~c 0xDEADC0DE",10
	times	1 db 0

section .text
	push	16
	push	L12
	call	_pformat
	sub	sp, -4
	push	0
	push	0
	push	10
	call	_style
	sub	sp, -6

section .data
L13:
	db	32
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	10
	db	0

section .text
	lea	ax, [bp-396]
	push	ax
	push	L13
	push	58
	call	L4
	sub	sp, -6
	lea	ax, [bp-396]
	push	ax
	call	_puts
	sub	sp, -2
L1:
	leave
	ret

section .text
	global	_main
_main:
	push	bp
	mov	bp, sp
	call	_show_banner
	mov	ax, 0
	jmp	L14
	mov	ax, 0
L14:
	leave
	ret

section .text
L4:
	push	bp
	mov	bp, sp
	mov	di, [bp+8]
	mov	si, [bp+6]
	mov	cx, [bp+4]
	cld
	rep	movsb
	mov	ax, [bp+8]
	leave
	ret


	extern	_style
	extern	_pformat
	extern	_putchar
	extern	_puts






