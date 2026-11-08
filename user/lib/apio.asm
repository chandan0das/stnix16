bits 16

; glb syscal : (
; prm     num : int
; prm     ...
;     ) int
; glb style : (
; prm     fg : unsigned char
; prm     bg : unsigned char
; prm     blink : unsigned char
;     ) int
; glb pformat : (
; prm     f : * char
; prm     ...
;     ) int
; glb puts : (
; prm     s : * char
;     ) int
; glb gets : (
; prm     s : * char
;     ) * char
; glb kbhit : (void) int
; glb putchar : (
; prm     c : int
;     ) int
; glb getchar : (void) int
; glb puti : (
; prm     n : int
;     ) int
; glb putx : (
; prm     n : int
;     ) int
; glb atoi : (
; prm     sn : * char
;     ) int
; glb kbhit : (void) int
; glb style : (
; prm     fg : unsigned char
; prm     bg : unsigned char
; prm     blink : unsigned char
;     ) int
section .text
	global	_style
_style:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     fg : (@4) : unsigned char
; loc     bg : (@6) : unsigned char
; loc     blink : (@8) : unsigned char
; return
; RPN'ized expression: "( blink , bg , fg , 1 syscal ) "
; Expanded expression: " (@8) *(1)  (@6) *(1)  (@4) *(1)  1  syscal ()8 "
; Fused expression:    "( *(1) (@8) , *(1) (@6) , *(1) (@4) , 1 , syscal )8  "
	mov	al, [bp+8]
	mov	ah, 0
	push	ax
	mov	al, [bp+6]
	mov	ah, 0
	push	ax
	mov	al, [bp+4]
	mov	ah, 0
	push	ax
	push	1
	call	_syscal
	sub	sp, -8
L1:
	leave
	ret

; glb pformat : (
; prm     f : * char
; prm     ...
;     ) int
section .text
	global	_pformat
_pformat:
	push	bp
	mov	bp, sp
	 sub	sp,          6
; loc     f : (@4) : * char
; loc     count : (@-2) : int
; RPN'ized expression: "count 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; loc     p : (@-4) : * char
; RPN'ized expression: "p f = "
; Expanded expression: "(@-4) (@4) *(2) =(2) "
; Fused expression:    "=(170) *(@-4) *(@4) "
	mov	ax, [bp+4]
	mov	[bp-4], ax
; loc     args : (@-6) : * int
; loc     <something> : * int
; RPN'ized expression: "args f &u 1 + (something5) = "
; Expanded expression: "(@-6) (@6) =(2) "
; Fused expression:    "=(170) *(@-6) (@6) "
	lea	ax, [bp+6]
	mov	[bp-6], ax
; while
; RPN'ized expression: "p *u "
; Expanded expression: "(@-4) *(2) *(-1) "
L6:
; Fused expression:    "*(2) (@-4) *(-1) ax  "
	mov	ax, [bp-4]
	mov	bx, ax
	mov	al, [bx]
	cbw
; JumpIfZero
	test	ax, ax
	je	L7
