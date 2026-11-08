
bits 16

section .bss
	alignb 2
	global	_label_table
_label_table:
	resb	1152

section .data
	align 2
	global	_label_count
_label_count:
	dw	0

section .bss
	global	_line_buffer
_line_buffer:
	resb	128

section .bss
	global	_output_binary
_output_binary:
	resb	1024

section .data
	align 2
	global	_binary_size
_binary_size:
	dw	0

section .text
	global	_str_eq
_str_eq:
	push	bp
	mov	bp, sp
	 sub	sp,          2
	mov	ax, 0
	mov	[bp-2], ax
L3:
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L5
	mov	ax, [bp+6]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
L5:
	test	ax, ax
	je	L4
	mov	ax, [bp+4]
	add	ax, [bp-2]
	push	ax
	mov	ax, [bp+6]
	add	ax, [bp-2]
	mov	bx, ax
	movsx	cx, byte [bx]
	pop	bx
	mov	al, [bx]
	cbw
	cmp	ax, cx
	je	L6
	mov	ax, 0
	jmp	L1
L6:
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L3
L4:
	mov	ax, [bp+4]
	add	ax, [bp-2]
	push	ax
	mov	ax, [bp+6]
	add	ax, [bp-2]
	mov	bx, ax
	movsx	cx, byte [bx]
	pop	bx
	mov	al, [bx]
	cbw
	cmp	ax, cx
	sete	al
	cbw
L1:
	leave
	ret

section .text
	global	_str_copy
_str_copy:
	push	bp
	mov	bp, sp
	 sub	sp,          2
	mov	ax, 0
	mov	[bp-2], ax
L10:
	mov	ax, [bp+6]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L12
	mov	ax, [bp+8]
	dec	ax
	mov	cx, ax
	mov	ax, [bp-2]
	cmp	ax, cx
	setl	al
	cbw
L12:
	test	ax, ax
	je	L11
	mov	ax, [bp+4]
	add	ax, [bp-2]
	push	ax
	mov	ax, [bp+6]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L10
L11:
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
L8:
	leave
	ret

section .text
	global	_clean_token
_clean_token:
	push	bp
	mov	bp, sp
	 sub	sp,          6
	mov	ax, 0
	mov	[bp-2], ax
	mov	ax, 0
	mov	[bp-4], ax
L15:
	mov	ax, [bp+6]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	je	L16
	mov	ax, [bp+6]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-6], ax
	mov	al, [bp-6]
	cbw
	cmp	ax, 32
	setne	al
	cbw
	test	ax, ax
	je	L22
	mov	al, [bp-6]
	cbw
	cmp	ax, 9
	setne	al
	cbw
L22:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L21
	mov	al, [bp-6]
	cbw
	cmp	ax, 10
	setne	al
	cbw
L21:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L20
	mov	al, [bp-6]
	cbw
	cmp	ax, 13
	setne	al
	cbw
L20:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L19
	mov	al, [bp-6]
	cbw
	cmp	ax, 44
	setne	al
	cbw
L19:
	test	ax, ax
	je	L17
	mov	ax, [bp-4]
	inc	word [bp-4]
	mov	cx, ax
	mov	ax, [bp+4]
	add	ax, cx
	mov	bx, ax
	mov	al, [bp-6]
	cbw
	mov	[bx], al
	cbw
L17:
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L15
L16:
	mov	ax, [bp+4]
	add	ax, [bp-4]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
L13:
	leave
	ret

section .text
	global	_find_label
_find_label:
	push	bp
	mov	bp, sp
	 sub	sp,          2
	mov	ax, 0
	mov	[bp-2], ax
L25:
	mov	ax, [bp-2]
	cmp	ax, [_label_count]
	jge	L28
	push	word [bp+4]
	mov	ax, [bp-2]
	imul	ax, ax, 18
	mov	cx, ax
	mov	ax, _label_table
	add	ax, cx
	push	ax
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L29
	mov	ax, [bp-2]
	imul	ax, ax, 18
	mov	cx, ax
	mov	ax, _label_table
	add	ax, cx
	add	ax, 16
	mov	bx, ax
	mov	ax, [bx]
	jmp	L23
L29:
L26:
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L25
L28:
	mov	ax, -1
L23:
	leave
	ret

section .text
	global	_add_label
_add_label:
	push	bp
	mov	bp, sp
	mov	ax, [_label_count]
	cmp	ax, 64
	jl	L33
	jmp	L31
L33:
	push	16
	push	word [bp+4]
	mov	ax, [_label_count]
	imul	ax, ax, 18
	mov	cx, ax
	mov	ax, _label_table
	add	ax, cx
	push	ax
	call	_str_copy
	sub	sp, -6
	mov	ax, [_label_count]
	imul	ax, ax, 18
	mov	cx, ax
	mov	ax, _label_table
	add	ax, cx
	add	ax, 16
	mov	bx, ax
	mov	ax, [bp+6]
	mov	[bx], ax
	mov	ax, [_label_count]
	inc	word [_label_count]
L31:
	leave
	ret

section .text
	global	_is_bp_mem
_is_bp_mem:
	push	bp
	mov	bp, sp
	 sub	sp,         14
	mov	ax, 0
	mov	[bp-2], ax
	mov	ax, [bp+4]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 91
	je	L37
	mov	ax, 0
	jmp	L35
