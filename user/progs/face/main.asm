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
; glb show_banner : (void) void
section .text
	global	_show_banner
_show_banner:
	push	bp
	mov	bp, sp
	 sub	sp,        396
; RPN'ized expression: "( 0 , 0 , 10 style ) "
; Expanded expression: " 0  0  10  style ()6 "
; Fused expression:    "( 0 , 0 , 10 , style )6 "
	push	0
	push	0
	push	10
	call	_style
	sub	sp, -6

section .data
L3:
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "10 "
; Expanded expression: "10 "
; Expression value: 10
	db	10
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "201 "
; Expanded expression: "201 "
; Expression value: 201
	db	201
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "201 "
; Expanded expression: "201 "
; Expression value: 201
	db	201
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "201 "
; Expanded expression: "201 "
; Expression value: 201
	db	201
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "201 "
; Expanded expression: "201 "
; Expression value: 201
	db	201
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "10 "
; Expanded expression: "10 "
; Expression value: 10
	db	10
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "201 "
; Expanded expression: "201 "
; Expression value: 201
	db	201
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "201 "
; Expanded expression: "201 "
; Expression value: 201
	db	201
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "10 "
; Expanded expression: "10 "
; Expression value: 10
	db	10
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "201 "
; Expanded expression: "201 "
; Expression value: 201
	db	201
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "201 "
; Expanded expression: "201 "
; Expression value: 201
	db	201
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "10 "
; Expanded expression: "10 "
; Expression value: 10
	db	10
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "201 "
; Expanded expression: "201 "
; Expression value: 201
	db	201
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "187 "
; Expanded expression: "187 "
; Expression value: 187
	db	187
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "219 "
; Expanded expression: "219 "
; Expression value: 219
	db	219
; RPN'ized expression: "186 "
; Expanded expression: "186 "
; Expression value: 186
	db	186
; RPN'ized expression: "10 "
; Expanded expression: "10 "
; Expression value: 10
	db	10
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "200 "
; Expanded expression: "200 "
; Expression value: 200
	db	200
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "188 "
; Expanded expression: "188 "
; Expression value: 188
	db	188
; RPN'ized expression: "10 "
; Expanded expression: "10 "
; Expression value: 10
	db	10
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	db	0

section .text
; loc     img : (@-338) : [337u] char
; =
; Fused expression:    "( (@-338) , L3 , 337u , L4 )6 "
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
; RPN'ized expression: "( img , L5 pformat ) "
; Expanded expression: " (@-338)  L5  pformat ()4 "
; Fused expression:    "( (@-338) , L5 , pformat )4 "
	lea	ax, [bp-338]
	push	ax
	push	L5
	call	_pformat
	sub	sp, -4
; RPN'ized expression: "( 0 , 0 , 11 style ) "
; Expanded expression: " 0  0  11  style ()6 "
; Fused expression:    "( 0 , 0 , 11 , style )6 "
	push	0
	push	0
	push	11
	call	_style
	sub	sp, -6

section .rodata
L6:
	db	" STNIX-16  16-BIT OS  ~c",10," "
	times	1 db 0

section .text
; RPN'ized expression: "( 2 , L6 pformat ) "
; Expanded expression: " 2  L6  pformat ()4 "
; Fused expression:    "( 2 , L6 , pformat )4 "
	push	2
	push	L6
	call	_pformat
	sub	sp, -4

section .rodata
L7:
	db	" Copyright (c) 2026, Chandan Das ",10
	db	" All rights reserved. ",10,10
	times	1 db 0

section .text
; RPN'ized expression: "( L7 pformat ) "
; Expanded expression: " L7  pformat ()2 "
; Fused expression:    "( L7 , pformat )2 "
	push	L7
	call	_pformat
	sub	sp, -2
; for
; loc     i : (@-340) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-340) 0 =(2) "
; Fused expression:    "=(170) *(@-340) 0 "
	mov	ax, 0
	mov	[bp-340], ax
L8:
; RPN'ized expression: "i 16 < "
; Expanded expression: "(@-340) *(2) 16 < "
; Fused expression:    "< *(@-340) 16 IF! "
	mov	ax, [bp-340]
	cmp	ax, 16
	jge	L11
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-340) ++p(2) "
; {
; RPN'ized expression: "( 0 , 0 , i style ) "
; Expanded expression: " 0  0  (@-340) *(2)  style ()6 "
; Fused expression:    "( 0 , 0 , *(2) (@-340) , style )6 "
	push	0
	push	0
	push	word [bp-340]
	call	_style
	sub	sp, -6
; RPN'ized expression: "( 219 putchar ) "
; Expanded expression: " 219  putchar ()2 "
; Fused expression:    "( 219 , putchar )2 "
	push	219
	call	_putchar
	sub	sp, -2
; RPN'ized expression: "( 219 putchar ) "
; Expanded expression: " 219  putchar ()2 "
; Fused expression:    "( 219 , putchar )2 "
	push	219
	call	_putchar
	sub	sp, -2
; }
L9:
; Fused expression:    "++p(2) *(@-340) "
	mov	ax, [bp-340]
	inc	word [bp-340]
	jmp	L8
L11:
; RPN'ized expression: "( 0 , 0 , 6 style ) "
; Expanded expression: " 0  0  6  style ()6 "
; Fused expression:    "( 0 , 0 , 6 , style )6 "
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
; RPN'ized expression: "( 16 , L12 pformat ) "
; Expanded expression: " 16  L12  pformat ()4 "
; Fused expression:    "( 16 , L12 , pformat )4 "
	push	16
	push	L12
	call	_pformat
	sub	sp, -4
; RPN'ized expression: "( 0 , 0 , 10 style ) "
; Expanded expression: " 0  0  10  style ()6 "
; Fused expression:    "( 0 , 0 , 10 , style )6 "
	push	0
	push	0
	push	10
	call	_style
	sub	sp, -6

section .data
L13:
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
	db	32
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "205 "
; Expanded expression: "205 "
; Expression value: 205
	db	205
; RPN'ized expression: "10 "
; Expanded expression: "10 "
; Expression value: 10
	db	10
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	db	0

section .text
; loc     bline : (@-396) : [58u] char
; =
; Fused expression:    "( (@-396) , L13 , 58u , L4 )6 "
	lea	ax, [bp-396]
	push	ax
	push	L13
	push	58
	call	L4
	sub	sp, -6
; RPN'ized expression: "( bline puts ) "
; Expanded expression: " (@-396)  puts ()2 "
; Fused expression:    "( (@-396) , puts )2 "
	lea	ax, [bp-396]
	push	ax
	call	_puts
	sub	sp, -2
L1:
	leave
	ret

; glb main : () int
section .text
	global	_main
_main:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; RPN'ized expression: "( show_banner ) "
; Expanded expression: " show_banner ()0 "
; Fused expression:    "( show_banner )0 "
	call	_show_banner
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L14
; Fused expression:    "0  "
	mov	ax, 0
L14:
	leave
	ret

section .text
L4:
	push	bp
	mov	bp, sp
	;sub	sp,          0
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
; Ident show_banner
; Ident main
; Bytes used: 270/5632

; Next label number: 16
; Compilation succeeded.