; {
; if
; RPN'ized expression: "p *u 126 == "
; Expanded expression: "(@-4) *(2) *(-1) 126 == "
; Fused expression:    "*(2) (@-4) == *ax 126 IF! "
	mov	ax, [bp-4]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 126
	jne	L8
; {
; RPN'ized expression: "p ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; switch
; RPN'ized expression: "p *u "
; Expanded expression: "(@-4) *(2) *(-1) "
; Fused expression:    "*(2) (@-4) *(-1) ax  "
	mov	ax, [bp-4]
	mov	bx, ax
	mov	al, [bx]
	cbw
	jmp	L11
; {
; case
; RPN'ized expression: "99 "
; Expanded expression: "99 "
; Expression value: 99
L12:
; loc                 <something> : char
; RPN'ized expression: "( args ++p *u (something13) putchar ) "
; Expanded expression: " (@-6) 2 +=p(2) *(2) signed char  putchar ()2 "
; Fused expression:    "( +=p(2) *(@-6) 2 *(2) ax signed char , putchar )2 "
	mov	ax, [bp-6]
	add	word [bp-6], 2
	mov	bx, ax
	mov	ax, [bx]
	cbw
	push	ax
	call	_putchar
	sub	sp, -2
; break
	jmp	L10
; case
; RPN'ized expression: "115 "
; Expanded expression: "115 "
; Expression value: 115
L14:
; loc                 <something> : * char
; RPN'ized expression: "( args ++p *u (something15) puts ) "
; Expanded expression: " (@-6) 2 +=p(2) *(2)  puts ()2 "
; Fused expression:    "( +=p(2) *(@-6) 2 *(2) ax , puts )2 "
	mov	ax, [bp-6]
	add	word [bp-6], 2
	mov	bx, ax
	push	word [bx]
	call	_puts
	sub	sp, -2
; break
	jmp	L10
; case
; RPN'ized expression: "105 "
; Expanded expression: "105 "
; Expression value: 105
L16:
; loc                 <something> : int
; RPN'ized expression: "( args ++p *u (something17) puti ) "
; Expanded expression: " (@-6) 2 +=p(2) *(2)  puti ()2 "
; Fused expression:    "( +=p(2) *(@-6) 2 *(2) ax , puti )2 "
	mov	ax, [bp-6]
	add	word [bp-6], 2
	mov	bx, ax
	push	word [bx]
	call	_puti
	sub	sp, -2
; break
	jmp	L10
; case
; RPN'ized expression: "120 "
; Expanded expression: "120 "
; Expression value: 120
L18:
; loc                 <something> : unsigned
; RPN'ized expression: "( args ++p *u (something19) putx ) "
; Expanded expression: " (@-6) 2 +=p(2) *(2)  putx ()2 "
; Fused expression:    "( +=p(2) *(@-6) 2 *(2) ax , putx )2 "
	mov	ax, [bp-6]
	add	word [bp-6], 2
	mov	bx, ax
	push	word [bx]
	call	_putx
	sub	sp, -2
; break
	jmp	L10
; default
L20:
; RPN'ized expression: "( 126 putchar ) "
; Expanded expression: " 126  putchar ()2 "
; Fused expression:    "( 126 , putchar )2 "
	push	126
	call	_putchar
	sub	sp, -2
; RPN'ized expression: "( p *u putchar ) "
; Expanded expression: " (@-4) *(2) *(-1)  putchar ()2 "
; Fused expression:    "( *(2) (@-4) *(-1) ax , putchar )2 "
	mov	ax, [bp-4]
	mov	bx, ax
	mov	al, [bx]
	cbw
	push	ax
	call	_putchar
	sub	sp, -2
; }
	jmp	L10
L11:
	cmp	ax, 99
	je	L12
	cmp	ax, 115
	je	L14
	cmp	ax, 105
	je	L16
	cmp	ax, 120
	je	L18
	jmp	L20
L10:
; }
	jmp	L9
L8:
; else
; {
; RPN'ized expression: "( p *u putchar ) "
; Expanded expression: " (@-4) *(2) *(-1)  putchar ()2 "
; Fused expression:    "( *(2) (@-4) *(-1) ax , putchar )2 "
	mov	ax, [bp-4]
	mov	bx, ax
	mov	al, [bx]
	cbw
	push	ax
	call	_putchar
	sub	sp, -2
; }
L9:
; RPN'ized expression: "p ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; }
	jmp	L6
L7:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
L3:
	leave
	ret

; glb puts : (
; prm     s : * char
;     ) int
section .text
	global	_puts
_puts:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     s : (@4) : * char
; return
; RPN'ized expression: "( s , 9 syscal ) "
; Expanded expression: " (@4) *(2)  9  syscal ()4 "
; Fused expression:    "( *(2) (@4) , 9 , syscal )4  "
	push	word [bp+4]
	push	9
	call	_syscal
	sub	sp, -4
L21:
	leave
	ret

; glb gets : (
; prm     s : * char
;     ) * char
section .text
	global	_gets
_gets:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     s : (@4) : * char
; return
; RPN'ized expression: "( s , 10 syscal ) "
; Expanded expression: " (@4) *(2)  10  syscal ()4 "
; Fused expression:    "( *(2) (@4) , 10 , syscal )4  "
	push	word [bp+4]
	push	10
	call	_syscal
	sub	sp, -4
L23:
	leave
	ret

; glb kbhit : (void) int
section .text
	global	_kbhit
_kbhit:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; return
; RPN'ized expression: "( 14 syscal ) "
; Expanded expression: " 14  syscal ()2 "
; Fused expression:    "( 14 , syscal )2  "
	push	14
	call	_syscal
	sub	sp, -2
L25:
	leave
	ret

; glb putchar : (
; prm     c : int
;     ) int
section .text
	global	_putchar
_putchar:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     c : (@4) : int
; return
; RPN'ized expression: "( c , 7 syscal ) "
; Expanded expression: " (@4) *(2)  7  syscal ()4 "
; Fused expression:    "( *(2) (@4) , 7 , syscal )4  "
	push	word [bp+4]
	push	7
	call	_syscal
	sub	sp, -4
L27:
	leave
	ret

; glb getchar : (void) int
section .text
	global	_getchar
_getchar:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; return
; RPN'ized expression: "( 8 syscal ) "
; Expanded expression: " 8  syscal ()2 "
; Fused expression:    "( 8 , syscal )2  "
	push	8
	call	_syscal
	sub	sp, -2
L29:
	leave
	ret

; glb putx : (
; prm     n : int
;     ) int
section .text
	global	_putx
_putx:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     n : (@4) : int
; return
; RPN'ized expression: "( n , 13 syscal ) "
; Expanded expression: " (@4) *(2)  13  syscal ()4 "
; Fused expression:    "( *(2) (@4) , 13 , syscal )4  "
	push	word [bp+4]
	push	13
	call	_syscal
	sub	sp, -4
L31:
	leave
	ret

; glb puti : (
; prm     n : int
;     ) int
section .text
	global	_puti
_puti:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     n : (@4) : int
; return
; RPN'ized expression: "( n , 12 syscal ) "
; Expanded expression: " (@4) *(2)  12  syscal ()4 "
; Fused expression:    "( *(2) (@4) , 12 , syscal )4  "
	push	word [bp+4]
	push	12
	call	_syscal
	sub	sp, -4
L33:
	leave
	ret

; glb atoi : (
; prm     sn : * char
;     ) int
section .text
	global	_atoi
_atoi:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     sn : (@4) : * char
; return
; RPN'ized expression: "( sn , 11 syscal ) "
; Expanded expression: " (@4) *(2)  11  syscal ()4 "
; Fused expression:    "( *(2) (@4) , 11 , syscal )4  "
	push	word [bp+4]
	push	11
	call	_syscal
	sub	sp, -4
L35:
	leave
	ret


	extern	_syscal

; Syntax/declaration table/stack:
; Bytes used: 835/15360


; Macro table:
; Macro __SMALLER_C__ = `0x0100`
; Macro __SMALLER_C_16__ = ``
; Macro __SMALLER_C_SCHAR__ = ``
; Macro __SMALLER_C_UWCHAR__ = ``
; Macro __SMALLER_C_WCHAR16__ = ``
; Macro SYSCALL_H = ``
; Macro STYL = `1`
; Macro CLRS = `2`
; Macro GETX = `3`
; Macro GETY = `4`
; Macro SETX = `5`
; Macro SETY = `6`
; Macro PUTC = `7`
; Macro GETC = `8`
; Macro PUTS = `9`
; Macro GETS = `10`
; Macro ATOI = `11`
; Macro PUTI = `12`
; Macro PUTH = `13`
; Macro KHIT = `14`
; Macro SLEEP = `20`
; Macro ALOC = `30`
; Macro RLOC = `31`
; Macro FREE = `32`
; Macro MKDIR = `40`
; Macro LS = `41`
; Macro CD = `42`
; Macro DELETE = `43`
; Macro F_OPEN = `45`
; Macro F_CLOSE = `46`
; Macro F_READ = `47`
; Macro F_WRITE = `48`
; Macro F_SEEK = `49`
; Macro F_TELL = `50`
; Macro F_SIZE = `51`
; Macro _APIO_H = ``
; Macro DUMP = `0xE000`
; Macro BLACK = `0x0`
; Macro BLUE = `0x1`
; Macro GREEN = `0x2`
; Macro CYAN = `0x3`
; Macro RED = `0x4`
; Macro MAGENTA = `0x5`
; Macro BROWN = `0x6`
; Macro LIGHT_GRAY = `0x7`
; Macro DARK_GRAY = `0x8`
; Macro LIGHT_BLUE = `0x9`
; Macro LIGHT_GREEN = `0xA`
; Macro LIGHT_CYAN = `0xB`
; Macro LIGHT_RED = `0xC`
; Macro LIGHT_MAGENTA = `0xD`
; Macro YELLOW = `0xE`
; Macro WHITE = `0xF`
; Bytes used: 625/5120


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
; Ident syscal
; Ident num
; Ident <something>
; Ident style
; Ident fg
; Ident bg
; Ident blink
; Ident pformat
; Ident f
; Ident puts
; Ident s
; Ident gets
; Ident kbhit
; Ident putchar
; Ident c
; Ident getchar
; Ident puti
; Ident n
; Ident putx
; Ident atoi
; Ident sn
; Bytes used: 251/5632

; Next label number: 37
; Compilation succeeded.