L37:
	mov	ax, 1
	mov	[bp-2], ax
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 98
	sete	al
	cbw
	test	ax, ax
	je	L41
	mov	ax, [bp-2]
	inc	ax
	mov	cx, ax
	mov	ax, [bp+4]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 112
	sete	al
	cbw
L41:
	cmp	ax, 0
	jne	L39
	mov	ax, 0
	jmp	L35
L39:
	mov	ax, [bp-2]
	add	ax, 2
	mov	[bp-2], ax
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 93
	jne	L42
	mov	ax, [bp+6]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], ax
	mov	ax, 1
	jmp	L35
L42:
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 43
	setne	al
	cbw
	test	ax, ax
	je	L46
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 45
	setne	al
	cbw
L46:
	test	ax, ax
	je	L44
	mov	ax, 0
	jmp	L35
L44:
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 45
	sete	al
	cbw
	test	ax, ax
	jne	L47
	mov	ax, 1
	jmp	L48
L47:
	mov	ax, -1
L48:
	mov	[bp-4], ax
	mov	ax, 0
	mov	[bp-14], ax
	mov	ax, [bp-2]
	inc	word [bp-2]
L49:
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L51
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 93
	setne	al
	cbw
L51:
	test	ax, ax
	je	L50
	mov	ax, [bp-14]
	cmp	ax, 7
	jge	L52
	mov	ax, [bp-14]
	inc	word [bp-14]
	mov	cx, ax
	lea	ax, [bp-12]
	add	ax, cx
	push	ax
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
L52:
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L49
L50:
	lea	ax, [bp-12]
	add	ax, [bp-14]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
	mov	ax, [bp+6]
	push	ax
	lea	ax, [bp-12]
	push	ax
	push	11
	call	_syscal
	sub	sp, -4
	mov	cx, ax
	mov	ax, [bp-4]
	mul	cx
	pop	bx
	mov	[bx], ax
	mov	ax, 1
	jmp	L35
L35:
	leave
	ret

section .text
	global	_reg_id
_reg_id:
	push	bp
	mov	bp, sp

section .rodata
L58:
	db	"ax"
	times	1 db 0

section .text
	push	L58
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L56
	mov	ax, 0
	jmp	L54
L56:

section .rodata
L61:
	db	"cx"
	times	1 db 0

section .text
	push	L61
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L59
	mov	ax, 1
	jmp	L54
L59:

section .rodata
L64:
	db	"dx"
	times	1 db 0

section .text
	push	L64
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L62
	mov	ax, 2
	jmp	L54
L62:

section .rodata
L67:
	db	"bx"
	times	1 db 0

section .text
	push	L67
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L65
	mov	ax, 3
	jmp	L54
L65:

section .rodata
L70:
	db	"sp"
	times	1 db 0

section .text
	push	L70
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L68
	mov	ax, 4
	jmp	L54
L68:

section .rodata
L73:
	db	"bp"
	times	1 db 0

section .text
	push	L73
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L71
	mov	ax, 5
	jmp	L54
L71:

section .rodata
L76:
	db	"si"
	times	1 db 0

section .text
	push	L76
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L74
	mov	ax, 6
	jmp	L54
L74:

section .rodata
L79:
	db	"di"
	times	1 db 0

section .text
	push	L79
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L77
	mov	ax, 7
	jmp	L54
L77:
	mov	ax, -1
L54:
	leave
	ret

section .text
	global	_emit1
_emit1:
	push	bp
	mov	bp, sp
	mov	ax, [bp+4]
	test	ax, ax
	je	L82
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	al, [bp+6]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
L82:
	mov	ax, [_binary_size]
	inc	word [_binary_size]
L80:
	leave
	ret

section .text
	global	_emit2
_emit2:
	push	bp
	mov	bp, sp
	mov	ax, [bp+4]
	test	ax, ax
	je	L86
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	al, [bp+6]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	al, [bp+8]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
L86:
	mov	ax, [_binary_size]
	add	ax, 2
	mov	[_binary_size], ax
L84:
	leave
	ret

section .text
	global	_emit3
_emit3:
	push	bp
	mov	bp, sp
	mov	ax, [bp+4]
	test	ax, ax
	je	L90
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	al, [bp+6]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	al, [bp+8]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 2
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	al, [bp+10]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
L90:
	mov	ax, [_binary_size]
	add	ax, 3
	mov	[_binary_size], ax
L88:
	leave
	ret

section .text
	global	_emit4
_emit4:
	push	bp
	mov	bp, sp
	mov	ax, [bp+4]
	test	ax, ax
	je	L94
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	al, [bp+6]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	al, [bp+8]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 2
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	al, [bp+10]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 3
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	al, [bp+12]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
L94:
	mov	ax, [_binary_size]
	add	ax, 4
	mov	[_binary_size], ax
L92:
	leave
	ret

section .text
	global	_resolve_imm
_resolve_imm:
	push	bp
	mov	bp, sp
	 sub	sp,          2
	push	word [bp+4]
	call	_find_label
	sub	sp, -2
	mov	[bp-2], ax
	mov	ax, [bp-2]
	cmp	ax, -1
	jne	L98
	push	word [bp+4]
	push	11
	call	_syscal
	sub	sp, -4
	mov	[bp-2], ax
L98:
	mov	ax, [bp-2]
L96:
	leave
	ret

section .text
	global	_emit_db
_emit_db:
	push	bp
	mov	bp, sp
	 sub	sp,         14
	mov	ax, 0
	mov	[bp-2], ax
L102:
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	sete	al
	cbw
	test	ax, ax
	jne	L104
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 9
	sete	al
	cbw
