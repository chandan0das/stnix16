
bits 16

section .bss
	global	_text_buffer
_text_buffer:
	resb	4097

section .data
	align 2
	global	_text_len
_text_len:
	dw	0

section .data
	align 2
	global	_buffer_pos
_buffer_pos:
	dw	0

section .bss
	global	_current_filename
_current_filename:
	resb	30

section .data
	align 2
	global	_menu_active
_menu_active:
	dw	0

section .text
	global	_move_cursor
_move_cursor:
	push	bp
	mov	bp, sp
	push	word [bp+4]
	push	5
	call	_syscal
	sub	sp, -4
	push	word [bp+6]
	push	6
	call	_syscal
	sub	sp, -4
L1:
	leave
	ret

section .text
	global	_clear_row
_clear_row:
	push	bp
	mov	bp, sp
	 sub	sp,          2
	push	word [bp+4]
	push	0
	call	_move_cursor
	sub	sp, -4
	push	0
	mov	al, [bp+8]
	mov	ah, 0
	push	ax
	mov	al, [bp+6]
	mov	ah, 0
	push	ax
	call	_style
	sub	sp, -6
	mov	ax, 0
	mov	[bp-2], ax
L5:
	mov	ax, [bp-2]
	cmp	ax, 80
	jge	L8
	push	32
	call	_putchar
	sub	sp, -2
L6:
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L5
L8:
L3:
	leave
	ret

section .text
	global	_get_xy_from_pos
_get_xy_from_pos:
	push	bp
	mov	bp, sp
	 sub	sp,          6
	mov	ax, 0
	mov	[bp-2], ax
	mov	ax, 0
	mov	[bp-4], ax
	mov	ax, 0
	mov	[bp-6], ax
