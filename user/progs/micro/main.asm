; Copyright (c) 2026, Chandan Das
; All rights reserved.
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions are met:
;
; 1. Redistributions of source code must retain the above copyright notice, this
;    list of conditions and the following disclaimer.
; 2. Redistributions in binary form must reproduce the above copyright notice,
;    this list of conditions and the following disclaimer in the documentation
;    and/or other materials provided with the distribution.
;
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
; DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
; ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
; ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;
; ***************************************************************************
; *                                                                           *
; *                                  STNIX 16                                 *
; *                                                                           *
; *                A 16-bit monolithic operating system for x86               *
; *                                                                           *
; *                         user/progs/micro/main.asm                         *
; *                                                                           *
; ***************************************************************************

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
; RPN'ized expression: "4097 "
; Expanded expression: "4097 "
; Expression value: 4097
; glb text_buffer : [4097u] char
section .bss
	global	_text_buffer
_text_buffer:
	resb	4097

; glb text_len : int
section .data
	align 2
	global	_text_len
_text_len:
; =
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	dw	0

; glb buffer_pos : int
section .data
	align 2
	global	_buffer_pos
_buffer_pos:
; =
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	dw	0

; RPN'ized expression: "30 "
; Expanded expression: "30 "
; Expression value: 30
; glb current_filename : [30u] char
section .bss
	global	_current_filename
_current_filename:
	resb	30

; glb menu_active : int
section .data
	align 2
	global	_menu_active
_menu_active:
; =
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	dw	0

; glb move_cursor : (
; prm     x : int
; prm     y : int
;     ) void
section .text
	global	_move_cursor
_move_cursor:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     x : (@4) : int
; loc     y : (@6) : int
; RPN'ized expression: "( x , 5 syscal ) "
; Expanded expression: " (@4) *(2)  5  syscal ()4 "
; Fused expression:    "( *(2) (@4) , 5 , syscal )4 "
	push	word [bp+4]
	push	5
	call	_syscal
	sub	sp, -4
; RPN'ized expression: "( y , 6 syscal ) "
; Expanded expression: " (@6) *(2)  6  syscal ()4 "
; Fused expression:    "( *(2) (@6) , 6 , syscal )4 "
	push	word [bp+6]
	push	6
	call	_syscal
	sub	sp, -4
L1:
	leave
	ret

; glb clear_row : (
; prm     row : int
; prm     fg : unsigned char
; prm     bg : unsigned char
;     ) void
section .text
	global	_clear_row
_clear_row:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     row : (@4) : int
; loc     fg : (@6) : unsigned char
; loc     bg : (@8) : unsigned char
; loc     x : (@-2) : int
; RPN'ized expression: "( row , 0 move_cursor ) "
; Expanded expression: " (@4) *(2)  0  move_cursor ()4 "
; Fused expression:    "( *(2) (@4) , 0 , move_cursor )4 "
	push	word [bp+4]
	push	0
	call	_move_cursor
	sub	sp, -4
; RPN'ized expression: "( 0 , bg , fg style ) "
; Expanded expression: " 0  (@8) *(1)  (@6) *(1)  style ()6 "
; Fused expression:    "( 0 , *(1) (@8) , *(1) (@6) , style )6 "
	push	0
	mov	al, [bp+8]
	mov	ah, 0
	push	ax
	mov	al, [bp+6]
	mov	ah, 0
	push	ax
	call	_style
	sub	sp, -6
; for
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
L5:
; RPN'ized expression: "x 80 < "
; Expanded expression: "(@-2) *(2) 80 < "
; Fused expression:    "< *(@-2) 80 IF! "
	mov	ax, [bp-2]
	cmp	ax, 80
	jge	L8
; RPN'ized expression: "x ++p "
; Expanded expression: "(@-2) ++p(2) "
; {
; RPN'ized expression: "( 32 putchar ) "
; Expanded expression: " 32  putchar ()2 "
; Fused expression:    "( 32 , putchar )2 "
	push	32
	call	_putchar
	sub	sp, -2
; }
L6:
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L5
L8:
L3:
	leave
	ret

; glb get_xy_from_pos : (
; prm     pos : int
; prm     out_x : * int
; prm     out_y : * int
;     ) void
section .text
	global	_get_xy_from_pos
_get_xy_from_pos:
	push	bp
	mov	bp, sp
	 sub	sp,          6
; loc     pos : (@4) : int
; loc     out_x : (@6) : * int
; loc     out_y : (@8) : * int
; loc     x : (@-2) : int
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; loc     y : (@-4) : int
; RPN'ized expression: "y 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; loc     i : (@-6) : int
; for
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-6) 0 =(2) "
; Fused expression:    "=(170) *(@-6) 0 "
	mov	ax, 0
	mov	[bp-6], ax