L104:
	test	ax, ax
	je	L103
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L102
L103:
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 34
	jne	L105
	mov	ax, [bp-2]
	inc	word [bp-2]
L107:
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 34
	setne	al
	cbw
	test	ax, ax
	je	L109
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
L109:
	test	ax, ax
	je	L108
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	and	ax, 255
	push	ax
	push	word [bp+6]
	call	_emit1
	sub	sp, -4
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L107
L108:
	jmp	L106
L105:
	mov	ax, 0
	mov	[bp-12], ax
L111:
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	je	L112
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-14], ax
	mov	al, [bp-14]
	cbw
	cmp	ax, 32
	setne	al
	cbw
	test	ax, ax
	je	L118
	mov	al, [bp-14]
	cbw
	cmp	ax, 9
	setne	al
	cbw
L118:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L117
	mov	al, [bp-14]
	cbw
	cmp	ax, 44
	setne	al
	cbw
L117:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L116
	mov	al, [bp-14]
	cbw
	cmp	ax, 10
	setne	al
	cbw
L116:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L115
	mov	al, [bp-14]
	cbw
	cmp	ax, 59
	setne	al
	cbw
L115:
	test	ax, ax
	je	L113
	mov	ax, [bp-12]
	cmp	ax, 7
	jge	L119
	mov	ax, [bp-12]
	inc	word [bp-12]
	mov	cx, ax
	lea	ax, [bp-10]
	add	ax, cx
	mov	bx, ax
	mov	al, [bp-14]
	cbw
	mov	[bx], al
	cbw
L119:
	jmp	L114
L113:
	mov	ax, [bp-12]
	cmp	ax, 0
	jle	L121
	lea	ax, [bp-10]
	add	ax, [bp-12]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
	lea	ax, [bp-10]
	push	ax
	push	11
	call	_syscal
	sub	sp, -4
	and	ax, 255
	push	ax
	push	word [bp+6]
	call	_emit1
	sub	sp, -4
	mov	ax, 0
	mov	[bp-12], ax
L121:
L114:
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L111
L112:
	mov	ax, [bp-12]
	cmp	ax, 0
	jle	L124
	lea	ax, [bp-10]
	add	ax, [bp-12]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
	lea	ax, [bp-10]
	push	ax
	push	11
	call	_syscal
	sub	sp, -4
	and	ax, 255
	push	ax
	push	word [bp+6]
	call	_emit1
	sub	sp, -4
L124:
L106:
L100:
	leave
	ret

section .text
	global	_assemble_line
_assemble_line:
	push	bp
	mov	bp, sp
	 sub	sp,         72
	push	word [bp+6]
	lea	ax, [bp-32]
	push	ax
	call	_clean_token
	sub	sp, -4
	push	word [bp+8]
	lea	ax, [bp-64]
	push	ax
	call	_clean_token
	sub	sp, -4
	lea	ax, [bp-32]
	push	ax
	call	_reg_id
	sub	sp, -2
	mov	[bp-66], ax
	lea	ax, [bp-64]
	push	ax
	call	_reg_id
	sub	sp, -2
	mov	[bp-68], ax

section .rodata
L131:
	db	"db"
	times	1 db 0

section .text
	push	L131
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L129
	push	word [bp+10]
	push	word [bp+6]
	call	_emit_db
	sub	sp, -4
	jmp	L127
L129:

section .rodata
L134:
	db	"nop"
	times	1 db 0

section .text
	push	L134
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L132
	push	144
	push	word [bp+10]
	call	_emit1
	sub	sp, -4
	jmp	L127
L132:

section .rodata
L137:
	db	"ret"
	times	1 db 0

section .text
	push	L137
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L135
	push	195
	push	word [bp+10]
	call	_emit1
	sub	sp, -4
	jmp	L127
L135:

section .rodata
L140:
	db	"int"
	times	1 db 0

section .text
	push	L140
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L138
	lea	ax, [bp-32]
	push	ax
	push	11
	call	_syscal
	sub	sp, -4
	and	ax, 255
	push	ax
	push	205
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L127
L138:

section .rodata
L144:
	db	"push"
	times	1 db 0

section .text
	push	L144
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L142
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L145
	mov	ax, 80
	add	ax, [bp-66]
	push	ax
	push	word [bp+10]
	call	_emit1
	sub	sp, -4
	jmp	L127
L145:
	lea	ax, [bp-32]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, [bp-70]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	push	104
	push	word [bp+10]
	call	_emit3
	sub	sp, -8
	jmp	L127
L142:

section .rodata
L151:
	db	"pop"
	times	1 db 0

section .text
	push	L151
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L149
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L152
	mov	ax, 88
	add	ax, [bp-66]
	push	ax
	push	word [bp+10]
	call	_emit1
	sub	sp, -4
	jmp	L127
L152:
	jmp	L127
L149:

section .rodata
L156:
	db	"mov"
	times	1 db 0

section .text
	push	L156
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L154
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
	test	ax, ax
	je	L159
	lea	ax, [bp-70]
	push	ax
	lea	ax, [bp-64]
	push	ax
	call	_is_bp_mem
	sub	sp, -4
	test	ax, ax
	setne	al
	cbw
L159:
	test	ax, ax
	je	L157
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, [bp-66]
	shl	ax, 3
	mov	cx, ax
	mov	ax, 70
	add	ax, cx
	push	ax
	push	139
	push	word [bp+10]
	call	_emit3
	sub	sp, -8
	jmp	L127
