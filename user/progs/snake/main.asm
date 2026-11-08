
bits 16

section .bss
	alignb 2
	global	_snake
_snake:
	resb	240

section .data
	align 2
	global	_snake_len
_snake_len:
	dw	3

section .bss
	alignb 2
	global	_fruit
_fruit:
	resb	4

section .data
	align 2
	global	_dir_x
_dir_x:
	dw	1

section .data
	align 2
	global	_dir_y
_dir_y:
	dw	0

section .data
	align 2
	global	_score
_score:
	dw	0

section .data
	align 2
	global	_game_over
_game_over:
	dw	0

section .text
	global	_basic_rand
_basic_rand:
	push	bp
	mov	bp, sp

section .data
	align 2
L3:
	dw	12345

section .text
	mov	ax, [L3]
	imul	ax, ax, 31421
	add	ax, 6927
	mov	[L3], ax
	mov	ax, [bp+6]
	sub	ax, [bp+4]
	inc	ax
	mov	cx, ax
	mov	ax, [L3]
	mov	dx, 0
	div	cx
	mov	ax, dx
	add	ax, [bp+4]
L1:
	leave
	ret

section .text
	global	_move_cursor
_move_cursor:
	push	bp
	mov	bp, sp
	mov	ax, 2
	mul	word [bp+4]
	push	ax
	push	5
	call	_syscal
	sub	sp, -4
	push	word [bp+6]
	push	6
	call	_syscal
	sub	sp, -4
L6:
	leave
	ret

section .text
	global	_setup_board
_setup_board:
	push	bp
	mov	bp, sp
	 sub	sp,          2
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6
	push	2
	call	_syscal
	sub	sp, -2
	push	0
	push	7
	push	15
	call	_style
	sub	sp, -6
	mov	ax, 0
	mov	[bp-2], ax
L10:
	mov	ax, [bp-2]
	cmp	ax, 32
	jge	L13
	push	0
	push	word [bp-2]
	call	_move_cursor
	sub	sp, -4

section .rodata
L14:
	db	"  "
	times	1 db 0

section .text
	push	L14
	call	_puts
	sub	sp, -2
	push	21
	push	word [bp-2]
	call	_move_cursor
	sub	sp, -4

section .rodata
L15:
	db	"  "
	times	1 db 0

section .text
	push	L15
	call	_puts
	sub	sp, -2
L11:
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L10
L13:
	mov	ax, 0
	mov	[bp-2], ax
L16:
	mov	ax, [bp-2]
	cmp	ax, 22
	jge	L19
	push	word [bp-2]
	push	0
	call	_move_cursor
	sub	sp, -4

section .rodata
L20:
	db	"  "
	times	1 db 0

section .text
	push	L20
	call	_puts
	sub	sp, -2
	push	word [bp-2]
	push	31
	call	_move_cursor
	sub	sp, -4

section .rodata
L21:
	db	"  "
	times	1 db 0

section .text
	push	L21
	call	_puts
	sub	sp, -2
L17:
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L16
L19:
L8:
	leave
	ret

section .text
	global	_spawn_fruit
_spawn_fruit:
	push	bp
	mov	bp, sp
	mov	ax, _fruit
	push	ax
	push	30
	push	1
	call	_basic_rand
	sub	sp, -4
	pop	bx
	mov	[bx], ax
	mov	ax, _fruit
	add	ax, 2
	push	ax
	push	20
	push	1
	call	_basic_rand
	sub	sp, -4
	pop	bx
	mov	[bx], ax
	mov	ax, _fruit
	add	ax, 2
	mov	bx, ax
	push	word [bx]
	mov	ax, _fruit
	mov	bx, ax
	push	word [bx]
	call	_move_cursor
	sub	sp, -4
	push	0
	push	0
	push	4
	call	_style
	sub	sp, -6
	push	220
	call	_putchar
	sub	sp, -2
	push	0
	push	0
	push	2
	call	_style
	sub	sp, -6
	push	217
	call	_putchar
	sub	sp, -2
L22:
	leave
	ret

section .text
	global	_init_game