L11:
; RPN'ized expression: "i pos < "
; Expanded expression: "(@-6) *(2) (@4) *(2) < "
; Fused expression:    "< *(@-6) *(@4) IF! "
	mov	ax, [bp-6]
	cmp	ax, [bp+4]
	jge	L14
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-6) ++p(2) "
; {
; if
; RPN'ized expression: "text_buffer i + *u 10 == "
; Expanded expression: "text_buffer (@-6) *(2) + *(-1) 10 == "
; Fused expression:    "+ text_buffer *(@-6) == *ax 10 IF! "
	mov	ax, _text_buffer
	add	ax, [bp-6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 10
	jne	L15
; {
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; RPN'ized expression: "y ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; }
	jmp	L16
L15:
; else
; {
; RPN'ized expression: "x ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; if
; RPN'ized expression: "x 80 >= "
; Expanded expression: "(@-2) *(2) 80 >= "
; Fused expression:    ">= *(@-2) 80 IF! "
	mov	ax, [bp-2]
	cmp	ax, 80
	jl	L17
; {
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; RPN'ized expression: "y ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; }
L17:
; }
L16:
; }
L12:
; Fused expression:    "++p(2) *(@-6) "
	mov	ax, [bp-6]
	inc	word [bp-6]
	jmp	L11
L14:
; RPN'ized expression: "out_x *u x = "
; Expanded expression: "(@6) *(2) (@-2) *(2) =(2) "
; Fused expression:    "*(2) (@6) =(170) *ax *(@-2) "
	mov	ax, [bp+6]
	mov	bx, ax
	mov	ax, [bp-2]
	mov	[bx], ax
; RPN'ized expression: "out_y *u y = "
; Expanded expression: "(@8) *(2) (@-4) *(2) =(2) "
; Fused expression:    "*(2) (@8) =(170) *ax *(@-4) "
	mov	ax, [bp+8]
	mov	bx, ax
	mov	ax, [bp-4]
	mov	[bx], ax
L9:
	leave
	ret

; glb get_pos_from_xy : (
; prm     target_x : int
; prm     target_y : int
;     ) int
section .text
	global	_get_pos_from_xy
_get_pos_from_xy:
	push	bp
	mov	bp, sp
	 sub	sp,          6
; loc     target_x : (@4) : int
; loc     target_y : (@6) : int
; loc     x : (@-2) : int
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; loc     y : (@-4) : int
; RPN'ized expression: "y 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; loc     i : (@-6) : int
; for
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-6) 0 =(2) "
; Fused expression:    "=(170) *(@-6) 0 "
	mov	ax, 0
	mov	[bp-6], ax
L21:
; RPN'ized expression: "i text_len < "
; Expanded expression: "(@-6) *(2) text_len *(2) < "
; Fused expression:    "< *(@-6) *text_len IF! "
	mov	ax, [bp-6]
	cmp	ax, [_text_len]
	jge	L24
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-6) ++p(2) "
; {
; if
; RPN'ized expression: "y target_y == x target_x == && "
; Expanded expression: "(@-4) *(2) (@6) *(2) == [sh&&->27] (@-2) *(2) (@4) *(2) == &&[27] "
; Fused expression:    "== *(@-4) *(@6) [sh&&->27] == *(@-2) *(@4) &&[27]  "
	mov	ax, [bp-4]
	cmp	ax, [bp+6]
	sete	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L27
	mov	ax, [bp-2]
	cmp	ax, [bp+4]
	sete	al
	cbw
L27:
; JumpIfZero
	test	ax, ax
	je	L25
; {
; return
; RPN'ized expression: "i "
; Expanded expression: "(@-6) *(2) "
; Fused expression:    "*(2) (@-6)  "
	mov	ax, [bp-6]
	jmp	L19
; }
L25:
; if
; RPN'ized expression: "text_buffer i + *u 10 == "
; Expanded expression: "text_buffer (@-6) *(2) + *(-1) 10 == "
; Fused expression:    "+ text_buffer *(@-6) == *ax 10 IF! "
	mov	ax, _text_buffer
	add	ax, [bp-6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 10
	jne	L28
; {
; if
; RPN'ized expression: "y target_y == "
; Expanded expression: "(@-4) *(2) (@6) *(2) == "
; Fused expression:    "== *(@-4) *(@6) IF! "
	mov	ax, [bp-4]
	cmp	ax, [bp+6]
	jne	L30
; return
; RPN'ized expression: "i "
; Expanded expression: "(@-6) *(2) "
; Fused expression:    "*(2) (@-6)  "
	mov	ax, [bp-6]
	jmp	L19
L30:
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; RPN'ized expression: "y ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; }
	jmp	L29
L28:
; else
; {
; RPN'ized expression: "x ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; if
; RPN'ized expression: "x 80 >= "
; Expanded expression: "(@-2) *(2) 80 >= "
; Fused expression:    ">= *(@-2) 80 IF! "
	mov	ax, [bp-2]
	cmp	ax, 80
	jl	L32
; {
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; RPN'ized expression: "y ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; }
L32:
; }
L29:
; }
L22:
; Fused expression:    "++p(2) *(@-6) "
	mov	ax, [bp-6]
	inc	word [bp-6]
	jmp	L21
L24:
; return
; RPN'ized expression: "i "
; Expanded expression: "(@-6) *(2) "
; Fused expression:    "*(2) (@-6)  "
	mov	ax, [bp-6]
L19:
	leave
	ret

; glb draw_interface : () void
section .text
	global	_draw_interface
_draw_interface:
	push	bp
	mov	bp, sp
	 sub	sp,         12
; loc     x : (@-2) : int
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; loc     y : (@-4) : int
; RPN'ized expression: "y 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; loc     i : (@-6) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-6) 0 =(2) "
; Fused expression:    "=(170) *(@-6) 0 "
	mov	ax, 0
	mov	[bp-6], ax
; loc     cur_x : (@-8) : int
; RPN'ized expression: "cur_x 0 = "
; Expanded expression: "(@-8) 0 =(2) "
; Fused expression:    "=(170) *(@-8) 0 "
	mov	ax, 0
	mov	[bp-8], ax
; loc     cur_y : (@-10) : int
; RPN'ized expression: "cur_y 0 = "
; Expanded expression: "(@-10) 0 =(2) "
; Fused expression:    "=(170) *(@-10) 0 "
	mov	ax, 0
	mov	[bp-10], ax
; RPN'ized expression: "( 0 , 1 , 15 style ) "
; Expanded expression: " 0  1  15  style ()6 "
; Fused expression:    "( 0 , 1 , 15 , style )6 "
	push	0
	push	1
	push	15
	call	_style
	sub	sp, -6
; RPN'ized expression: "( 2 syscal ) "
; Expanded expression: " 2  syscal ()2 "
; Fused expression:    "( 2 , syscal )2 "
	push	2
	call	_syscal
	sub	sp, -2
; RPN'ized expression: "( 0 , 0 move_cursor ) "
; Expanded expression: " 0  0  move_cursor ()4 "
; Fused expression:    "( 0 , 0 , move_cursor )4 "
	push	0
	push	0
	call	_move_cursor
	sub	sp, -4
; for
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-6) 0 =(2) "
; Fused expression:    "=(170) *(@-6) 0 "
	mov	ax, 0
	mov	[bp-6], ax
L36:
; RPN'ized expression: "i text_len < "
; Expanded expression: "(@-6) *(2) text_len *(2) < "
; Fused expression:    "< *(@-6) *text_len IF! "
	mov	ax, [bp-6]
	cmp	ax, [_text_len]
	jge	L39
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-6) ++p(2) "
; {
; if
; RPN'ized expression: "text_buffer i + *u 10 == "
; Expanded expression: "text_buffer (@-6) *(2) + *(-1) 10 == "
; Fused expression:    "+ text_buffer *(@-6) == *ax 10 IF! "
	mov	ax, _text_buffer
	add	ax, [bp-6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 10
	jne	L40
; {
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; RPN'ized expression: "y ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; if
; RPN'ized expression: "y 25 1 - >= "
; Expanded expression: "(@-4) *(2) 24 >= "
; Fused expression:    ">= *(@-4) 24 IF! "
	mov	ax, [bp-4]
	cmp	ax, 24
	jl	L42
; break
	jmp	L39
L42:
; continue
	jmp	L37
; }
L40:
; RPN'ized expression: "( y , x move_cursor ) "
; Expanded expression: " (@-4) *(2)  (@-2) *(2)  move_cursor ()4 "
; Fused expression:    "( *(2) (@-4) , *(2) (@-2) , move_cursor )4 "
	push	word [bp-4]
	push	word [bp-2]
	call	_move_cursor
	sub	sp, -4
; RPN'ized expression: "( text_buffer i + *u putchar ) "
; Expanded expression: " text_buffer (@-6) *(2) + *(-1)  putchar ()2 "
; Fused expression:    "( + text_buffer *(@-6) *(-1) ax , putchar )2 "
	mov	ax, _text_buffer
	add	ax, [bp-6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	push	ax
	call	_putchar
	sub	sp, -2
; RPN'ized expression: "x ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; if
; RPN'ized expression: "x 80 >= "
; Expanded expression: "(@-2) *(2) 80 >= "
; Fused expression:    ">= *(@-2) 80 IF! "
	mov	ax, [bp-2]
	cmp	ax, 80
	jl	L44
; {
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; RPN'ized expression: "y ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; if
; RPN'ized expression: "y 25 1 - >= "
; Expanded expression: "(@-4) *(2) 24 >= "
; Fused expression:    ">= *(@-4) 24 IF! "
	mov	ax, [bp-4]
	cmp	ax, 24
	jl	L46
; break
	jmp	L39
L46:
; }
L44:
; }
L37:
; Fused expression:    "++p(2) *(@-6) "
	mov	ax, [bp-6]
	inc	word [bp-6]
	jmp	L36
L39:
; RPN'ized expression: "( 7 , 0 , 25 1 - clear_row ) "
; Expanded expression: " 7  0  24  clear_row ()6 "
; Fused expression:    "( 7 , 0 , 24 , clear_row )6 "
	push	7
	push	0
	push	24
	call	_clear_row
	sub	sp, -6
; RPN'ized expression: "( 25 1 - , 0 move_cursor ) "
; Expanded expression: " 24  0  move_cursor ()4 "
; Fused expression:    "( 24 , 0 , move_cursor )4 "
	push	24
	push	0
	call	_move_cursor
	sub	sp, -4
; RPN'ized expression: "( 0 , 7 , 0 style ) "
; Expanded expression: " 0  7  0  style ()6 "
; Fused expression:    "( 0 , 7 , 0 , style )6 "
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
; RPN'ized expression: "( L48 puts ) "
; Expanded expression: " L48  puts ()2 "
; Fused expression:    "( L48 , puts )2 "
	push	L48
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( current_filename puts ) "
; Expanded expression: " current_filename  puts ()2 "
; Fused expression:    "( current_filename , puts )2 "
	push	_current_filename
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 25 1 - , 28 move_cursor ) "
; Expanded expression: " 24  28  move_cursor ()4 "
; Fused expression:    "( 24 , 28 , move_cursor )4 "
	push	24
	push	28
	call	_move_cursor
	sub	sp, -4
; if
; RPN'ized expression: "menu_active "
; Expanded expression: "menu_active *(2) "
; Fused expression:    "*(2) menu_active  "
	mov	ax, [_menu_active]
; JumpIfZero
	test	ax, ax
	je	L49
; {
; RPN'ized expression: "( 0 , 4 , 15 style ) "
; Expanded expression: " 0  4  15  style ()6 "
; Fused expression:    "( 0 , 4 , 15 , style )6 "
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
; RPN'ized expression: "( L51 puts ) "
; Expanded expression: " L51  puts ()2 "
; Fused expression:    "( L51 , puts )2 "
	push	L51
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 0 , 0 , 15 style ) "
; Expanded expression: " 0  0  15  style ()6 "
; Fused expression:    "( 0 , 0 , 15 , style )6 "
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
; RPN'ized expression: "( L52 puts ) "
; Expanded expression: " L52  puts ()2 "
; Fused expression:    "( L52 , puts )2 "
	push	L52
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 0 , 7 , 0 style ) "
; Expanded expression: " 0  7  0  style ()6 "
; Fused expression:    "( 0 , 7 , 0 , style )6 "
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
; RPN'ized expression: "( L53 puts ) "
; Expanded expression: " L53  puts ()2 "
; Fused expression:    "( L53 , puts )2 "
	push	L53
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 0 , 0 , 15 style ) "
; Expanded expression: " 0  0  15  style ()6 "
; Fused expression:    "( 0 , 0 , 15 , style )6 "
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
; RPN'ized expression: "( L54 puts ) "
; Expanded expression: " L54  puts ()2 "
; Fused expression:    "( L54 , puts )2 "
	push	L54
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 0 , 7 , 0 style ) "
; Expanded expression: " 0  7  0  style ()6 "
; Fused expression:    "( 0 , 7 , 0 , style )6 "
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
; RPN'ized expression: "( L55 puts ) "
; Expanded expression: " L55  puts ()2 "
; Fused expression:    "( L55 , puts )2 "
	push	L55
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 0 , 0 , 15 style ) "
; Expanded expression: " 0  0  15  style ()6 "
; Fused expression:    "( 0 , 0 , 15 , style )6 "
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
; RPN'ized expression: "( L56 puts ) "
; Expanded expression: " L56  puts ()2 "
; Fused expression:    "( L56 , puts )2 "
	push	L56
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 0 , 7 , 0 style ) "
; Expanded expression: " 0  7  0  style ()6 "
; Fused expression:    "( 0 , 7 , 0 , style )6 "
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
; RPN'ized expression: "( L57 puts ) "
; Expanded expression: " L57  puts ()2 "
; Fused expression:    "( L57 , puts )2 "
	push	L57
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 0 , 0 , 15 style ) "
; Expanded expression: " 0  0  15  style ()6 "
; Fused expression:    "( 0 , 0 , 15 , style )6 "
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
; RPN'ized expression: "( L58 puts ) "
; Expanded expression: " L58  puts ()2 "
; Fused expression:    "( L58 , puts )2 "
	push	L58
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 0 , 7 , 0 style ) "
; Expanded expression: " 0  7  0  style ()6 "
; Fused expression:    "( 0 , 7 , 0 , style )6 "
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
; RPN'ized expression: "( L59 puts ) "
; Expanded expression: " L59  puts ()2 "
; Fused expression:    "( L59 , puts )2 "
	push	L59
	call	_puts
	sub	sp, -2