L157:
	lea	ax, [bp-70]
	push	ax
	lea	ax, [bp-32]
	push	ax
	call	_is_bp_mem
	sub	sp, -4
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L163
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L163:
	test	ax, ax
	je	L161
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, [bp-68]
	shl	ax, 3
	mov	cx, ax
	mov	ax, 70
	add	ax, cx
	push	ax
	push	137
	push	word [bp+10]
	call	_emit3
	sub	sp, -8
	jmp	L127
L161:
	lea	ax, [bp-70]
	push	ax
	lea	ax, [bp-32]
	push	ax
	call	_is_bp_mem
	sub	sp, -4
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L167
	mov	ax, [bp-68]
	cmp	ax, -1
	sete	al
	cbw
L167:
	test	ax, ax
	je	L165
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-72], ax
	mov	ax, [bp+10]
	test	ax, ax
	je	L168
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 199
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	ax, 70
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 2
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 3
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 4
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
L168:
	mov	ax, [_binary_size]
	add	ax, 5
	mov	[_binary_size], ax
	jmp	L127
L165:
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
	test	ax, ax
	je	L175
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L175:
	test	ax, ax
	je	L173
	mov	ax, [bp-68]
	shl	ax, 3
	mov	cx, ax
	mov	ax, 192
	add	ax, cx
	add	ax, [bp-66]
	push	ax
	push	137
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L174
L173:
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L176
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-72], ax
	mov	ax, [bp-72]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, [bp-72]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, 184
	add	ax, [bp-66]
	push	ax
	push	word [bp+10]
	call	_emit3
	sub	sp, -8
L176:
L174:
	jmp	L127
L154:

section .rodata
L182:
	db	"add"
	times	1 db 0

section .text
	push	L182
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L180
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
	test	ax, ax
	je	L185
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L185:
	test	ax, ax
	je	L183
	mov	ax, [bp-68]
	shl	ax, 3
	mov	cx, ax
	mov	ax, 192
	add	ax, cx
	add	ax, [bp-66]
	push	ax
	push	1
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L184
L183:
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L186
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, [bp-70]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, 192
	add	ax, [bp-66]
	push	ax
	push	129
	push	word [bp+10]
	call	_emit4
	sub	sp, -10
L186:
L184:
	jmp	L127
L180:

section .rodata
L192:
	db	"sub"
	times	1 db 0

section .text
	push	L192
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L190
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
	test	ax, ax
	je	L195
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L195:
	test	ax, ax
	je	L193
	mov	ax, [bp-68]
	shl	ax, 3
	mov	cx, ax
	mov	ax, 192
	add	ax, cx
	add	ax, [bp-66]
	push	ax
	push	41
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L194
L193:
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L196
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, [bp-70]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, 232
	add	ax, [bp-66]
	push	ax
	push	129
	push	word [bp+10]
	call	_emit4
	sub	sp, -10
L196:
L194:
	jmp	L127
L190:

section .rodata
L202:
	db	"mul"
	times	1 db 0

section .text
	push	L202
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L200
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L203
	mov	ax, 224
	add	ax, [bp-66]
	push	ax
	push	247
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
L203:
	jmp	L127
L200:

section .rodata
L207:
	db	"div"
	times	1 db 0

section .text
	push	L207
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L205
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L208
	mov	ax, 240
	add	ax, [bp-66]
	push	ax
	push	247
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
L208:
	jmp	L127
L205:

section .rodata
L212:
	db	"inc"
	times	1 db 0

section .text
	push	L212
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L210
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L213
	mov	ax, 64
	add	ax, [bp-66]
	push	ax
	push	word [bp+10]
	call	_emit1
	sub	sp, -4
	jmp	L127
L213:
	jmp	L127
L210:

section .rodata
L217:
	db	"dec"
	times	1 db 0

section .text
	push	L217
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L215
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L218
	mov	ax, 72
	add	ax, [bp-66]
	push	ax
	push	word [bp+10]
	call	_emit1
	sub	sp, -4
	jmp	L127
L218:
	jmp	L127
L215:

section .rodata
L222:
	db	"and"
	times	1 db 0

section .text
	push	L222
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L220
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
	test	ax, ax
	je	L225
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L225:
	test	ax, ax
	je	L223
	mov	ax, [bp-68]
	shl	ax, 3
	mov	cx, ax
	mov	ax, 192
	add	ax, cx
	add	ax, [bp-66]
	push	ax
	push	33
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L224
L223:
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L226
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, [bp-70]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, 224
	add	ax, [bp-66]
	push	ax
	push	129
	push	word [bp+10]
	call	_emit4
	sub	sp, -10
L226:
L224:
	jmp	L127
L220:

section .rodata
L232:
	db	"or"
	times	1 db 0

section .text
	push	L232
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L230
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
	test	ax, ax
	je	L235
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L235:
	test	ax, ax
	je	L233
	mov	ax, [bp-68]
	shl	ax, 3
	mov	cx, ax
	mov	ax, 192
	add	ax, cx
	add	ax, [bp-66]
	push	ax
	push	9
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L234
L233:
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L236
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, [bp-70]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, 200
	add	ax, [bp-66]
	push	ax
	push	129
	push	word [bp+10]
	call	_emit4
	sub	sp, -10
L236:
L234:
	jmp	L127
L230:

section .rodata
L242:
	db	"xor"
	times	1 db 0