_init_game:
	push	bp
	mov	bp, sp
	 sub	sp,          2
	mov	ax, 0
	mov	[_game_over], ax
	mov	ax, 0
	mov	[_score], ax
	mov	ax, 3
	mov	[_snake_len], ax
	mov	ax, _snake
	mov	bx, ax
	mov	ax, 15
	mov	[bx], ax
	mov	ax, _snake
	add	ax, 2
	mov	bx, ax
	mov	ax, 10
	mov	[bx], ax
	mov	ax, _snake
	add	ax, 4
	mov	bx, ax
	mov	ax, 14
	mov	[bx], ax
	mov	ax, _snake
	add	ax, 4
	add	ax, 2
	mov	bx, ax
	mov	ax, 10
	mov	[bx], ax
	mov	ax, _snake
	add	ax, 8
	mov	bx, ax
	mov	ax, 13
	mov	[bx], ax
	mov	ax, _snake
	add	ax, 8
	add	ax, 2
	mov	bx, ax
	mov	ax, 10
	mov	[bx], ax
	mov	ax, 1
	mov	[_dir_x], ax
	mov	ax, 0
	mov	[_dir_y], ax
	call	_setup_board
	call	_spawn_fruit
	mov	ax, 0
	mov	[bp-2], ax
L26:
	mov	ax, [bp-2]
	cmp	ax, [_snake_len]
	jge	L29
	mov	ax, [bp-2]
	imul	ax, ax, 4
	mov	cx, ax
	mov	ax, _snake
	add	ax, cx
	add	ax, 2
	mov	bx, ax
	push	word [bx]
	mov	ax, [bp-2]
	imul	ax, ax, 4
	mov	cx, ax
	mov	ax, _snake
	add	ax, cx
	mov	bx, ax
	push	word [bx]
	call	_move_cursor
	sub	sp, -4
	mov	ax, [bp-2]
	cmp	ax, 0
	jne	L30
	push	0
	push	2
	push	15
	call	_style
	sub	sp, -6
	jmp	L31
L30:
	push	0
	push	10
	push	15
	call	_style
	sub	sp, -6
L31:

section .rodata
L32:
	db	"  "
	times	1 db 0

section .text
	push	L32
	call	_puts
	sub	sp, -2
L27:
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L26
L29:
L24:
	leave
	ret

section .text
	global	_process_input
_process_input:
	push	bp
	mov	bp, sp
	 sub	sp,          2
	call	_kbhit
	test	ax, ax
	je	L35
	call	_getchar
	mov	[bp-2], ax
	mov	ax, [bp-2]
	cmp	ax, 119
	sete	al
	cbw
	test	ax, ax
	je	L39
	mov	ax, [_dir_y]
	cmp	ax, 1
	setne	al
	cbw
L39:
	test	ax, ax
	je	L37
	mov	ax, 0
	mov	[_dir_x], ax
	mov	ax, -1
	mov	[_dir_y], ax
	jmp	L38
L37:
	mov	ax, [bp-2]
	cmp	ax, 115
	sete	al
	cbw
	test	ax, ax
	je	L42
	mov	ax, [_dir_y]
	cmp	ax, -1
	setne	al
	cbw
L42:
	test	ax, ax
	je	L40
	mov	ax, 0
	mov	[_dir_x], ax
	mov	ax, 1
	mov	[_dir_y], ax
	jmp	L41
L40:
	mov	ax, [bp-2]
	cmp	ax, 97
	sete	al
	cbw
	test	ax, ax
	je	L45
	mov	ax, [_dir_x]
	cmp	ax, 1
	setne	al
	cbw
L45:
	test	ax, ax
	je	L43
	mov	ax, -1
	mov	[_dir_x], ax
	mov	ax, 0
	mov	[_dir_y], ax
	jmp	L44
L43:
	mov	ax, [bp-2]
	cmp	ax, 100
	sete	al
	cbw
	test	ax, ax
	je	L48
	mov	ax, [_dir_x]
	cmp	ax, -1
	setne	al
	cbw
L48:
	test	ax, ax
	je	L46
	mov	ax, 1
	mov	[_dir_x], ax
	mov	ax, 0
	mov	[_dir_y], ax
	jmp	L47
L46:
	mov	ax, [bp-2]
	cmp	ax, 113
	jne	L49
	mov	ax, 1
	mov	[_game_over], ax
L49:
L47:
L44:
L41:
L38:
L35:
L33:
	leave
	ret

section .text
	global	_update_game
_update_game:
	push	bp
	mov	bp, sp
	 sub	sp,          6
	lea	ax, [bp-6]
	push	ax
	mov	ax, [_snake_len]
	dec	ax
	imul	ax, ax, 4
	mov	cx, ax
	mov	ax, _snake
	add	ax, cx
	push	ax
	push	4
	call	L53
	sub	sp, -6
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6
	push	word [bp-4]
	push	word [bp-6]
	call	_move_cursor
	sub	sp, -4