; }
	jmp	L50
L49:
; else
; {
; RPN'ized expression: "( 0 , 0 , 15 style ) "
; Expanded expression: " 0  0  15  style ()6 "
; Fused expression:    "( 0 , 0 , 15 , style )6 "
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
; RPN'ized expression: "( L60 puts ) "
; Expanded expression: " L60  puts ()2 "
; Fused expression:    "( L60 , puts )2 "
	push	L60
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 0 , 7 , 0 style ) "
; Expanded expression: " 0  7  0  style ()6 "
; Fused expression:    "( 0 , 7 , 0 , style )6 "
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
; RPN'ized expression: "( L61 puts ) "
; Expanded expression: " L61  puts ()2 "
; Fused expression:    "( L61 , puts )2 "
	push	L61
	call	_puts
	sub	sp, -2
; }
L50:
; RPN'ized expression: "( cur_y &u , cur_x &u , buffer_pos get_xy_from_pos ) "
; Expanded expression: " (@-10)  (@-8)  buffer_pos *(2)  get_xy_from_pos ()6 "
; Fused expression:    "( (@-10) , (@-8) , *(2) buffer_pos , get_xy_from_pos )6 "
	lea	ax, [bp-10]
	push	ax
	lea	ax, [bp-8]
	push	ax
	push	word [_buffer_pos]
	call	_get_xy_from_pos
	sub	sp, -6
; RPN'ized expression: "( 0 , 1 , 15 style ) "
; Expanded expression: " 0  1  15  style ()6 "
; Fused expression:    "( 0 , 1 , 15 , style )6 "
	push	0
	push	1
	push	15
	call	_style
	sub	sp, -6
; RPN'ized expression: "( cur_y , cur_x move_cursor ) "
; Expanded expression: " (@-10) *(2)  (@-8) *(2)  move_cursor ()4 "
; Fused expression:    "( *(2) (@-10) , *(2) (@-8) , move_cursor )4 "
	push	word [bp-10]
	push	word [bp-8]
	call	_move_cursor
	sub	sp, -4