section .text
	push	L242
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L240
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
	test	ax, ax
	je	L245
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L245:
	test	ax, ax
	je	L243
	mov	ax, [bp-68]
	shl	ax, 3
	mov	cx, ax
	mov	ax, 192
	add	ax, cx
	add	ax, [bp-66]
	push	ax
	push	49
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L244
L243:
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L246
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, [bp-70]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, 240
	add	ax, [bp-66]
	push	ax
	push	129
	push	word [bp+10]
	call	_emit4
	sub	sp, -10
L246:
L244:
	jmp	L127
L240:

section .rodata
L252:
	db	"not"
	times	1 db 0

section .text
	push	L252
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L250
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L253
	mov	ax, 208
	add	ax, [bp-66]
	push	ax
	push	247
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
L253:
	jmp	L127
L250:

section .rodata
L257:
	db	"test"
	times	1 db 0

section .text
	push	L257
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L255
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
	test	ax, ax
	je	L260
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L260:
	test	ax, ax
	je	L258
	mov	ax, [bp-68]
	shl	ax, 3
	mov	cx, ax
	mov	ax, 192
	add	ax, cx
	add	ax, [bp-66]
	push	ax
	push	133
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L259
L258:
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L261
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, [bp-70]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, 192
	add	ax, [bp-66]
	push	ax
	push	247
	push	word [bp+10]
	call	_emit4
	sub	sp, -10
L261:
L259:
	jmp	L127
L255:

section .rodata
L267:
	db	"shl"
	times	1 db 0

section .text
	push	L267
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L265
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L268

section .rodata
L272:
	db	"cl"
	times	1 db 0

section .text
	push	L272
	lea	ax, [bp-64]
	push	ax
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L270
	mov	ax, 224
	add	ax, [bp-66]
	push	ax
	push	211
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L271
L270:
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, 224
	add	ax, [bp-66]
	push	ax
	push	193
	push	word [bp+10]
	call	_emit3
	sub	sp, -8
L271:
L268:
	jmp	L127
L265:

section .rodata
L276:
	db	"shr"
	times	1 db 0

section .text
	push	L276
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L274
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L277

section .rodata
L281:
	db	"cl"
	times	1 db 0

section .text
	push	L281
	lea	ax, [bp-64]
	push	ax
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L279
	mov	ax, 232
	add	ax, [bp-66]
	push	ax
	push	211
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L280
L279:
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, 232
	add	ax, [bp-66]
	push	ax
	push	193
	push	word [bp+10]
	call	_emit3
	sub	sp, -8
L280:
L277:
	jmp	L127
L274:

section .rodata
L285:
	db	"rol"
	times	1 db 0

section .text
	push	L285
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L283
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L286

section .rodata
L290:
	db	"cl"
	times	1 db 0

section .text
	push	L290
	lea	ax, [bp-64]
	push	ax
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L288
	mov	ax, 192
	add	ax, [bp-66]
	push	ax
	push	211
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L289
L288:
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, 192
	add	ax, [bp-66]
	push	ax
	push	193
	push	word [bp+10]
	call	_emit3
	sub	sp, -8
L289:
L286:
	jmp	L127
L283:

section .rodata
L294:
	db	"ror"
	times	1 db 0

section .text
	push	L294
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L292
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L295

section .rodata
L299:
	db	"cl"
	times	1 db 0

section .text
	push	L299
	lea	ax, [bp-64]
	push	ax
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L297
	mov	ax, 200
	add	ax, [bp-66]
	push	ax
	push	211
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L298
L297:
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, 200
	add	ax, [bp-66]
	push	ax
	push	193
	push	word [bp+10]
	call	_emit3
	sub	sp, -8
L298:
L295:
	jmp	L127
L292:

section .rodata
L303:
	db	"cmp"
	times	1 db 0

section .text
	push	L303
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L301
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
	test	ax, ax
	je	L306
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L306:
	test	ax, ax
	je	L304
	mov	ax, [bp-68]
	shl	ax, 3
	mov	cx, ax
	mov	ax, 192
	add	ax, cx
	add	ax, [bp-66]
	push	ax
	push	57
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
	jmp	L305
L304:
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L307
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, [bp-70]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, [bp-70]
	and	ax, 255
	and	ax, 255
	push	ax
	mov	ax, 248
	add	ax, [bp-66]
	push	ax
	push	129
	push	word [bp+10]
	call	_emit4
	sub	sp, -10
L307:
L305:
	jmp	L127
L301:

section .rodata
L313:
	db	"jmp"
	times	1 db 0

section .text
	push	L313
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L311
	mov	ax, [bp+10]
	test	ax, ax
	je	L314
	lea	ax, [bp-32]
	push	ax
	call	_find_label
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, -16384
	add	ax, [_binary_size]
	add	ax, 3
	mov	cx, ax
	mov	ax, [bp-70]
	sub	ax, cx
	mov	[bp-72], ax
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 233
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 2
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
L314:
	mov	ax, [_binary_size]
	add	ax, 3
	mov	[_binary_size], ax
	jmp	L127
L311:

section .rodata
L320:
	db	"call"
	times	1 db 0

section .text
	push	L320
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L318
	mov	ax, [bp+10]
	test	ax, ax
	je	L321
	lea	ax, [bp-32]
	push	ax
	call	_find_label
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, -16384
	add	ax, [_binary_size]
	add	ax, 3
	mov	cx, ax
	mov	ax, [bp-70]
	sub	ax, cx
	mov	[bp-72], ax
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 232
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 2
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
L321:
	mov	ax, [_binary_size]
	add	ax, 3
	mov	[_binary_size], ax
	jmp	L127