section .rodata
L54:
	db	"  "
	times	1 db 0

section .text
	push	L54
	call	_puts
	sub	sp, -2
	mov	ax, [_snake_len]
	dec	ax
	mov	[bp-2], ax
L55:
	mov	ax, [bp-2]
	cmp	ax, 0
	jle	L58
	mov	ax, [bp-2]
	imul	ax, ax, 4
	mov	cx, ax
	mov	ax, _snake
	add	ax, cx
	push	ax
	mov	ax, [bp-2]
	dec	ax
	imul	ax, ax, 4
	mov	cx, ax
	mov	ax, _snake
	add	ax, cx
	push	ax
	push	4
	call	L53
	sub	sp, -6
L56:
	mov	ax, [bp-2]
	dec	word [bp-2]
	jmp	L55
L58:
	mov	ax, _snake
	mov	bx, ax
	mov	ax, [bx]
	add	ax, [_dir_x]
	mov	[bx], ax
	mov	ax, _snake
	add	ax, 2
	mov	bx, ax
	mov	ax, [bx]
	add	ax, [_dir_y]
	mov	[bx], ax
	mov	ax, _snake
	mov	bx, ax
	mov	ax, [bx]
	cmp	ax, 0
	setle	al
	cbw
	test	ax, ax
	jne	L63
	mov	ax, _snake
	mov	bx, ax
	mov	ax, [bx]
	cmp	ax, 30
	setg	al
	cbw
L63:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	jne	L62
	mov	ax, _snake
	add	ax, 2
	mov	bx, ax
	mov	ax, [bx]
	cmp	ax, 0
	setle	al
	cbw
L62:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	jne	L61
	mov	ax, _snake
	add	ax, 2
	mov	bx, ax
	mov	ax, [bx]
	cmp	ax, 20
	setg	al
	cbw
L61:
	test	ax, ax
	je	L59
	mov	ax, 1
	mov	[_game_over], ax
	jmp	L51
L59:
	mov	ax, 1
	mov	[bp-2], ax
L64:
	mov	ax, [bp-2]
	cmp	ax, [_snake_len]
	jge	L67
	mov	ax, _snake
	push	ax
	mov	ax, [bp-2]
	imul	ax, ax, 4
	mov	cx, ax
	mov	ax, _snake
	add	ax, cx
	mov	bx, ax
	mov	cx, [bx]
	pop	bx
	mov	ax, [bx]
	cmp	ax, cx
	sete	al
	cbw
	test	ax, ax
	je	L70
	mov	ax, _snake
	add	ax, 2
	push	ax
	mov	ax, [bp-2]
	imul	ax, ax, 4
	mov	cx, ax
	mov	ax, _snake
	add	ax, cx
	add	ax, 2
	mov	bx, ax
	mov	cx, [bx]
	pop	bx
	mov	ax, [bx]
	cmp	ax, cx
	sete	al
	cbw
L70:
	test	ax, ax
	je	L68
	mov	ax, 1
	mov	[_game_over], ax
	jmp	L51
L68:
L65:
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L64
L67:
	mov	ax, _snake
	push	ax
	mov	ax, _fruit
	mov	bx, ax
	mov	cx, [bx]
	pop	bx
	mov	ax, [bx]
	cmp	ax, cx
	sete	al
	cbw
	test	ax, ax
	je	L73
	mov	ax, _snake
	add	ax, 2
	push	ax
	mov	ax, _fruit
	add	ax, 2
	mov	bx, ax
	mov	cx, [bx]
	pop	bx
	mov	ax, [bx]
	cmp	ax, cx
	sete	al
	cbw
L73:
	test	ax, ax
	je	L71
	mov	ax, [_score]
	add	ax, 10
	mov	[_score], ax
	mov	ax, [_snake_len]
	cmp	ax, 60
	jge	L74
	mov	ax, [_snake_len]
	imul	ax, ax, 4
	mov	cx, ax
	mov	ax, _snake
	add	ax, cx
	push	ax
	lea	ax, [bp-6]
	push	ax
	push	4
	call	L53
	sub	sp, -6
	mov	ax, [_snake_len]
	inc	word [_snake_len]
L74:
	call	_spawn_fruit
