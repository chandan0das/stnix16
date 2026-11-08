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
; RPN'ized expression: "4 "
; Expanded expression: "4 "
; Expression value: 4
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
; glb main : (
; prm     args : * [32u] char
;     ) int
section .text
	global	_main
_main:
	push	bp
	mov	bp, sp
	 sub	sp,         32
; loc     args : (@4) : * [32u] char
; RPN'ized expression: "30 "
; Expanded expression: "30 "
; Expression value: 30
; loc     name : (@-30) : [30u] char

section .rodata
L3:
	db	"Hello, ~s ",10
	times	1 db 0

section .text
; RPN'ized expression: "( args 1 + *u , L3 pformat ) "
; Expanded expression: " (@4) *(2) 32 +  L3  pformat ()4 "
; Fused expression:    "( + *(@4) 32 , L3 , pformat )4 "
	mov	ax, [bp+4]
	add	ax, 32
	push	ax
	push	L3
	call	_pformat
	sub	sp, -4
; RPN'ized expression: "( name puts ) "
; Expanded expression: " (@-30)  puts ()2 "
; Fused expression:    "( (@-30) , puts )2 "
	lea	ax, [bp-30]
	push	ax
	call	_puts
	sub	sp, -2

section .rodata
L4:
	db	"The arguments are:  "
	times	1 db 0

section .text
; RPN'ized expression: "( L4 puts ) "
; Expanded expression: " L4  puts ()2 "
; Fused expression:    "( L4 , puts )2 "
	push	L4
	call	_puts
	sub	sp, -2
; for
; loc     i : (@-32) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-32) 0 =(2) "
; Fused expression:    "=(170) *(@-32) 0 "
	mov	ax, 0
	mov	[bp-32], ax
L5:
; RPN'ized expression: "i 4 < "
; Expanded expression: "(@-32) *(2) 4 < "
; Fused expression:    "< *(@-32) 4 IF! "
	mov	ax, [bp-32]
	cmp	ax, 4
	jge	L8
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-32) ++p(2) "
; {

section .rodata
L9:
	db	"~s ",10
	times	1 db 0

section .text
; RPN'ized expression: "( args i + *u , L9 pformat ) "
; Expanded expression: " (@4) *(2) (@-32) *(2) 32 * +  L9  pformat ()4 "
; Fused expression:    "( * *(@-32) 32 + *(@4) ax , L9 , pformat )4 "
	mov	ax, [bp-32]
	imul	ax, ax, 32
	mov	cx, ax
	mov	ax, [bp+4]
	add	ax, cx
	push	ax
	push	L9
	call	_pformat
	sub	sp, -4
; }
L6:
; Fused expression:    "++p(2) *(@-32) "
	mov	ax, [bp-32]
	inc	word [bp-32]
	jmp	L5
L8:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L1
; Fused expression:    "0  "
	mov	ax, 0
L1:
	leave
	ret


	extern	_pformat
	extern	_puts

; Syntax/declaration table/stack:
; Bytes used: 530/15360


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
; Ident main
; Ident args
; Bytes used: 263/5632

; Next label number: 10
; Compilation succeeded.