L318:

section .rodata
L327:
	db	"je"
	times	1 db 0

section .text

section .rodata
L328:
	db	"jz"
	times	1 db 0

section .text
	push	L327
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	jne	L329
	push	L328
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	setne	al
	cbw
L329:
	test	ax, ax
	je	L325
	mov	ax, [bp+10]
	test	ax, ax
	je	L330
	lea	ax, [bp-32]
	push	ax
	call	_find_label
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, -16384
	add	ax, [_binary_size]
	add	ax, 4
	mov	cx, ax
	mov	ax, [bp-70]
	sub	ax, cx
	mov	[bp-72], ax
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 15
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	ax, 132
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 2
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 3
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
L330:
	mov	ax, [_binary_size]
	add	ax, 4
	mov	[_binary_size], ax
	jmp	L127
L325:

section .rodata
L336:
	db	"jne"
	times	1 db 0

section .text

section .rodata
L337:
	db	"jnz"
	times	1 db 0

section .text
	push	L336
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	jne	L338
	push	L337
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	setne	al
	cbw
L338:
	test	ax, ax
	je	L334
	mov	ax, [bp+10]
	test	ax, ax
	je	L339
	lea	ax, [bp-32]
	push	ax
	call	_find_label
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, -16384
	add	ax, [_binary_size]
	add	ax, 4
	mov	cx, ax
	mov	ax, [bp-70]
	sub	ax, cx
	mov	[bp-72], ax
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 15
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	ax, 133
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 2
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 3
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
L339:
	mov	ax, [_binary_size]
	add	ax, 4
	mov	[_binary_size], ax
	jmp	L127
L334:

section .rodata
L345:
	db	"jg"
	times	1 db 0

section .text
	push	L345
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L343
	mov	ax, [bp+10]
	test	ax, ax
	je	L346
	lea	ax, [bp-32]
	push	ax
	call	_find_label
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, -16384
	add	ax, [_binary_size]
	add	ax, 4
	mov	cx, ax
	mov	ax, [bp-70]
	sub	ax, cx
	mov	[bp-72], ax
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 15
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	ax, 143
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 2
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 3
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
L346:
	mov	ax, [_binary_size]
	add	ax, 4
	mov	[_binary_size], ax
	jmp	L127
L343:

section .rodata
L352:
	db	"jl"
	times	1 db 0

section .text
	push	L352
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L350
	mov	ax, [bp+10]
	test	ax, ax
	je	L353
	lea	ax, [bp-32]
	push	ax
	call	_find_label
	sub	sp, -2
	mov	[bp-70], ax
	mov	ax, -16384
	add	ax, [_binary_size]
	add	ax, 4
	mov	cx, ax
	mov	ax, [bp-70]
	sub	ax, cx
	mov	[bp-72], ax
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 15
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	ax, 140
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 2
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
	mov	ax, [_binary_size]
	add	ax, 3
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	push	ax
	mov	ax, [bp-72]
	sar	ax, 8
	and	ax, 255
	and	ax, 255
	pop	bx
	mov	[bx], al
	mov	ah, 0
L353:
	mov	ax, [_binary_size]
	add	ax, 4
	mov	[_binary_size], ax
	jmp	L127
L350:
L127:
	leave
	ret

section .text
	global	_parse_line
_parse_line:
	push	bp
	mov	bp, sp
	 sub	sp,        118

section .data
L359:
	times	16 db 0

section .text
	lea	ax, [bp-16]
	push	ax
	push	L359
	push	16
	call	L360
	sub	sp, -6

section .data
L361:
	times	64 db 0

section .text
	lea	ax, [bp-80]
	push	ax
	push	L361
	push	64
	call	L360
	sub	sp, -6

section .data
L362:
	times	32 db 0

section .text
	lea	ax, [bp-112]
	push	ax
	push	L362
	push	32
	call	L360
	sub	sp, -6
	mov	ax, 0
	mov	[bp-114], ax
	mov	ax, 0
	mov	[bp-116], ax
L363:
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	sete	al
	cbw
	test	ax, ax
	jne	L365
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 9
	sete	al
	cbw
L365:
	test	ax, ax
	je	L364
	mov	ax, [bp-114]
	inc	word [bp-114]
	jmp	L363
L364:
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 0
	sete	al
	cbw
	test	ax, ax
	jne	L369
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 10
	sete	al
	cbw
L369:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	jne	L368
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 59
	sete	al
	cbw
L368:
	test	ax, ax
	je	L366
	jmp	L357
L366:
	mov	ax, [bp-114]
	mov	[bp-118], ax
L370:
	mov	ax, [bp+4]
	add	ax, [bp-118]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L374
	mov	ax, [bp+4]
	add	ax, [bp-118]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	setne	al
	cbw
L374:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L373
	mov	ax, [bp+4]
	add	ax, [bp-118]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 9
	setne	al
	cbw
L373:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L372
	mov	ax, [bp+4]
	add	ax, [bp-118]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 58
	setne	al
	cbw
L372:
	test	ax, ax
	je	L371
	mov	ax, [bp-118]
	inc	word [bp-118]
	jmp	L370
L371:
	mov	ax, [bp+4]
	add	ax, [bp-118]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 58
	jne	L375
	mov	ax, [bp+6]
	cmp	ax, 0
	jne	L377
	mov	ax, 0
	mov	[bp-116], ax