L71:
	mov	ax, [_snake_len]
	cmp	ax, 1
	jle	L76
	push	0
	push	10
	push	1
	call	_style
	sub	sp, -6
	mov	ax, _snake
	add	ax, 4
	add	ax, 2
	mov	bx, ax
	push	word [bx]
	mov	ax, _snake
	add	ax, 4
	mov	bx, ax
	push	word [bx]
	call	_move_cursor
	sub	sp, -4

section .rodata
L78:
	db	177,178
	times	1 db 0

section .text
	push	L78
	call	_puts
	sub	sp, -2
L76:
	push	0
	push	2
	push	15
	call	_style
	sub	sp, -6
	mov	ax, _snake
	add	ax, 2
	mov	bx, ax
	push	word [bx]
	mov	ax, _snake
	mov	bx, ax
	push	word [bx]
	call	_move_cursor
	sub	sp, -4
	mov	ax, [_dir_x]
	cmp	ax, 1
	jne	L79

section .rodata
L81:
	db	";)"
	times	1 db 0

section .text
	push	L81
	call	_puts
	sub	sp, -2
L79:
	mov	ax, [_dir_x]
	cmp	ax, -1
	jne	L82

section .rodata
L84:
	db	"(:"
	times	1 db 0

section .text
	push	L84
	call	_puts
	sub	sp, -2
L82:
	mov	ax, [_dir_y]
	cmp	ax, 1
	jne	L85

section .rodata
L87:
	db	"><"
	times	1 db 0

section .text
	push	L87
	call	_puts
	sub	sp, -2
L85:
	mov	ax, [_dir_y]
	cmp	ax, -1
	jne	L88

section .rodata
L90:
	db	"^^"
	times	1 db 0

section .text
	push	L90
	call	_puts
	sub	sp, -2
L88:

section .rodata
L91:
	db	8,8
	times	1 db 0

section .text
	push	L91
	call	_puts
	sub	sp, -2
L51:
	leave
	ret

section .text
	global	_delay
_delay:
	push	bp
	mov	bp, sp
	push	word [bp+4]
	push	20
	call	_syscal
	sub	sp, -4
L92:
	leave
	ret

section .text
	global	_main
_main:
	push	bp
	mov	bp, sp
	 sub	sp,         20

section .rodata
L96:
	db	"Enter Snake Name: "
	times	1 db 0

section .text
	push	L96
	call	_puts
	sub	sp, -2
	lea	ax, [bp-20]
	push	ax
	call	_gets
	sub	sp, -2

section .rodata
L97:
	db	"Get ready, "
	times	1 db 0

section .text
	push	L97
	call	_puts
	sub	sp, -2
	lea	ax, [bp-20]
	push	ax
	call	_puts
	sub	sp, -2

section .rodata
L98:
	db	"!",10
	times	1 db 0

section .text
	push	L98
	call	_puts
	sub	sp, -2
	push	50
	push	20
	call	_syscal
	sub	sp, -4
	call	_init_game
L99:
	mov	ax, [_game_over]
	cmp	ax, 0
	jne	L100
	call	_process_input
	call	_update_game
	push	0
	push	5
	call	_syscal
	sub	sp, -4
	push	21
	push	6
	call	_syscal
	sub	sp, -4

section .rodata
L101:
	db	"Score: ~i |"
	times	1 db 0

section .text
	push	word [_score]
	push	L101
	call	_pformat
	sub	sp, -4
	push	15
	call	_delay
	sub	sp, -2
	jmp	L99
L100:
	call	_getchar
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6
	push	2
	call	_syscal
	sub	sp, -2
	push	10
	push	7
	call	_move_cursor
	sub	sp, -4

section .rodata
L102:
	db	"GAME OVER!"
	times	1 db 0

section .text
	push	L102
	call	_puts
	sub	sp, -2
	push	11
	push	7
	call	_move_cursor
	sub	sp, -4

section .rodata
L103:
	db	"Score: "
	times	1 db 0

section .text
	push	L103
	call	_puts
	sub	sp, -2
	push	word [_score]
	call	_puti
	sub	sp, -2
	push	10
	call	_putchar
	sub	sp, -2
	mov	ax, 0
	jmp	L94
	mov	ax, 0
L94:
	leave
	ret

section .text
L53:
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


	extern	_syscal
	extern	_style
	extern	_puts
	extern	_putchar
	extern	_kbhit
	extern	_getchar
	extern	_gets
	extern	_pformat
	extern	_puti