L11:
	mov	ax, [bp-6]
	cmp	ax, [bp+4]
	jge	L14
	mov	ax, _text_buffer
	add	ax, [bp-6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 10
	jne	L15
	mov	ax, 0
	mov	[bp-2], ax
	mov	ax, [bp-4]
	inc	word [bp-4]
	jmp	L16
L15:
	mov	ax, [bp-2]
	inc	word [bp-2]
	mov	ax, [bp-2]
	cmp	ax, 80
	jl	L17
	mov	ax, 0
	mov	[bp-2], ax
	mov	ax, [bp-4]
	inc	word [bp-4]
L17:
L16:
L12:
	mov	ax, [bp-6]
	inc	word [bp-6]
	jmp	L11
L14:
	mov	ax, [bp+6]
	mov	bx, ax
	mov	ax, [bp-2]
	mov	[bx], ax
	mov	ax, [bp+8]
	mov	bx, ax
	mov	ax, [bp-4]
	mov	[bx], ax
L9:
	leave
	ret

section .text
	global	_get_pos_from_xy
_get_pos_from_xy:
	push	bp
	mov	bp, sp
	 sub	sp,          6
	mov	ax, 0
	mov	[bp-2], ax
	mov	ax, 0
	mov	[bp-4], ax
	mov	ax, 0
	mov	[bp-6], ax
L21:
	mov	ax, [bp-6]
	cmp	ax, [_text_len]
	jge	L24
	mov	ax, [bp-4]
	cmp	ax, [bp+6]
	sete	al
	cbw
	test	ax, ax
	je	L27
	mov	ax, [bp-2]
	cmp	ax, [bp+4]
	sete	al
	cbw
L27:
	test	ax, ax
	je	L25
	mov	ax, [bp-6]
	jmp	L19
L25:
	mov	ax, _text_buffer
	add	ax, [bp-6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 10
	jne	L28
	mov	ax, [bp-4]
	cmp	ax, [bp+6]
	jne	L30
	mov	ax, [bp-6]
	jmp	L19
L30:
	mov	ax, 0
	mov	[bp-2], ax
	mov	ax, [bp-4]
	inc	word [bp-4]
	jmp	L29
L28:
	mov	ax, [bp-2]
	inc	word [bp-2]
	mov	ax, [bp-2]
	cmp	ax, 80
	jl	L32
	mov	ax, 0
	mov	[bp-2], ax
	mov	ax, [bp-4]
	inc	word [bp-4]
L32:
L29:
L22:
	mov	ax, [bp-6]
	inc	word [bp-6]
	jmp	L21
L24:
	mov	ax, [bp-6]
L19:
	leave
	ret

section .text
	global	_draw_interface
_draw_interface:
	push	bp
	mov	bp, sp
	 sub	sp,         12
	mov	ax, 0
	mov	[bp-2], ax
	mov	ax, 0
	mov	[bp-4], ax
	mov	ax, 0
	mov	[bp-6], ax
	mov	ax, 0
	mov	[bp-8], ax
	mov	ax, 0
	mov	[bp-10], ax
	push	0
	push	1
	push	15
	call	_style
	sub	sp, -6
	push	2
	call	_syscal
	sub	sp, -2
	push	0
	push	0
	call	_move_cursor
	sub	sp, -4
	mov	ax, 0
	mov	[bp-6], ax
L36:
	mov	ax, [bp-6]
	cmp	ax, [_text_len]
	jge	L39
	mov	ax, _text_buffer
	add	ax, [bp-6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 10
	jne	L40
	mov	ax, 0
	mov	[bp-2], ax
	mov	ax, [bp-4]
	inc	word [bp-4]
	mov	ax, [bp-4]
	cmp	ax, 24
	jl	L42
	jmp	L39
L42:
	jmp	L37
L40:
	push	word [bp-4]
	push	word [bp-2]
	call	_move_cursor
	sub	sp, -4
	mov	ax, _text_buffer
	add	ax, [bp-6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	push	ax
	call	_putchar
	sub	sp, -2
	mov	ax, [bp-2]
	inc	word [bp-2]
	mov	ax, [bp-2]
	cmp	ax, 80
	jl	L44
	mov	ax, 0
	mov	[bp-2], ax
	mov	ax, [bp-4]
	inc	word [bp-4]
	mov	ax, [bp-4]
	cmp	ax, 24
	jl	L46
	jmp	L39
L46:
L44:
L37:
	mov	ax, [bp-6]
	inc	word [bp-6]
	jmp	L36
L39:
	push	7
	push	0
	push	24
	call	_clear_row
	sub	sp, -6
	push	24
	push	0
	call	_move_cursor
	sub	sp, -4
	push	0
	push	7
	push	0
	call	_style
	sub	sp, -6

section .rodata
L48:
	db	" File: "
	times	1 db 0

section .text
	push	L48
	call	_puts
	sub	sp, -2
	push	_current_filename
	call	_puts
	sub	sp, -2
	push	24
	push	28
	call	_move_cursor
	sub	sp, -4
	mov	ax, [_menu_active]
	test	ax, ax
	je	L49
	push	0
	push	4
	push	15
	call	_style
	sub	sp, -6

section .rodata
L51:
	db	" MENU "
	times	1 db 0

section .text
	push	L51
	call	_puts
	sub	sp, -2
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6

section .rodata
L52:
	db	" hjkl "
	times	1 db 0

section .text
	push	L52
	call	_puts
	sub	sp, -2
	push	0
	push	7
	push	0
	call	_style
	sub	sp, -6

section .rodata
L53:
	db	" Move "
	times	1 db 0

section .text
	push	L53
	call	_puts
	sub	sp, -2
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6

section .rodata
L54:
	db	" S "
	times	1 db 0

section .text
	push	L54
	call	_puts
	sub	sp, -2
	push	0
	push	7
	push	0
	call	_style
	sub	sp, -6

section .rodata
L55:
	db	" Save "
	times	1 db 0

section .text
	push	L55
	call	_puts
	sub	sp, -2
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6

section .rodata
L56:
	db	" Q "
	times	1 db 0

section .text
	push	L56
	call	_puts
	sub	sp, -2
	push	0
	push	7
	push	0
	call	_style
	sub	sp, -6

section .rodata
L57:
	db	" Quit "
	times	1 db 0

section .text
	push	L57
	call	_puts
	sub	sp, -2
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6

section .rodata
L58:
	db	" ESC "
	times	1 db 0

section .text
	push	L58
	call	_puts
	sub	sp, -2
	push	0
	push	7
	push	0
	call	_style
	sub	sp, -6

section .rodata
L59:
	db	" Type Mode"
	times	1 db 0

section .text
	push	L59
	call	_puts
	sub	sp, -2
	jmp	L50
L49:
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6

section .rodata
L60:
	db	" ESC "
	times	1 db 0

section .text
	push	L60
	call	_puts
	sub	sp, -2
	push	0
	push	7
	push	0
	call	_style
	sub	sp, -6

section .rodata
L61:
	db	" Open Menu (Save, Quit, Navigate)"
	times	1 db 0

section .text
	push	L61
	call	_puts
	sub	sp, -2
L50:
	lea	ax, [bp-10]
	push	ax
	lea	ax, [bp-8]
	push	ax
	push	word [_buffer_pos]
	call	_get_xy_from_pos
	sub	sp, -6
	push	0
	push	1
	push	15
	call	_style
	sub	sp, -6
	push	word [bp-10]
	push	word [bp-8]
	call	_move_cursor
	sub	sp, -4
	mov	ax, _text_buffer
	add	ax, [_buffer_pos]
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-12], ax
	mov	al, [bp-12]
	cbw
	cmp	ax, 10
	jne	L62
	push	32
	call	_putchar
	sub	sp, -2
	jmp	L63
L62:
	mov	al, [bp-12]
	cbw
	push	ax
	call	_putchar
	sub	sp, -2
L63:
	push	8
	call	_putchar
	sub	sp, -2
L34:
	leave
	ret

section .text
	global	_save_file
_save_file:
	push	bp
	mov	bp, sp
	 sub	sp,          2
	push	_current_filename
	push	43
	call	_syscal
	sub	sp, -4
	push	5
	push	_current_filename
	push	45
	call	_syscal
	sub	sp, -6
	mov	[bp-2], ax
	mov	ax, [bp-2]
	cmp	ax, 0
	jge	L66
	push	4
	push	15
	push	24
	call	_clear_row
	sub	sp, -6
	push	24
	push	0
	call	_move_cursor
	sub	sp, -4

section .rodata
L68:
	db	" IO Error: Unable to open filesystem block!"
	times	1 db 0

section .text
	push	L68
	call	_puts
	sub	sp, -2
	push	30
	push	20
	call	_syscal
	sub	sp, -4
	jmp	L64
L66:
	mov	ax, [_text_len]
	cmp	ax, 0
	jle	L69
	push	word [_text_len]
	push	_text_buffer
	push	word [bp-2]
	push	48
	call	_syscal
	sub	sp, -8
L69:
	push	word [bp-2]
	push	46
	call	_syscal
	sub	sp, -4
	push	2
	push	0
	push	24
	call	_clear_row
	sub	sp, -6
	push	24
	push	0
	call	_move_cursor
	sub	sp, -4

section .rodata
L71:
	db	" File saved successfully to storage device."
	times	1 db 0

section .text
	push	L71
	call	_puts
	sub	sp, -2
	push	15
	push	20
	call	_syscal
	sub	sp, -4
L64:
	leave
	ret

section .text
	global	_load_file
_load_file:
	push	bp
	mov	bp, sp
	 sub	sp,          4
	push	2
	push	_current_filename
	push	45
	call	_syscal
	sub	sp, -6
	mov	[bp-2], ax
	mov	ax, [bp-2]
	cmp	ax, 0
	jge	L74
	mov	ax, 0
	mov	[_text_len], ax
	mov	ax, _text_buffer
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
	mov	ax, 0
	mov	[_buffer_pos], ax
	jmp	L72
L74:
	push	word [bp-2]
	push	51
	call	_syscal
	sub	sp, -4
	mov	[bp-4], ax
	mov	ax, [bp-4]
	cmp	ax, 4096
	jle	L76
	mov	ax, 4096
	mov	[bp-4], ax
L76:
	mov	ax, [bp-4]
	cmp	ax, 0
	jle	L78
	push	word [bp-4]
	push	_text_buffer
	push	word [bp-2]
	push	47
	call	_syscal
	sub	sp, -8
	mov	ax, [bp-4]
	mov	[_text_len], ax
	mov	ax, _text_buffer
	add	ax, [_text_len]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
	jmp	L79
L78:
	mov	ax, 0
	mov	[_text_len], ax
L79:
	push	word [bp-2]
	push	46
	call	_syscal
	sub	sp, -4
	mov	ax, 0
	mov	[_buffer_pos], ax
L72:
	leave
	ret

section .text
	global	_strncpy
_strncpy:
	push	bp
	mov	bp, sp
L82:
	mov	ax, [bp+8]
	dec	word [bp+8]
	test	ax, ax
	je	L83
	mov	ax, [bp+6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 0
	jne	L84
	jmp	L83
L84:
	mov	ax, [bp+4]
	inc	word [bp+4]
	push	ax
	mov	ax, [bp+6]
	inc	word [bp+6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
	jmp	L82
L83:
	mov	ax, [bp+4]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
L80:
	leave
	ret

section .text
	global	_main
_main:
	push	bp
	mov	bp, sp
	 sub	sp,         10
	mov	ax, 1
	mov	[bp-2], ax
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6
	push	2
	call	_syscal
	sub	sp, -2
	mov	ax, [bp+4]
	add	ax, 32
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 0
	je	L88
	push	30
	mov	ax, [bp+4]
	add	ax, 32
	push	ax
	push	_current_filename
	call	_strncpy
	sub	sp, -6
	jmp	L89
L88:

section .rodata
L90:
	db	"++EDIT++",10
	times	1 db 0

section .text
	push	L90
	call	_puts
	sub	sp, -2

section .rodata
L91:
	db	"File to open/create: "
	times	1 db 0

section .text
	push	L91
	call	_puts
	sub	sp, -2
	push	_current_filename
	call	_gets
	sub	sp, -2
L89:
	call	_load_file
L92:
	mov	ax, [bp-2]
	test	ax, ax
	je	L93
	call	_draw_interface
	push	8
	call	_syscal
	sub	sp, -2
	mov	[bp-10], ax
	mov	ax, [_menu_active]
	test	ax, ax
	je	L94
	mov	ax, [bp-10]
	cmp	ax, 27
	jne	L96
	mov	ax, 0
	mov	[_menu_active], ax
	jmp	L97
L96:
	mov	ax, [bp-10]
	cmp	ax, 104
	sete	al
	cbw
	test	ax, ax
	jne	L100
	mov	ax, [bp-10]
	cmp	ax, 72
	sete	al
	cbw
L100:
	test	ax, ax
	je	L98
	mov	ax, [_buffer_pos]
	cmp	ax, 0
	jle	L101
	mov	ax, [_buffer_pos]
	dec	word [_buffer_pos]
L101:
	jmp	L99
L98:
	mov	ax, [bp-10]
	cmp	ax, 108
	sete	al
	cbw
	test	ax, ax
	jne	L105
	mov	ax, [bp-10]
	cmp	ax, 76
	sete	al
	cbw
L105:
	test	ax, ax
	je	L103
	mov	ax, [_buffer_pos]
	cmp	ax, [_text_len]
	jge	L106
	mov	ax, [_buffer_pos]
	inc	word [_buffer_pos]
L106:
	jmp	L104
L103:
	mov	ax, [bp-10]
	cmp	ax, 106
	sete	al
	cbw
	test	ax, ax
	jne	L110
	mov	ax, [bp-10]
	cmp	ax, 74
	sete	al
	cbw
L110:
	test	ax, ax
	je	L108
	lea	ax, [bp-8]
	push	ax
	lea	ax, [bp-6]
	push	ax
	push	word [_buffer_pos]
	call	_get_xy_from_pos
	sub	sp, -6
	mov	ax, [bp-8]
	cmp	ax, 23
	jge	L111
	mov	ax, [bp-8]
	inc	ax
	push	ax
	push	word [bp-6]
	call	_get_pos_from_xy
	sub	sp, -4
	mov	[_buffer_pos], ax
L111:
	jmp	L109
L108:
	mov	ax, [bp-10]
	cmp	ax, 107
	sete	al
	cbw
	test	ax, ax
	jne	L115
	mov	ax, [bp-10]
	cmp	ax, 75
	sete	al
	cbw
L115:
	test	ax, ax
	je	L113
	lea	ax, [bp-8]
	push	ax
	lea	ax, [bp-6]
	push	ax
	push	word [_buffer_pos]
	call	_get_xy_from_pos
	sub	sp, -6
	mov	ax, [bp-8]
	cmp	ax, 0
	jle	L116
	mov	ax, [bp-8]
	dec	ax
	push	ax
	push	word [bp-6]
	call	_get_pos_from_xy
	sub	sp, -4
	mov	[_buffer_pos], ax
L116:
	jmp	L114
L113:
	mov	ax, [bp-10]
	cmp	ax, 115
	sete	al
	cbw
	test	ax, ax
	jne	L120
	mov	ax, [bp-10]
	cmp	ax, 83
	sete	al
	cbw
L120:
	test	ax, ax
	je	L118
	call	_save_file
	mov	ax, 0
	mov	[_menu_active], ax
	jmp	L119
L118:
	mov	ax, [bp-10]
	cmp	ax, 113
	sete	al
	cbw
	test	ax, ax
	jne	L123
	mov	ax, [bp-10]
	cmp	ax, 81
	sete	al
	cbw
L123:
	test	ax, ax
	je	L121
	mov	ax, 0
	mov	[bp-2], ax
L121:
L119:
L114:
L109:
L104:
L99:
L97:
	jmp	L95
L94:
	mov	ax, [bp-10]
	cmp	ax, 27
	jne	L124
	mov	ax, 1
	mov	[_menu_active], ax
	jmp	L125
L124:
	mov	ax, [bp-10]
	cmp	ax, 8
	sete	al
	cbw
	test	ax, ax
	jne	L128
	mov	ax, [bp-10]
	cmp	ax, 127
	sete	al
	cbw
L128:
	test	ax, ax
	je	L126
	mov	ax, [_buffer_pos]
	cmp	ax, 0
	jle	L129
	mov	ax, [_buffer_pos]
	dec	ax
	mov	[bp-4], ax
L131:
	mov	ax, [_text_len]
	dec	ax
	mov	cx, ax
	mov	ax, [bp-4]
	cmp	ax, cx
	jge	L134
	mov	ax, _text_buffer
	add	ax, [bp-4]
	push	ax
	mov	ax, [bp-4]
	inc	ax
	mov	cx, ax
	mov	ax, _text_buffer
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
L132:
	mov	ax, [bp-4]
	inc	word [bp-4]
	jmp	L131
L134:
	mov	ax, [_buffer_pos]
	dec	word [_buffer_pos]
	mov	ax, [_text_len]
	dec	word [_text_len]
	mov	ax, _text_buffer
	add	ax, [_text_len]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
L129:
	jmp	L127
L126:
	mov	ax, [bp-10]
	cmp	ax, 13
	sete	al
	cbw
	test	ax, ax
	jne	L137
	mov	ax, [bp-10]
	cmp	ax, 10
	sete	al
	cbw
L137:
	test	ax, ax
	je	L135
	mov	ax, [_text_len]
	cmp	ax, 4095
	jge	L138
	mov	ax, [_text_len]
	mov	[bp-4], ax
L140:
	mov	ax, [bp-4]
	cmp	ax, [_buffer_pos]
	jle	L143
	mov	ax, _text_buffer
	add	ax, [bp-4]
	push	ax
	mov	ax, [bp-4]
	dec	ax
	mov	cx, ax
	mov	ax, _text_buffer
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
L141:
	mov	ax, [bp-4]
	dec	word [bp-4]
	jmp	L140
L143:
	mov	ax, _text_buffer
	add	ax, [_buffer_pos]
	mov	bx, ax
	mov	ax, 10
	mov	[bx], al
	cbw
	mov	ax, [_buffer_pos]
	inc	word [_buffer_pos]
	mov	ax, [_text_len]
	inc	word [_text_len]
	mov	ax, _text_buffer
	add	ax, [_text_len]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
L138:
	jmp	L136
L135:
	mov	ax, [bp-10]
	cmp	ax, 32
	setge	al
	cbw
	test	ax, ax
	je	L146
	mov	ax, [bp-10]
	cmp	ax, 126
	setle	al
	cbw
L146:
	test	ax, ax
	je	L144
	mov	ax, [_text_len]
	cmp	ax, 4095
	jge	L147
	mov	ax, [_text_len]
	mov	[bp-4], ax
L149:
	mov	ax, [bp-4]
	cmp	ax, [_buffer_pos]
	jle	L152
	mov	ax, _text_buffer
	add	ax, [bp-4]
	push	ax
	mov	ax, [bp-4]
	dec	ax
	mov	cx, ax
	mov	ax, _text_buffer
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
L150:
	mov	ax, [bp-4]
	dec	word [bp-4]
	jmp	L149
L152:
	mov	ax, _text_buffer
	add	ax, [_buffer_pos]
	push	ax
	mov	ax, [bp-10]
	cbw
	pop	bx
	mov	[bx], al
	cbw
	mov	ax, [_buffer_pos]
	inc	word [_buffer_pos]
	mov	ax, [_text_len]
	inc	word [_text_len]
	mov	ax, _text_buffer
	add	ax, [_text_len]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
L147:
L144:
L136:
L127:
L125:
L95:
	jmp	L92
L93:
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6
	push	2
	call	_syscal
	sub	sp, -2

section .rodata
L154:
	db	"Editor dropped out safely.",10
	times	1 db 0

section .text
	push	L154
	call	_puts
	sub	sp, -2
	mov	ax, 0
	jmp	L86
	mov	ax, 0
L86:
	leave
	ret


	extern	_syscal
	extern	_style
	extern	_putchar
	extern	_puts
	extern	_gets