L379:
	mov	ax, [bp-114]
	cmp	ax, [bp-118]
	setl	al
	cbw
	test	ax, ax
	je	L381
	mov	ax, [bp-116]
	cmp	ax, 15
	setl	al
	cbw
L381:
	test	ax, ax
	je	L380
	mov	ax, [_label_count]
	imul	ax, ax, 18
	mov	cx, ax
	mov	ax, _label_table
	add	ax, cx
	push	ax
	mov	ax, [bp-116]
	inc	word [bp-116]
	mov	cx, ax
	pop	ax
	add	ax, cx
	push	ax
	mov	ax, [bp-114]
	inc	word [bp-114]
	mov	cx, ax
	mov	ax, [bp+4]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
	jmp	L379
L380:
	mov	ax, [_label_count]
	imul	ax, ax, 18
	mov	cx, ax
	mov	ax, _label_table
	add	ax, cx
	add	ax, [bp-116]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
	mov	ax, [_label_count]
	imul	ax, ax, 18
	mov	cx, ax
	mov	ax, _label_table
	add	ax, cx
	add	ax, 16
	push	ax
	mov	ax, -16384
	add	ax, [_binary_size]
	pop	bx
	mov	[bx], ax
	mov	ax, [_label_count]
	inc	word [_label_count]
L377:
	jmp	L357
L375:
	mov	ax, 0
	mov	[bp-116], ax
L382:
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L386
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	setne	al
	cbw
L386:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L385
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 9
	setne	al
	cbw
L385:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L384
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 10
	setne	al
	cbw
L384:
	test	ax, ax
	je	L383
	mov	ax, [bp-116]
	cmp	ax, 15
	jge	L387
	mov	ax, [bp-116]
	inc	word [bp-116]
	mov	cx, ax
	lea	ax, [bp-16]
	add	ax, cx
	push	ax
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
L387:
	mov	ax, [bp-114]
	inc	word [bp-114]
	jmp	L382
L383:
	lea	ax, [bp-16]
	add	ax, [bp-116]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw

section .rodata
L391:
	db	"db"
	times	1 db 0

section .text
	push	L391
	lea	ax, [bp-16]
	push	ax
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	je	L389
L392:
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	sete	al
	cbw
	test	ax, ax
	jne	L394
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 9
	sete	al
	cbw
L394:
	test	ax, ax
	je	L393
	mov	ax, [bp-114]
	inc	word [bp-114]
	jmp	L392
L393:
	mov	ax, 0
	mov	[bp-116], ax
L395:
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L397
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 10
	setne	al
	cbw
L397:
	test	ax, ax
	je	L396
	mov	ax, [bp-116]
	cmp	ax, 63
	jge	L398
	mov	ax, [bp-116]
	inc	word [bp-116]
	mov	cx, ax
	lea	ax, [bp-80]
	add	ax, cx
	push	ax
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
L398:
	mov	ax, [bp-114]
	inc	word [bp-114]
	jmp	L395
L396:
	lea	ax, [bp-80]
	add	ax, [bp-116]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
	push	word [bp+6]
	lea	ax, [bp-112]
	push	ax
	lea	ax, [bp-80]
	push	ax
	lea	ax, [bp-16]
	push	ax
	call	_assemble_line
	sub	sp, -8
	jmp	L357
L389:
L400:
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	sete	al
	cbw
	test	ax, ax
	jne	L403
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 9
	sete	al
	cbw
L403:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	jne	L402
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 44
	sete	al
	cbw
L402:
	test	ax, ax
	je	L401
	mov	ax, [bp-114]
	inc	word [bp-114]
	jmp	L400
L401:
	mov	ax, 0
	mov	[bp-116], ax
L404:
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L410
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 44
	setne	al
	cbw
L410:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L409
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	setne	al
	cbw
L409:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L408
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 9
	setne	al
	cbw
L408:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L407
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 10
	setne	al
	cbw
L407:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L406
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 59
	setne	al
	cbw
L406:
	test	ax, ax
	je	L405
	mov	ax, [bp-116]
	cmp	ax, 63
	jge	L411
	mov	ax, [bp-116]
	inc	word [bp-116]
	mov	cx, ax
	lea	ax, [bp-80]
	add	ax, cx
	push	ax
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
L411:
	mov	ax, [bp-114]
	inc	word [bp-114]
	jmp	L404
L405:
	lea	ax, [bp-80]
	add	ax, [bp-116]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
L413:
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	sete	al
	cbw
	test	ax, ax
	jne	L416
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 9
	sete	al
	cbw
L416:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	jne	L415
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 44
	sete	al
	cbw
L415:
	test	ax, ax
	je	L414
	mov	ax, [bp-114]
	inc	word [bp-114]
	jmp	L413
L414:
	mov	ax, 0
	mov	[bp-116], ax
L417:
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L420
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 10
	setne	al
	cbw
L420:
	test	ax, ax
	setne	al
	cbw
	test	ax, ax
	je	L419
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 59
	setne	al
	cbw
L419:
	test	ax, ax
	je	L418
	mov	ax, [bp-116]
	cmp	ax, 31
	jge	L421
	mov	ax, [bp-116]
	inc	word [bp-116]
	mov	cx, ax
	lea	ax, [bp-112]
	add	ax, cx
	push	ax
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
L421:
	mov	ax, [bp-114]
	inc	word [bp-114]
	jmp	L417