; loc     val : (@-12) : char
; RPN'ized expression: "val text_buffer buffer_pos + *u = "
; Expanded expression: "(@-12) text_buffer buffer_pos *(2) + *(-1) =(-1) "
; Fused expression:    "+ text_buffer *buffer_pos =(167) *(@-12) *ax "
	mov	ax, _text_buffer
	add	ax, [_buffer_pos]
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-12], ax
; if
; RPN'ized expression: "val 10 == "
; Expanded expression: "(@-12) *(-1) 10 == "
; Fused expression:    "== *(@-12) 10 IF! "
	mov	al, [bp-12]
	cbw
	cmp	ax, 10
	jne	L62
; RPN'ized expression: "( 32 putchar ) "
; Expanded expression: " 32  putchar ()2 "
; Fused expression:    "( 32 , putchar )2 "
	push	32
	call	_putchar
	sub	sp, -2
	jmp	L63
L62:
; else
; RPN'ized expression: "( val putchar ) "
; Expanded expression: " (@-12) *(-1)  putchar ()2 "
; Fused expression:    "( *(-1) (@-12) , putchar )2 "
	mov	al, [bp-12]
	cbw
	push	ax
	call	_putchar
	sub	sp, -2
L63:
; RPN'ized expression: "( 8 putchar ) "
; Expanded expression: " 8  putchar ()2 "
; Fused expression:    "( 8 , putchar )2 "
	push	8
	call	_putchar
	sub	sp, -2
L34:
	leave
	ret

; glb save_file : () void
section .text
	global	_save_file
_save_file:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; RPN'ized expression: "( current_filename , 43 syscal ) "
; Expanded expression: " current_filename  43  syscal ()4 "
; Fused expression:    "( current_filename , 43 , syscal )4 "
	push	_current_filename
	push	43
	call	_syscal
	sub	sp, -4
; loc     fd : (@-2) : int
; RPN'ized expression: "fd ( 5 , current_filename , 45 syscal ) = "
; Expanded expression: "(@-2)  5  current_filename  45  syscal ()6 =(2) "
; Fused expression:    "( 5 , current_filename , 45 , syscal )6 =(170) *(@-2) ax "
	push	5
	push	_current_filename
	push	45
	call	_syscal
	sub	sp, -6
	mov	[bp-2], ax
; if
; RPN'ized expression: "fd 0 < "
; Expanded expression: "(@-2) *(2) 0 < "
; Fused expression:    "< *(@-2) 0 IF! "
	mov	ax, [bp-2]
	cmp	ax, 0
	jge	L66
; {
; RPN'ized expression: "( 4 , 15 , 25 1 - clear_row ) "
; Expanded expression: " 4  15  24  clear_row ()6 "
; Fused expression:    "( 4 , 15 , 24 , clear_row )6 "
	push	4
	push	15
	push	24
	call	_clear_row
	sub	sp, -6
; RPN'ized expression: "( 25 1 - , 0 move_cursor ) "
; Expanded expression: " 24  0  move_cursor ()4 "
; Fused expression:    "( 24 , 0 , move_cursor )4 "
	push	24
	push	0
	call	_move_cursor
	sub	sp, -4

section .rodata
L68:
	db	" IO Error: Unable to open filesystem block!"
	times	1 db 0

section .text
; RPN'ized expression: "( L68 puts ) "
; Expanded expression: " L68  puts ()2 "
; Fused expression:    "( L68 , puts )2 "
	push	L68
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 30 , 20 syscal ) "
; Expanded expression: " 30  20  syscal ()4 "
; Fused expression:    "( 30 , 20 , syscal )4 "
	push	30
	push	20
	call	_syscal
	sub	sp, -4
; return
	jmp	L64
; }
L66:
; if
; RPN'ized expression: "text_len 0 > "
; Expanded expression: "text_len *(2) 0 > "
; Fused expression:    "> *text_len 0 IF! "
	mov	ax, [_text_len]
	cmp	ax, 0
	jle	L69
; {
; RPN'ized expression: "( text_len , text_buffer , fd , 48 syscal ) "
; Expanded expression: " text_len *(2)  text_buffer  (@-2) *(2)  48  syscal ()8 "
; Fused expression:    "( *(2) text_len , text_buffer , *(2) (@-2) , 48 , syscal )8 "
	push	word [_text_len]
	push	_text_buffer
	push	word [bp-2]
	push	48
	call	_syscal
	sub	sp, -8
; }
L69:
; RPN'ized expression: "( fd , 46 syscal ) "
; Expanded expression: " (@-2) *(2)  46  syscal ()4 "
; Fused expression:    "( *(2) (@-2) , 46 , syscal )4 "
	push	word [bp-2]
	push	46
	call	_syscal
	sub	sp, -4
; RPN'ized expression: "( 2 , 0 , 25 1 - clear_row ) "
; Expanded expression: " 2  0  24  clear_row ()6 "
; Fused expression:    "( 2 , 0 , 24 , clear_row )6 "
	push	2
	push	0
	push	24
	call	_clear_row
	sub	sp, -6
; RPN'ized expression: "( 25 1 - , 0 move_cursor ) "
; Expanded expression: " 24  0  move_cursor ()4 "
; Fused expression:    "( 24 , 0 , move_cursor )4 "
	push	24
	push	0
	call	_move_cursor
	sub	sp, -4

section .rodata
L71:
	db	" File saved successfully to storage device."
	times	1 db 0

section .text
; RPN'ized expression: "( L71 puts ) "
; Expanded expression: " L71  puts ()2 "
; Fused expression:    "( L71 , puts )2 "
	push	L71
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 15 , 20 syscal ) "
; Expanded expression: " 15  20  syscal ()4 "
; Fused expression:    "( 15 , 20 , syscal )4 "
	push	15
	push	20
	call	_syscal
	sub	sp, -4
L64:
	leave
	ret

; glb load_file : () void
section .text
	global	_load_file
_load_file:
	push	bp
	mov	bp, sp
	 sub	sp,          4
; loc     fd : (@-2) : int
; RPN'ized expression: "fd ( 2 , current_filename , 45 syscal ) = "
; Expanded expression: "(@-2)  2  current_filename  45  syscal ()6 =(2) "
; Fused expression:    "( 2 , current_filename , 45 , syscal )6 =(170) *(@-2) ax "
	push	2
	push	_current_filename
	push	45
	call	_syscal
	sub	sp, -6
	mov	[bp-2], ax
; if
; RPN'ized expression: "fd 0 < "
; Expanded expression: "(@-2) *(2) 0 < "
; Fused expression:    "< *(@-2) 0 IF! "
	mov	ax, [bp-2]
	cmp	ax, 0
	jge	L74
; {
; RPN'ized expression: "text_len 0 = "
; Expanded expression: "text_len 0 =(2) "
; Fused expression:    "=(170) *text_len 0 "
	mov	ax, 0
	mov	[_text_len], ax
; RPN'ized expression: "text_buffer 0 + *u 0 = "
; Expanded expression: "text_buffer 0 + 0 =(-1) "
; Fused expression:    "+ text_buffer 0 =(122) *ax 0 "
	mov	ax, _text_buffer
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; RPN'ized expression: "buffer_pos 0 = "
; Expanded expression: "buffer_pos 0 =(2) "
; Fused expression:    "=(170) *buffer_pos 0 "
	mov	ax, 0
	mov	[_buffer_pos], ax
; return
	jmp	L72
; }
L74:
; loc     size : (@-4) : int
; RPN'ized expression: "size ( fd , 51 syscal ) = "
; Expanded expression: "(@-4)  (@-2) *(2)  51  syscal ()4 =(2) "
; Fused expression:    "( *(2) (@-2) , 51 , syscal )4 =(170) *(@-4) ax "
	push	word [bp-2]
	push	51
	call	_syscal
	sub	sp, -4
	mov	[bp-4], ax
