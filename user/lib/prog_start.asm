bits 16

; RPN'ized expression: "4 "
; Expanded expression: "4 "
; Expression value: 4
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
; glb main : (
; prm     args : * [32u] char
;     ) int
; RPN'ized expression: "4 "
; Expanded expression: "4 "
; Expression value: 4
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
; glb parse_args : (
; prm     cmd_line : * char
; prm     args : * [32u] char
;     ) void
section .text
	global	_parse_args
_parse_args:
	push	bp
	mov	bp, sp
	 sub	sp,          6
; loc     cmd_line : (@4) : * char
; loc     args : (@6) : * [32u] char
; loc     k : (@-2) : int
; RPN'ized expression: "k 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; for
; loc     i : (@-4) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
L3:
; RPN'ized expression: "i 4 < "
; Expanded expression: "(@-4) *(2) 4 < "
; Fused expression:    "< *(@-4) 4 IF! "
	mov	ax, [bp-4]
	cmp	ax, 4
	jge	L6
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-4) ++p(2) "
; {
; while
; RPN'ized expression: "cmd_line k + *u 32 == "
; Expanded expression: "(@4) *(2) (@-2) *(2) + *(-1) 32 == "
L7:
; Fused expression:    "+ *(@4) *(@-2) == *ax 32 IF! "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	jne	L8
; RPN'ized expression: "k ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L7
L8:
; loc         j : (@-6) : int
; RPN'ized expression: "j 0 = "
; Expanded expression: "(@-6) 0 =(2) "
; Fused expression:    "=(170) *(@-6) 0 "
	mov	ax, 0
	mov	[bp-6], ax
; while
; RPN'ized expression: "j 31 < cmd_line k + *u 0 != && cmd_line k + *u 32 != && "
; Expanded expression: "(@-6) *(2) 31 < [sh&&->12] (@4) *(2) (@-2) *(2) + *(-1) 0 != &&[12] _Bool [sh&&->11] (@4) *(2) (@-2) *(2) + *(-1) 32 != &&[11] "
L9:
; Fused expression:    "< *(@-6) 31 [sh&&->12] + *(@4) *(@-2) != *ax 0 &&[12] _Bool [sh&&->11] + *(@4) *(@-2) != *ax 32 &&[11]  "
	mov	ax, [bp-6]
	cmp	ax, 31
	setl	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L12
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 0
	setne	al
	cbw
L12:
	test	ax, ax
	setne	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L11
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	setne	al
	cbw
L11:
; JumpIfZero
	test	ax, ax
	je	L10
; {
; RPN'ized expression: "args i + *u j ++p + *u cmd_line k ++p + *u = "
; Expanded expression: "(@6) *(2) (@-4) *(2) 32 * + (@-6) ++p(2) + (@4) *(2) (@-2) ++p(2) + *(-1) =(-1) "
; Fused expression:    "* *(@-4) 32 + *(@6) ax push-ax ++p(2) *(@-6) + *sp ax push-ax ++p(2) *(@-2) + *(@4) ax =(119) **sp *ax "
	mov	ax, [bp-4]
	imul	ax, ax, 32
	mov	cx, ax
	mov	ax, [bp+6]
	add	ax, cx
	push	ax
	mov	ax, [bp-6]
	inc	word [bp-6]
	mov	cx, ax
	pop	ax
	add	ax, cx
	push	ax
	mov	ax, [bp-2]
	inc	word [bp-2]
	mov	cx, ax
	mov	ax, [bp+4]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
; }
	jmp	L9
L10:
; RPN'ized expression: "args i + *u j + *u 0 = "
; Expanded expression: "(@6) *(2) (@-4) *(2) 32 * + (@-6) *(2) + 0 =(-1) "
; Fused expression:    "* *(@-4) 32 + *(@6) ax + ax *(@-6) =(122) *ax 0 "
	mov	ax, [bp-4]
	imul	ax, ax, 32
	mov	cx, ax
	mov	ax, [bp+6]
	add	ax, cx
	add	ax, [bp-6]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; }
L4:
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
	jmp	L3
L6:
L1:
	leave
	ret

; glb prog_start : (
; prm     cmd_line : * char
;     ) void
section .text
	global	_prog_start
_prog_start:
	push	bp
	mov	bp, sp
	 sub	sp,        128
; loc     cmd_line : (@4) : * char
; RPN'ized expression: "4 "
; Expanded expression: "4 "
; Expression value: 4
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
; loc     args : (@-128) : [4u] [32u] char
; RPN'ized expression: "( args , cmd_line parse_args ) "
; Expanded expression: " (@-128)  (@4) *(2)  parse_args ()4 "
; Fused expression:    "( (@-128) , *(2) (@4) , parse_args )4 "
	lea	ax, [bp-128]
	push	ax
	push	word [bp+4]
	call	_parse_args
	sub	sp, -4
; RPN'ized expression: "( args main ) "
; Expanded expression: " (@-128)  main ()2 "
; Fused expression:    "( (@-128) , main )2 "
	lea	ax, [bp-128]
	push	ax
	call	_main
	sub	sp, -2
L13:
	leave
	ret


	extern	_main

; Syntax/declaration table/stack:
; Bytes used: 205/15360


; Macro table:
; Macro __SMALLER_C__ = `0x0100`
; Macro __SMALLER_C_16__ = ``
; Macro __SMALLER_C_SCHAR__ = ``
; Macro __SMALLER_C_UWCHAR__ = ``
; Macro __SMALLER_C_WCHAR16__ = ``
; Bytes used: 110/5120


; Identifier table:
; Ident 
; Ident __floatsisf
; Ident __floatunsisf
; Ident __fixsfsi
; Ident __fixunssfsi
; Ident __addsf3
; Ident __subsf3
; Ident __negsf2
; Ident __mulsf3
; Ident __divsf3
; Ident __lesf2
; Ident __gesf2
; Ident main
; Ident args
; Ident parse_args
; Ident cmd_line
; Ident prog_start
; Bytes used: 169/5632

; Next label number: 15
; Compilation succeeded.