L418:
	lea	ax, [bp-112]
	add	ax, [bp-116]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
	mov	al, [bp-16]
	cbw
	test	ax, ax
	je	L423
	push	word [bp+6]
	lea	ax, [bp-112]
	push	ax
	lea	ax, [bp-80]
	push	ax
	lea	ax, [bp-16]
	push	ax
	call	_assemble_line
	sub	sp, -8
L423:
L357:
	leave
	ret

section .text
	global	_run_pass
_run_pass:
	push	bp
	mov	bp, sp
	 sub	sp,          4
	mov	ax, 0
	mov	[bp-4], ax
	mov	ax, 0
	mov	[_binary_size], ax
	push	0
	push	word [bp+4]
	push	49
	call	_syscal
	sub	sp, -6
L427:
	push	1
	lea	ax, [bp-2]
	push	ax
	push	word [bp+4]
	push	47
	call	_syscal
	sub	sp, -8
	cmp	ax, 0
	jle	L428
	mov	al, [bp-2]
	cbw
	cmp	ax, 10
	sete	al
	cbw
	test	ax, ax
	jne	L431
	mov	ax, [bp-4]
	cmp	ax, 127
	setge	al
	cbw
L431:
	test	ax, ax
	je	L429
	mov	ax, _line_buffer
	add	ax, [bp-4]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
	push	word [bp+6]
	push	_line_buffer
	call	_parse_line
	sub	sp, -4
	mov	ax, 0
	mov	[bp-4], ax
	jmp	L430
L429:
	mov	ax, [bp-4]
	inc	word [bp-4]
	mov	cx, ax
	mov	ax, _line_buffer
	add	ax, cx
	mov	bx, ax
	mov	al, [bp-2]
	cbw
	mov	[bx], al
	cbw
L430:
	jmp	L427
L428:
	mov	ax, [bp-4]
	cmp	ax, 0
	jle	L432
	mov	ax, _line_buffer
	add	ax, [bp-4]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
	push	word [bp+6]
	push	_line_buffer
	call	_parse_line
	sub	sp, -4
L432:
L425:
	leave
	ret

section .text
	global	_main
_main:
	push	bp
	mov	bp, sp
	 sub	sp,         64

section .data
L436:
	db	"a.out"
	times	25 db 0

section .text
	lea	ax, [bp-60]
	push	ax
	push	L436
	push	30
	call	L360
	sub	sp, -6
	mov	ax, [bp+4]
	add	ax, 32
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	je	L437
	push	30
	mov	ax, [bp+4]
	add	ax, 32
	push	ax
	lea	ax, [bp-30]
	push	ax
	call	_str_copy
	sub	sp, -6
	mov	ax, [bp+4]
	add	ax, 64
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	je	L439
	push	30
	mov	ax, [bp+4]
	add	ax, 64
	push	ax
	lea	ax, [bp-60]
	push	ax
	call	_str_copy
	sub	sp, -6
L439:
	jmp	L438
L437:

section .rodata
L441:
	db	"source (.asm): "
	times	1 db 0

section .text
	push	L441
	push	9
	call	_syscal
	sub	sp, -4
	lea	ax, [bp-30]
	push	ax
	push	10
	call	_syscal
	sub	sp, -4

section .rodata
L442:
	db	"output (.bin): "
	times	1 db 0

section .text
	push	L442
	push	9
	call	_syscal
	sub	sp, -4
	lea	ax, [bp-60]
	push	ax
	push	10
	call	_syscal
	sub	sp, -4
L438:
	push	2
	lea	ax, [bp-30]
	push	ax
	push	45
	call	_syscal
	sub	sp, -6
	mov	[bp-62], ax
	mov	ax, [bp-62]
	cmp	ax, 0
	jge	L443

section .rodata
L445:
	db	"can't open source",10
	times	1 db 0

section .text
	push	L445
	push	9
	call	_syscal
	sub	sp, -4
	mov	ax, 1
	jmp	L434
L443:
	mov	ax, 0
	mov	[_label_count], ax
	push	0
	push	word [bp-62]
	call	_run_pass
	sub	sp, -4
	push	1
	push	word [bp-62]
	call	_run_pass
	sub	sp, -4
	push	word [bp-62]
	push	46
	call	_syscal
	sub	sp, -4
	push	5
	lea	ax, [bp-60]
	push	ax
	push	45
	call	_syscal
	sub	sp, -6
	mov	[bp-64], ax
	mov	ax, [bp-64]
	cmp	ax, 0
	jge	L446

section .rodata
L448:
	db	"can't open output",10
	times	1 db 0

section .text
	push	L448
	push	9
	call	_syscal
	sub	sp, -4
	mov	ax, 1
	jmp	L434
L446:
	push	word [_binary_size]
	push	_output_binary
	push	word [bp-64]
	push	48
	call	_syscal
	sub	sp, -8
	push	word [bp-64]
	push	46
	call	_syscal
	sub	sp, -4

section .rodata
L449:
	db	"assembled: "
	times	1 db 0

section .text
	push	L449
	push	9
	call	_syscal
	sub	sp, -4
	push	word [_binary_size]
	push	12
	call	_syscal
	sub	sp, -4

section .rodata
L450:
	db	" bytes",10
	times	1 db 0

section .text
	push	L450
	push	9
	call	_syscal
	sub	sp, -4
	mov	ax, 0
	jmp	L434
	mov	ax, 0
L434:
	leave
	ret

section .text
L360:
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