; if
; RPN'ized expression: "size 4097 1 - > "
; Expanded expression: "(@-4) *(2) 4096 > "
; Fused expression:    "> *(@-4) 4096 IF! "
	mov	ax, [bp-4]
	cmp	ax, 4096
	jle	L76
; RPN'ized expression: "size 4097 1 - = "
; Expanded expression: "(@-4) 4096 =(2) "
; Fused expression:    "=(170) *(@-4) 4096 "
	mov	ax, 4096
	mov	[bp-4], ax
L76:
; if
; RPN'ized expression: "size 0 > "
; Expanded expression: "(@-4) *(2) 0 > "
; Fused expression:    "> *(@-4) 0 IF! "
	mov	ax, [bp-4]
	cmp	ax, 0
	jle	L78
; {
; RPN'ized expression: "( size , text_buffer , fd , 47 syscal ) "
; Expanded expression: " (@-4) *(2)  text_buffer  (@-2) *(2)  47  syscal ()8 "
; Fused expression:    "( *(2) (@-4) , text_buffer , *(2) (@-2) , 47 , syscal )8 "
	push	word [bp-4]
	push	_text_buffer
	push	word [bp-2]
	push	47
	call	_syscal
	sub	sp, -8
; RPN'ized expression: "text_len size = "
; Expanded expression: "text_len (@-4) *(2) =(2) "
; Fused expression:    "=(170) *text_len *(@-4) "
	mov	ax, [bp-4]
	mov	[_text_len], ax
; RPN'ized expression: "text_buffer text_len + *u 0 = "
; Expanded expression: "text_buffer text_len *(2) + 0 =(-1) "
; Fused expression:    "+ text_buffer *text_len =(122) *ax 0 "
	mov	ax, _text_buffer
	add	ax, [_text_len]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; }
	jmp	L79
L78:
; else
; {
; RPN'ized expression: "text_len 0 = "
; Expanded expression: "text_len 0 =(2) "
; Fused expression:    "=(170) *text_len 0 "
	mov	ax, 0
	mov	[_text_len], ax
; }
L79:
; RPN'ized expression: "( fd , 46 syscal ) "
; Expanded expression: " (@-2) *(2)  46  syscal ()4 "
; Fused expression:    "( *(2) (@-2) , 46 , syscal )4 "
	push	word [bp-2]
	push	46
	call	_syscal
	sub	sp, -4
; RPN'ized expression: "buffer_pos 0 = "
; Expanded expression: "buffer_pos 0 =(2) "
; Fused expression:    "=(170) *buffer_pos 0 "
	mov	ax, 0
	mov	[_buffer_pos], ax
L72:
	leave
	ret

; glb strncpy : (
; prm     s1 : * char
; prm     s2 : * char
; prm     n : int
;     ) void
section .text
	global	_strncpy
_strncpy:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     s1 : (@4) : * char
; loc     s2 : (@6) : * char
; loc     n : (@8) : int
; while
; RPN'ized expression: "n --p "
; Expanded expression: "(@8) --p(2) "
L82:
; Fused expression:    "--p(2) *(@8)  "
	mov	ax, [bp+8]
	dec	word [bp+8]
; JumpIfZero
	test	ax, ax
	je	L83
; {
; if
; RPN'ized expression: "s2 *u 0 == "
; Expanded expression: "(@6) *(2) *(-1) 0 == "
; Fused expression:    "*(2) (@6) == *ax 0 IF! "
	mov	ax, [bp+6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 0
	jne	L84
; break
	jmp	L83
L84:
; RPN'ized expression: "s1 ++p *u s2 ++p *u = "
; Expanded expression: "(@4) ++p(2) (@6) ++p(2) *(-1) =(-1) "
; Fused expression:    "++p(2) *(@4) push-ax ++p(2) *(@6) =(119) **sp *ax "
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
; }
	jmp	L82
L83:
; RPN'ized expression: "s1 *u 0 = "
; Expanded expression: "(@4) *(2) 0 =(-1) "
; Fused expression:    "*(2) (@4) =(122) *ax 0 "
	mov	ax, [bp+4]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
L80:
	leave
	ret

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
	 sub	sp,         10
; loc     args : (@4) : * [32u] char
; loc     running : (@-2) : int
; RPN'ized expression: "running 1 = "
; Expanded expression: "(@-2) 1 =(2) "
; Fused expression:    "=(170) *(@-2) 1 "
	mov	ax, 1
	mov	[bp-2], ax
; loc     i : (@-4) : int
; loc     cx : (@-6) : int
; loc     cy : (@-8) : int
; RPN'ized expression: "( 0 , 0 , 15 style ) "
; Expanded expression: " 0  0  15  style ()6 "
; Fused expression:    "( 0 , 0 , 15 , style )6 "
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6
; RPN'ized expression: "( 2 syscal ) "
; Expanded expression: " 2  syscal ()2 "
; Fused expression:    "( 2 , syscal )2 "
	push	2
	call	_syscal
	sub	sp, -2
; if
; RPN'ized expression: "args 1 + *u 0 + *u 0 != "
; Expanded expression: "(@4) *(2) 32 + *(-1) 0 != "
; Fused expression:    "+ *(@4) 32 != *ax 0 IF! "
	mov	ax, [bp+4]
	add	ax, 32
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 0
	je	L88
; {
; RPN'ized expression: "( 30 , args 1 + *u , current_filename strncpy ) "
; Expanded expression: " 30  (@4) *(2) 32 +  current_filename  strncpy ()6 "
; Fused expression:    "( 30 , + *(@4) 32 , current_filename , strncpy )6 "
	push	30
	mov	ax, [bp+4]
	add	ax, 32
	push	ax
	push	_current_filename
	call	_strncpy
	sub	sp, -6
; }
	jmp	L89
L88:
; else
; {

section .rodata
L90:
	db	"++EDIT++",10
	times	1 db 0

section .text
; RPN'ized expression: "( L90 puts ) "
; Expanded expression: " L90  puts ()2 "
; Fused expression:    "( L90 , puts )2 "
	push	L90
	call	_puts
	sub	sp, -2

section .rodata
L91:
	db	"File to open/create: "
	times	1 db 0

section .text
; RPN'ized expression: "( L91 puts ) "
; Expanded expression: " L91  puts ()2 "
; Fused expression:    "( L91 , puts )2 "
	push	L91
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( current_filename gets ) "
; Expanded expression: " current_filename  gets ()2 "
; Fused expression:    "( current_filename , gets )2 "
	push	_current_filename
	call	_gets
	sub	sp, -2
; }
L89:
; RPN'ized expression: "( load_file ) "
; Expanded expression: " load_file ()0 "
; Fused expression:    "( load_file )0 "
	call	_load_file
; while
; RPN'ized expression: "running "
; Expanded expression: "(@-2) *(2) "
L92:
; Fused expression:    "*(2) (@-2)  "
	mov	ax, [bp-2]
; JumpIfZero
	test	ax, ax
	je	L93
; {
; RPN'ized expression: "( draw_interface ) "
; Expanded expression: " draw_interface ()0 "
; Fused expression:    "( draw_interface )0 "
	call	_draw_interface
; loc         key : (@-10) : int
; RPN'ized expression: "key ( 8 syscal ) = "
; Expanded expression: "(@-10)  8  syscal ()2 =(2) "
; Fused expression:    "( 8 , syscal )2 =(170) *(@-10) ax "
	push	8
	call	_syscal
	sub	sp, -2
	mov	[bp-10], ax
; if
; RPN'ized expression: "menu_active "
; Expanded expression: "menu_active *(2) "
; Fused expression:    "*(2) menu_active  "
	mov	ax, [_menu_active]
; JumpIfZero
	test	ax, ax
	je	L94
; {
; if
; RPN'ized expression: "key 27 == "
; Expanded expression: "(@-10) *(2) 27 == "
; Fused expression:    "== *(@-10) 27 IF! "
	mov	ax, [bp-10]
	cmp	ax, 27
	jne	L96
; {
; RPN'ized expression: "menu_active 0 = "
; Expanded expression: "menu_active 0 =(2) "
; Fused expression:    "=(170) *menu_active 0 "
	mov	ax, 0
	mov	[_menu_active], ax
; }
	jmp	L97
L96:
; else
; if
; RPN'ized expression: "key 104 == key 72 == || "
; Expanded expression: "(@-10) *(2) 104 == [sh||->100] (@-10) *(2) 72 == ||[100] "
; Fused expression:    "== *(@-10) 104 [sh||->100] == *(@-10) 72 ||[100]  "
	mov	ax, [bp-10]
	cmp	ax, 104
	sete	al
	cbw
; JumpIfNotZero
	test	ax, ax
	jne	L100
	mov	ax, [bp-10]
	cmp	ax, 72
	sete	al
	cbw
L100:
; JumpIfZero
	test	ax, ax
	je	L98
; {
; if
; RPN'ized expression: "buffer_pos 0 > "
; Expanded expression: "buffer_pos *(2) 0 > "
; Fused expression:    "> *buffer_pos 0 IF! "
	mov	ax, [_buffer_pos]
	cmp	ax, 0
	jle	L101
; RPN'ized expression: "buffer_pos --p "
; Expanded expression: "buffer_pos --p(2) "
; Fused expression:    "--p(2) *buffer_pos "
	mov	ax, [_buffer_pos]
	dec	word [_buffer_pos]
L101:
; }
	jmp	L99
L98:
; else
; if
; RPN'ized expression: "key 108 == key 76 == || "
; Expanded expression: "(@-10) *(2) 108 == [sh||->105] (@-10) *(2) 76 == ||[105] "
; Fused expression:    "== *(@-10) 108 [sh||->105] == *(@-10) 76 ||[105]  "
	mov	ax, [bp-10]
	cmp	ax, 108
	sete	al
	cbw
; JumpIfNotZero
	test	ax, ax
	jne	L105
	mov	ax, [bp-10]
	cmp	ax, 76
	sete	al
	cbw
L105:
; JumpIfZero
	test	ax, ax
	je	L103
; {
; if
; RPN'ized expression: "buffer_pos text_len < "
; Expanded expression: "buffer_pos *(2) text_len *(2) < "
; Fused expression:    "< *buffer_pos *text_len IF! "
	mov	ax, [_buffer_pos]
	cmp	ax, [_text_len]
	jge	L106
; RPN'ized expression: "buffer_pos ++p "
; Expanded expression: "buffer_pos ++p(2) "
; Fused expression:    "++p(2) *buffer_pos "
	mov	ax, [_buffer_pos]
	inc	word [_buffer_pos]
L106:
; }
	jmp	L104
L103:
; else
; if
; RPN'ized expression: "key 106 == key 74 == || "
; Expanded expression: "(@-10) *(2) 106 == [sh||->110] (@-10) *(2) 74 == ||[110] "
; Fused expression:    "== *(@-10) 106 [sh||->110] == *(@-10) 74 ||[110]  "
	mov	ax, [bp-10]
	cmp	ax, 106
	sete	al
	cbw
; JumpIfNotZero
	test	ax, ax
	jne	L110
	mov	ax, [bp-10]
	cmp	ax, 74
	sete	al
	cbw
L110:
; JumpIfZero
	test	ax, ax
	je	L108
; {
; RPN'ized expression: "( cy &u , cx &u , buffer_pos get_xy_from_pos ) "
; Expanded expression: " (@-8)  (@-6)  buffer_pos *(2)  get_xy_from_pos ()6 "
; Fused expression:    "( (@-8) , (@-6) , *(2) buffer_pos , get_xy_from_pos )6 "
	lea	ax, [bp-8]
	push	ax
	lea	ax, [bp-6]
	push	ax
	push	word [_buffer_pos]
	call	_get_xy_from_pos
	sub	sp, -6
; if
; RPN'ized expression: "cy 25 2 - < "
; Expanded expression: "(@-8) *(2) 23 < "
; Fused expression:    "< *(@-8) 23 IF! "
	mov	ax, [bp-8]
	cmp	ax, 23
	jge	L111
; {
; RPN'ized expression: "buffer_pos ( cy 1 + , cx get_pos_from_xy ) = "
; Expanded expression: "buffer_pos  (@-8) *(2) 1 +  (@-6) *(2)  get_pos_from_xy ()4 =(2) "
; Fused expression:    "( + *(@-8) 1 , *(2) (@-6) , get_pos_from_xy )4 =(170) *buffer_pos ax "
	mov	ax, [bp-8]
	inc	ax
	push	ax
	push	word [bp-6]
	call	_get_pos_from_xy
	sub	sp, -4
	mov	[_buffer_pos], ax
; }
L111:
; }
	jmp	L109
L108:
; else
; if
; RPN'ized expression: "key 107 == key 75 == || "
; Expanded expression: "(@-10) *(2) 107 == [sh||->115] (@-10) *(2) 75 == ||[115] "
; Fused expression:    "== *(@-10) 107 [sh||->115] == *(@-10) 75 ||[115]  "
	mov	ax, [bp-10]
	cmp	ax, 107
	sete	al
	cbw
; JumpIfNotZero
	test	ax, ax
	jne	L115
	mov	ax, [bp-10]
	cmp	ax, 75
	sete	al
	cbw
L115:
; JumpIfZero
	test	ax, ax
	je	L113
; {
; RPN'ized expression: "( cy &u , cx &u , buffer_pos get_xy_from_pos ) "
; Expanded expression: " (@-8)  (@-6)  buffer_pos *(2)  get_xy_from_pos ()6 "
; Fused expression:    "( (@-8) , (@-6) , *(2) buffer_pos , get_xy_from_pos )6 "
	lea	ax, [bp-8]
	push	ax
	lea	ax, [bp-6]
	push	ax
	push	word [_buffer_pos]
	call	_get_xy_from_pos
	sub	sp, -6
; if
; RPN'ized expression: "cy 0 > "
; Expanded expression: "(@-8) *(2) 0 > "
; Fused expression:    "> *(@-8) 0 IF! "
	mov	ax, [bp-8]
	cmp	ax, 0
	jle	L116
; {
; RPN'ized expression: "buffer_pos ( cy 1 - , cx get_pos_from_xy ) = "
; Expanded expression: "buffer_pos  (@-8) *(2) 1 -  (@-6) *(2)  get_pos_from_xy ()4 =(2) "
; Fused expression:    "( - *(@-8) 1 , *(2) (@-6) , get_pos_from_xy )4 =(170) *buffer_pos ax "
	mov	ax, [bp-8]
	dec	ax
	push	ax
	push	word [bp-6]
	call	_get_pos_from_xy
	sub	sp, -4
	mov	[_buffer_pos], ax
; }
L116:
; }
	jmp	L114
L113:
; else
; if
; RPN'ized expression: "key 115 == key 83 == || "
; Expanded expression: "(@-10) *(2) 115 == [sh||->120] (@-10) *(2) 83 == ||[120] "
; Fused expression:    "== *(@-10) 115 [sh||->120] == *(@-10) 83 ||[120]  "
	mov	ax, [bp-10]
	cmp	ax, 115
	sete	al
	cbw
; JumpIfNotZero
	test	ax, ax
	jne	L120
	mov	ax, [bp-10]
	cmp	ax, 83
	sete	al
	cbw
L120:
; JumpIfZero
	test	ax, ax
	je	L118
; {
; RPN'ized expression: "( save_file ) "
; Expanded expression: " save_file ()0 "
; Fused expression:    "( save_file )0 "
	call	_save_file
; RPN'ized expression: "menu_active 0 = "
; Expanded expression: "menu_active 0 =(2) "
; Fused expression:    "=(170) *menu_active 0 "
	mov	ax, 0
	mov	[_menu_active], ax
; }
	jmp	L119
L118:
; else
; if
; RPN'ized expression: "key 113 == key 81 == || "
; Expanded expression: "(@-10) *(2) 113 == [sh||->123] (@-10) *(2) 81 == ||[123] "
; Fused expression:    "== *(@-10) 113 [sh||->123] == *(@-10) 81 ||[123]  "
	mov	ax, [bp-10]
	cmp	ax, 113
	sete	al
	cbw
; JumpIfNotZero
	test	ax, ax
	jne	L123
	mov	ax, [bp-10]
	cmp	ax, 81
	sete	al
	cbw
L123:
; JumpIfZero
	test	ax, ax
	je	L121
; {
; RPN'ized expression: "running 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; }
L121:
L119:
L114:
L109:
L104:
L99:
L97:
; }
	jmp	L95
L94:
; else
; {
; if
; RPN'ized expression: "key 27 == "
; Expanded expression: "(@-10) *(2) 27 == "
; Fused expression:    "== *(@-10) 27 IF! "
	mov	ax, [bp-10]
	cmp	ax, 27
	jne	L124
; {
; RPN'ized expression: "menu_active 1 = "
; Expanded expression: "menu_active 1 =(2) "
; Fused expression:    "=(170) *menu_active 1 "
	mov	ax, 1
	mov	[_menu_active], ax
; }
	jmp	L125
L124:
; else
; if
; RPN'ized expression: "key 8 == key 127 == || "
; Expanded expression: "(@-10) *(2) 8 == [sh||->128] (@-10) *(2) 127 == ||[128] "
; Fused expression:    "== *(@-10) 8 [sh||->128] == *(@-10) 127 ||[128]  "
	mov	ax, [bp-10]
	cmp	ax, 8
	sete	al
	cbw
; JumpIfNotZero
	test	ax, ax
	jne	L128
	mov	ax, [bp-10]
	cmp	ax, 127
	sete	al
	cbw
L128:
; JumpIfZero
	test	ax, ax
	je	L126
; {
; if
; RPN'ized expression: "buffer_pos 0 > "
; Expanded expression: "buffer_pos *(2) 0 > "
; Fused expression:    "> *buffer_pos 0 IF! "
	mov	ax, [_buffer_pos]
	cmp	ax, 0
	jle	L129
; {
; for
; RPN'ized expression: "i buffer_pos 1 - = "
; Expanded expression: "(@-4) buffer_pos *(2) 1 - =(2) "
; Fused expression:    "- *buffer_pos 1 =(170) *(@-4) ax "
	mov	ax, [_buffer_pos]
	dec	ax
	mov	[bp-4], ax
L131:
; RPN'ized expression: "i text_len 1 - < "
; Expanded expression: "(@-4) *(2) text_len *(2) 1 - < "
; Fused expression:    "- *text_len 1 < *(@-4) ax IF! "
	mov	ax, [_text_len]
	dec	ax
	mov	cx, ax
	mov	ax, [bp-4]
	cmp	ax, cx
	jge	L134
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-4) ++p(2) "
; {
; RPN'ized expression: "text_buffer i + *u text_buffer i 1 + + *u = "
; Expanded expression: "text_buffer (@-4) *(2) + text_buffer (@-4) *(2) 1 + + *(-1) =(-1) "
; Fused expression:    "+ text_buffer *(@-4) push-ax + *(@-4) 1 + text_buffer ax =(119) **sp *ax "
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
; }
L132:
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
	jmp	L131
L134:
; RPN'ized expression: "buffer_pos --p "
; Expanded expression: "buffer_pos --p(2) "
; Fused expression:    "--p(2) *buffer_pos "
	mov	ax, [_buffer_pos]
	dec	word [_buffer_pos]
; RPN'ized expression: "text_len --p "
; Expanded expression: "text_len --p(2) "
; Fused expression:    "--p(2) *text_len "
	mov	ax, [_text_len]
	dec	word [_text_len]
; RPN'ized expression: "text_buffer text_len + *u 0 = "
; Expanded expression: "text_buffer text_len *(2) + 0 =(-1) "
; Fused expression:    "+ text_buffer *text_len =(122) *ax 0 "
	mov	ax, _text_buffer
	add	ax, [_text_len]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; }
L129:
; }
	jmp	L127
L126:
; else
; if
; RPN'ized expression: "key 13 == key 10 == || "
; Expanded expression: "(@-10) *(2) 13 == [sh||->137] (@-10) *(2) 10 == ||[137] "
; Fused expression:    "== *(@-10) 13 [sh||->137] == *(@-10) 10 ||[137]  "
	mov	ax, [bp-10]
	cmp	ax, 13
	sete	al
	cbw
; JumpIfNotZero
	test	ax, ax
	jne	L137
	mov	ax, [bp-10]
	cmp	ax, 10
	sete	al
	cbw
L137:
; JumpIfZero
	test	ax, ax
	je	L135
; {
; if
; RPN'ized expression: "text_len 4097 2 - < "
; Expanded expression: "text_len *(2) 4095 < "
; Fused expression:    "< *text_len 4095 IF! "
	mov	ax, [_text_len]
	cmp	ax, 4095
	jge	L138
; {
; for
; RPN'ized expression: "i text_len = "
; Expanded expression: "(@-4) text_len *(2) =(2) "
; Fused expression:    "=(170) *(@-4) *text_len "
	mov	ax, [_text_len]
	mov	[bp-4], ax
L140:
; RPN'ized expression: "i buffer_pos > "
; Expanded expression: "(@-4) *(2) buffer_pos *(2) > "
; Fused expression:    "> *(@-4) *buffer_pos IF! "
	mov	ax, [bp-4]
	cmp	ax, [_buffer_pos]
	jle	L143
; RPN'ized expression: "i --p "
; Expanded expression: "(@-4) --p(2) "
; {
; RPN'ized expression: "text_buffer i + *u text_buffer i 1 - + *u = "
; Expanded expression: "text_buffer (@-4) *(2) + text_buffer (@-4) *(2) 1 - + *(-1) =(-1) "
; Fused expression:    "+ text_buffer *(@-4) push-ax - *(@-4) 1 + text_buffer ax =(119) **sp *ax "
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
; }
L141:
; Fused expression:    "--p(2) *(@-4) "
	mov	ax, [bp-4]
	dec	word [bp-4]
	jmp	L140
L143:
; RPN'ized expression: "text_buffer buffer_pos + *u 10 = "
; Expanded expression: "text_buffer buffer_pos *(2) + 10 =(-1) "
; Fused expression:    "+ text_buffer *buffer_pos =(122) *ax 10 "
	mov	ax, _text_buffer
	add	ax, [_buffer_pos]
	mov	bx, ax
	mov	ax, 10
	mov	[bx], al
	cbw
; RPN'ized expression: "buffer_pos ++p "
; Expanded expression: "buffer_pos ++p(2) "
; Fused expression:    "++p(2) *buffer_pos "
	mov	ax, [_buffer_pos]
	inc	word [_buffer_pos]
; RPN'ized expression: "text_len ++p "
; Expanded expression: "text_len ++p(2) "
; Fused expression:    "++p(2) *text_len "
	mov	ax, [_text_len]
	inc	word [_text_len]
; RPN'ized expression: "text_buffer text_len + *u 0 = "
; Expanded expression: "text_buffer text_len *(2) + 0 =(-1) "
; Fused expression:    "+ text_buffer *text_len =(122) *ax 0 "
	mov	ax, _text_buffer
	add	ax, [_text_len]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; }
L138:
; }
	jmp	L136
L135:
; else
; if
; RPN'ized expression: "key 32 >= key 126 <= && "
; Expanded expression: "(@-10) *(2) 32 >= [sh&&->146] (@-10) *(2) 126 <= &&[146] "
; Fused expression:    ">= *(@-10) 32 [sh&&->146] <= *(@-10) 126 &&[146]  "
	mov	ax, [bp-10]
	cmp	ax, 32
	setge	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L146
	mov	ax, [bp-10]
	cmp	ax, 126
	setle	al
	cbw
L146:
; JumpIfZero
	test	ax, ax
	je	L144
; {
; if
; RPN'ized expression: "text_len 4097 2 - < "
; Expanded expression: "text_len *(2) 4095 < "
; Fused expression:    "< *text_len 4095 IF! "
	mov	ax, [_text_len]
	cmp	ax, 4095
	jge	L147
; {
; for
; RPN'ized expression: "i text_len = "
; Expanded expression: "(@-4) text_len *(2) =(2) "
; Fused expression:    "=(170) *(@-4) *text_len "
	mov	ax, [_text_len]
	mov	[bp-4], ax
L149:
; RPN'ized expression: "i buffer_pos > "
; Expanded expression: "(@-4) *(2) buffer_pos *(2) > "
; Fused expression:    "> *(@-4) *buffer_pos IF! "
	mov	ax, [bp-4]
	cmp	ax, [_buffer_pos]
	jle	L152
; RPN'ized expression: "i --p "
; Expanded expression: "(@-4) --p(2) "
; {
; RPN'ized expression: "text_buffer i + *u text_buffer i 1 - + *u = "
; Expanded expression: "text_buffer (@-4) *(2) + text_buffer (@-4) *(2) 1 - + *(-1) =(-1) "
; Fused expression:    "+ text_buffer *(@-4) push-ax - *(@-4) 1 + text_buffer ax =(119) **sp *ax "
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
; }
L150:
; Fused expression:    "--p(2) *(@-4) "
	mov	ax, [bp-4]
	dec	word [bp-4]
	jmp	L149
L152:
; loc                     <something> : char
; RPN'ized expression: "text_buffer buffer_pos + *u key (something153) = "
; Expanded expression: "text_buffer buffer_pos *(2) + (@-10) *(2) signed char =(-1) "
; Fused expression:    "+ text_buffer *buffer_pos push-ax *(2) (@-10) signed char =(122) **sp ax "
	mov	ax, _text_buffer
	add	ax, [_buffer_pos]
	push	ax
	mov	ax, [bp-10]
	cbw
	pop	bx
	mov	[bx], al
	cbw
; RPN'ized expression: "buffer_pos ++p "
; Expanded expression: "buffer_pos ++p(2) "
; Fused expression:    "++p(2) *buffer_pos "
	mov	ax, [_buffer_pos]
	inc	word [_buffer_pos]
; RPN'ized expression: "text_len ++p "
; Expanded expression: "text_len ++p(2) "
; Fused expression:    "++p(2) *text_len "
	mov	ax, [_text_len]
	inc	word [_text_len]
; RPN'ized expression: "text_buffer text_len + *u 0 = "
; Expanded expression: "text_buffer text_len *(2) + 0 =(-1) "
; Fused expression:    "+ text_buffer *text_len =(122) *ax 0 "
	mov	ax, _text_buffer
	add	ax, [_text_len]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; }
L147:
; }
L144:
L136:
L127:
L125:
; }
L95:
; }
	jmp	L92
L93:
; RPN'ized expression: "( 0 , 0 , 15 style ) "
; Expanded expression: " 0  0  15  style ()6 "
; Fused expression:    "( 0 , 0 , 15 , style )6 "
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6
; RPN'ized expression: "( 2 syscal ) "
; Expanded expression: " 2  syscal ()2 "
; Fused expression:    "( 2 , syscal )2 "
	push	2
	call	_syscal
	sub	sp, -2

section .rodata
L154:
	db	"Editor dropped out safely.",10
	times	1 db 0

section .text
; RPN'ized expression: "( L154 puts ) "
; Expanded expression: " L154  puts ()2 "
; Fused expression:    "( L154 , puts )2 "
	push	L154
	call	_puts
	sub	sp, -2
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L86
; Fused expression:    "0  "
	mov	ax, 0
L86:
	leave
	ret


	extern	_syscal
	extern	_style
	extern	_putchar
	extern	_puts
	extern	_gets

; Syntax/declaration table/stack:
; Bytes used: 920/15360


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
; Macro MAX_BUFFER_SIZE = `4097`
; Macro SCREEN_W = `80`
; Macro SCREEN_H = `25`
; Bytes used: 673/5120


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
; Ident text_buffer
; Ident text_len
; Ident buffer_pos
; Ident current_filename
; Ident menu_active
; Ident move_cursor
; Ident x
; Ident y
; Ident clear_row
; Ident row
; Ident get_xy_from_pos
; Ident pos
; Ident out_x
; Ident out_y
; Ident get_pos_from_xy
; Ident target_x
; Ident target_y
; Ident draw_interface
; Ident save_file
; Ident load_file
; Ident strncpy
; Ident s1
; Ident s2
; Ident main
; Ident args
; Bytes used: 492/5632

; Next label number: 155
; Compilation succeeded.
