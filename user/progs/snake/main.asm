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
; *                         user/progs/snake/main.asm                         *
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
; glb Point : struct <something>
; RPN'ized expression: "60 "
; Expanded expression: "60 "
; Expression value: 60
; glb snake : [60u] struct <something>
section .bss
	alignb 2
	global	_snake
_snake:
	resb	240

; glb snake_len : int
section .data
	align 2
	global	_snake_len
_snake_len:
; =
; RPN'ized expression: "3 "
; Expanded expression: "3 "
; Expression value: 3
	dw	3

; glb fruit : struct <something>
section .bss
	alignb 2
	global	_fruit
_fruit:
	resb	4

; glb dir_x : int
section .data
	align 2
	global	_dir_x
_dir_x:
; =
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
	dw	1

; glb dir_y : int
section .data
	align 2
	global	_dir_y
_dir_y:
; =
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	dw	0

; glb score : int
section .data
	align 2
	global	_score
_score:
; =
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	dw	0

; glb game_over : int
section .data
	align 2
	global	_game_over
_game_over:
; =
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	dw	0

; glb basic_rand : (
; prm     min : int
; prm     max : int
;     ) int
section .text
	global	_basic_rand
_basic_rand:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     min : (@4) : int
; loc     max : (@6) : int
; loc     seed : L3 : unsigned

section .data
	align 2
L3:
; =
; RPN'ized expression: "12345 "
; Expanded expression: "12345 "
; Expression value: 12345
	dw	12345

section .text
; RPN'ized expression: "seed seed 31421 * 6927 + = "
; Expanded expression: "L3 L3 *(2) 31421 * 6927 + =(2) "
; Fused expression:    "* *3 31421 + ax 6927 =(170) *3 ax "
	mov	ax, [L3]
	imul	ax, ax, 31421
	add	ax, 6927
	mov	[L3], ax
; return
; loc     <something> : int
; loc     <something> : unsigned
; RPN'ized expression: "seed max min - 1 + (something5) % (something4) min + "
; Expanded expression: "L3 *(2) (@6) *(2) (@4) *(2) - 1 + %u (@4) *(2) + "
; Fused expression:    "- *(@6) *(@4) + ax 1 %u *3 ax + ax *(@4)  "
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
; RPN'ized expression: "( 2 x * , 5 syscal ) "
; Expanded expression: " 2 (@4) *(2) *  5  syscal ()4 "
; Fused expression:    "( * 2 *(@4) , 5 , syscal )4 "
	mov	ax, 2
	mul	word [bp+4]
	push	ax
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
L6:
	leave
	ret

; glb setup_board : () void
section .text
	global	_setup_board
_setup_board:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     i : (@-2) : int
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
; RPN'ized expression: "( 0 , 7 , 15 style ) "
; Expanded expression: " 0  7  15  style ()6 "
; Fused expression:    "( 0 , 7 , 15 , style )6 "
	push	0
	push	7
	push	15
	call	_style
	sub	sp, -6
; for
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
L10:
; RPN'ized expression: "i 30 2 + < "
; Expanded expression: "(@-2) *(2) 32 < "
; Fused expression:    "< *(@-2) 32 IF! "
	mov	ax, [bp-2]
	cmp	ax, 32
	jge	L13
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; {
; RPN'ized expression: "( 0 , i move_cursor ) "
; Expanded expression: " 0  (@-2) *(2)  move_cursor ()4 "
; Fused expression:    "( 0 , *(2) (@-2) , move_cursor )4 "
	push	0
	push	word [bp-2]
	call	_move_cursor
	sub	sp, -4

section .rodata
L14:
	db	"  "
	times	1 db 0

section .text
; RPN'ized expression: "( L14 puts ) "
; Expanded expression: " L14  puts ()2 "
; Fused expression:    "( L14 , puts )2 "
	push	L14
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 20 1 + , i move_cursor ) "
; Expanded expression: " 21  (@-2) *(2)  move_cursor ()4 "
; Fused expression:    "( 21 , *(2) (@-2) , move_cursor )4 "
	push	21
	push	word [bp-2]
	call	_move_cursor
	sub	sp, -4

section .rodata
L15:
	db	"  "
	times	1 db 0

section .text
; RPN'ized expression: "( L15 puts ) "
; Expanded expression: " L15  puts ()2 "
; Fused expression:    "( L15 , puts )2 "
	push	L15
	call	_puts
	sub	sp, -2
; }
L11:
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L10
L13:
; for
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
L16:
; RPN'ized expression: "i 20 2 + < "
; Expanded expression: "(@-2) *(2) 22 < "
; Fused expression:    "< *(@-2) 22 IF! "
	mov	ax, [bp-2]
	cmp	ax, 22
	jge	L19
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; {
; RPN'ized expression: "( i , 0 move_cursor ) "
; Expanded expression: " (@-2) *(2)  0  move_cursor ()4 "
; Fused expression:    "( *(2) (@-2) , 0 , move_cursor )4 "
	push	word [bp-2]
	push	0
	call	_move_cursor
	sub	sp, -4

section .rodata
L20:
	db	"  "
	times	1 db 0

section .text
; RPN'ized expression: "( L20 puts ) "
; Expanded expression: " L20  puts ()2 "
; Fused expression:    "( L20 , puts )2 "
	push	L20
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( i , 30 1 + move_cursor ) "
; Expanded expression: " (@-2) *(2)  31  move_cursor ()4 "
; Fused expression:    "( *(2) (@-2) , 31 , move_cursor )4 "
	push	word [bp-2]
	push	31
	call	_move_cursor
	sub	sp, -4

section .rodata
L21:
	db	"  "
	times	1 db 0

section .text
; RPN'ized expression: "( L21 puts ) "
; Expanded expression: " L21  puts ()2 "
; Fused expression:    "( L21 , puts )2 "
	push	L21
	call	_puts
	sub	sp, -2
; }
L17:
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L16
L19:
L8:
	leave
	ret

; glb spawn_fruit : () void
section .text
	global	_spawn_fruit
_spawn_fruit:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; RPN'ized expression: "fruit &u x -> *u ( 30 , 1 basic_rand ) = "
; Expanded expression: "fruit 0 +  30  1  basic_rand ()4 =(2) "
; Fused expression:    "+ fruit 0 push-ax ( 30 , 1 , basic_rand )4 =(170) **sp ax "
	mov	ax, _fruit
	push	ax
	push	30
	push	1
	call	_basic_rand
	sub	sp, -4
	pop	bx
	mov	[bx], ax
; RPN'ized expression: "fruit &u y -> *u ( 20 , 1 basic_rand ) = "
; Expanded expression: "fruit 2 +  20  1  basic_rand ()4 =(2) "
; Fused expression:    "+ fruit 2 push-ax ( 20 , 1 , basic_rand )4 =(170) **sp ax "
	mov	ax, _fruit
	add	ax, 2
	push	ax
	push	20
	push	1
	call	_basic_rand
	sub	sp, -4
	pop	bx
	mov	[bx], ax
; RPN'ized expression: "( fruit &u y -> *u , fruit &u x -> *u move_cursor ) "
; Expanded expression: " fruit 2 + *(2)  fruit 0 + *(2)  move_cursor ()4 "
; Fused expression:    "( + fruit 2 *(2) ax , + fruit 0 *(2) ax , move_cursor )4 "
	mov	ax, _fruit
	add	ax, 2
	mov	bx, ax
	push	word [bx]
	mov	ax, _fruit
	mov	bx, ax
	push	word [bx]
	call	_move_cursor
	sub	sp, -4
; RPN'ized expression: "( 0 , 0 , 4 style ) "
; Expanded expression: " 0  0  4  style ()6 "
; Fused expression:    "( 0 , 0 , 4 , style )6 "
	push	0
	push	0
	push	4
	call	_style
	sub	sp, -6
; RPN'ized expression: "( 220 putchar ) "
; Expanded expression: " 220  putchar ()2 "
; Fused expression:    "( 220 , putchar )2 "
	push	220
	call	_putchar
	sub	sp, -2
; RPN'ized expression: "( 0 , 0 , 2 style ) "
; Expanded expression: " 0  0  2  style ()6 "
; Fused expression:    "( 0 , 0 , 2 , style )6 "
	push	0
	push	0
	push	2
	call	_style
	sub	sp, -6
; RPN'ized expression: "( 217 putchar ) "
; Expanded expression: " 217  putchar ()2 "
; Fused expression:    "( 217 , putchar )2 "
	push	217
	call	_putchar
	sub	sp, -2
L22:
	leave
	ret

; glb init_game : () void
section .text
	global	_init_game
_init_game:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     i : (@-2) : int
; RPN'ized expression: "game_over 0 = "
; Expanded expression: "game_over 0 =(2) "
; Fused expression:    "=(170) *game_over 0 "
	mov	ax, 0
	mov	[_game_over], ax
; RPN'ized expression: "score 0 = "
; Expanded expression: "score 0 =(2) "
; Fused expression:    "=(170) *score 0 "
	mov	ax, 0
	mov	[_score], ax
; RPN'ized expression: "snake_len 3 = "
; Expanded expression: "snake_len 3 =(2) "
; Fused expression:    "=(170) *snake_len 3 "
	mov	ax, 3
	mov	[_snake_len], ax
; RPN'ized expression: "snake 0 + *u &u x -> *u 30 2 / = "
; Expanded expression: "snake 0 + 0 + 15 =(2) "
; Fused expression:    "+ snake 0 + ax 0 =(170) *ax 15 "
	mov	ax, _snake
	mov	bx, ax
	mov	ax, 15
	mov	[bx], ax
; RPN'ized expression: "snake 0 + *u &u y -> *u 20 2 / = "
; Expanded expression: "snake 0 + 2 + 10 =(2) "
; Fused expression:    "+ snake 0 + ax 2 =(170) *ax 10 "
	mov	ax, _snake
	add	ax, 2
	mov	bx, ax
	mov	ax, 10
	mov	[bx], ax
; RPN'ized expression: "snake 1 + *u &u x -> *u 30 2 / 1 - = "
; Expanded expression: "snake 4 + 0 + 14 =(2) "
; Fused expression:    "+ snake 4 + ax 0 =(170) *ax 14 "
	mov	ax, _snake
	add	ax, 4
	mov	bx, ax
	mov	ax, 14
	mov	[bx], ax
; RPN'ized expression: "snake 1 + *u &u y -> *u 20 2 / = "
; Expanded expression: "snake 4 + 2 + 10 =(2) "
; Fused expression:    "+ snake 4 + ax 2 =(170) *ax 10 "
	mov	ax, _snake
	add	ax, 4
	add	ax, 2
	mov	bx, ax
	mov	ax, 10
	mov	[bx], ax
; RPN'ized expression: "snake 2 + *u &u x -> *u 30 2 / 2 - = "
; Expanded expression: "snake 8 + 0 + 13 =(2) "
; Fused expression:    "+ snake 8 + ax 0 =(170) *ax 13 "
	mov	ax, _snake
	add	ax, 8
	mov	bx, ax
	mov	ax, 13
	mov	[bx], ax
; RPN'ized expression: "snake 2 + *u &u y -> *u 20 2 / = "
; Expanded expression: "snake 8 + 2 + 10 =(2) "
; Fused expression:    "+ snake 8 + ax 2 =(170) *ax 10 "
	mov	ax, _snake
	add	ax, 8
	add	ax, 2
	mov	bx, ax
	mov	ax, 10
	mov	[bx], ax
; RPN'ized expression: "dir_x 1 = "
; Expanded expression: "dir_x 1 =(2) "
; Fused expression:    "=(170) *dir_x 1 "
	mov	ax, 1
	mov	[_dir_x], ax
; RPN'ized expression: "dir_y 0 = "
; Expanded expression: "dir_y 0 =(2) "
; Fused expression:    "=(170) *dir_y 0 "
	mov	ax, 0
	mov	[_dir_y], ax
; RPN'ized expression: "( setup_board ) "
; Expanded expression: " setup_board ()0 "
; Fused expression:    "( setup_board )0 "
	call	_setup_board
; RPN'ized expression: "( spawn_fruit ) "
; Expanded expression: " spawn_fruit ()0 "
; Fused expression:    "( spawn_fruit )0 "
	call	_spawn_fruit
; for
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
L26:
; RPN'ized expression: "i snake_len < "
; Expanded expression: "(@-2) *(2) snake_len *(2) < "
; Fused expression:    "< *(@-2) *snake_len IF! "
	mov	ax, [bp-2]
	cmp	ax, [_snake_len]
	jge	L29
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; {
; RPN'ized expression: "( snake i + *u &u y -> *u , snake i + *u &u x -> *u move_cursor ) "
; Expanded expression: " snake (@-2) *(2) 4 * + 2 + *(2)  snake (@-2) *(2) 4 * + 0 + *(2)  move_cursor ()4 "
; Fused expression:    "( * *(@-2) 4 + snake ax + ax 2 *(2) ax , * *(@-2) 4 + snake ax + ax 0 *(2) ax , move_cursor )4 "
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
; if
; RPN'ized expression: "i 0 == "
; Expanded expression: "(@-2) *(2) 0 == "
; Fused expression:    "== *(@-2) 0 IF! "
	mov	ax, [bp-2]
	cmp	ax, 0
	jne	L30
; {
; RPN'ized expression: "( 0 , 2 , 15 style ) "
; Expanded expression: " 0  2  15  style ()6 "
; Fused expression:    "( 0 , 2 , 15 , style )6 "
	push	0
	push	2
	push	15
	call	_style
	sub	sp, -6
; }
	jmp	L31
L30:
; else
; {
; RPN'ized expression: "( 0 , 10 , 15 style ) "
; Expanded expression: " 0  10  15  style ()6 "
; Fused expression:    "( 0 , 10 , 15 , style )6 "
	push	0
	push	10
	push	15
	call	_style
	sub	sp, -6
; }
L31:

section .rodata
L32:
	db	"  "
	times	1 db 0

section .text
; RPN'ized expression: "( L32 puts ) "
; Expanded expression: " L32  puts ()2 "
; Fused expression:    "( L32 , puts )2 "
	push	L32
	call	_puts
	sub	sp, -2
; }
L27:
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L26
L29:
L24:
	leave
	ret

; glb process_input : () void
section .text
	global	_process_input
_process_input:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; if
; RPN'ized expression: "( kbhit ) "
; Expanded expression: " kbhit ()0 "
; Fused expression:    "( kbhit )0  "
	call	_kbhit
; JumpIfZero
	test	ax, ax
	je	L35
; {
; loc         key : (@-2) : int
; RPN'ized expression: "key ( getchar ) = "
; Expanded expression: "(@-2)  getchar ()0 =(2) "
; Fused expression:    "( getchar )0 =(170) *(@-2) ax "
	call	_getchar
	mov	[bp-2], ax
; if
; RPN'ized expression: "key 119 == dir_y 1 != && "
; Expanded expression: "(@-2) *(2) 119 == [sh&&->39] dir_y *(2) 1 != &&[39] "
; Fused expression:    "== *(@-2) 119 [sh&&->39] != *dir_y 1 &&[39]  "
	mov	ax, [bp-2]
	cmp	ax, 119
	sete	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L39
	mov	ax, [_dir_y]
	cmp	ax, 1
	setne	al
	cbw
L39:
; JumpIfZero
	test	ax, ax
	je	L37
; {
; RPN'ized expression: "dir_x 0 = "
; Expanded expression: "dir_x 0 =(2) "
; Fused expression:    "=(170) *dir_x 0 "
	mov	ax, 0
	mov	[_dir_x], ax
; RPN'ized expression: "dir_y 1 -u = "
; Expanded expression: "dir_y -1 =(2) "
; Fused expression:    "=(170) *dir_y -1 "
	mov	ax, -1
	mov	[_dir_y], ax
; }
	jmp	L38
L37:
; else
; if
; RPN'ized expression: "key 115 == dir_y 1 -u != && "
; Expanded expression: "(@-2) *(2) 115 == [sh&&->42] dir_y *(2) -1 != &&[42] "
; Fused expression:    "== *(@-2) 115 [sh&&->42] != *dir_y -1 &&[42]  "
	mov	ax, [bp-2]
	cmp	ax, 115
	sete	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L42
	mov	ax, [_dir_y]
	cmp	ax, -1
	setne	al
	cbw
L42:
; JumpIfZero
	test	ax, ax
	je	L40
; {
; RPN'ized expression: "dir_x 0 = "
; Expanded expression: "dir_x 0 =(2) "
; Fused expression:    "=(170) *dir_x 0 "
	mov	ax, 0
	mov	[_dir_x], ax
; RPN'ized expression: "dir_y 1 = "
; Expanded expression: "dir_y 1 =(2) "
; Fused expression:    "=(170) *dir_y 1 "
	mov	ax, 1
	mov	[_dir_y], ax
; }
	jmp	L41
L40:
; else
; if
; RPN'ized expression: "key 97 == dir_x 1 != && "
; Expanded expression: "(@-2) *(2) 97 == [sh&&->45] dir_x *(2) 1 != &&[45] "
; Fused expression:    "== *(@-2) 97 [sh&&->45] != *dir_x 1 &&[45]  "
	mov	ax, [bp-2]
	cmp	ax, 97
	sete	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L45
	mov	ax, [_dir_x]
	cmp	ax, 1
	setne	al
	cbw
L45:
; JumpIfZero
	test	ax, ax
	je	L43
; {
; RPN'ized expression: "dir_x 1 -u = "
; Expanded expression: "dir_x -1 =(2) "
; Fused expression:    "=(170) *dir_x -1 "
	mov	ax, -1
	mov	[_dir_x], ax
; RPN'ized expression: "dir_y 0 = "
; Expanded expression: "dir_y 0 =(2) "
; Fused expression:    "=(170) *dir_y 0 "
	mov	ax, 0
	mov	[_dir_y], ax
; }
	jmp	L44
L43:
; else
; if
; RPN'ized expression: "key 100 == dir_x 1 -u != && "
; Expanded expression: "(@-2) *(2) 100 == [sh&&->48] dir_x *(2) -1 != &&[48] "
; Fused expression:    "== *(@-2) 100 [sh&&->48] != *dir_x -1 &&[48]  "
	mov	ax, [bp-2]
	cmp	ax, 100
	sete	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L48
	mov	ax, [_dir_x]
	cmp	ax, -1
	setne	al
	cbw
L48:
; JumpIfZero
	test	ax, ax
	je	L46
; {
; RPN'ized expression: "dir_x 1 = "
; Expanded expression: "dir_x 1 =(2) "
; Fused expression:    "=(170) *dir_x 1 "
	mov	ax, 1
	mov	[_dir_x], ax
; RPN'ized expression: "dir_y 0 = "
; Expanded expression: "dir_y 0 =(2) "
; Fused expression:    "=(170) *dir_y 0 "
	mov	ax, 0
	mov	[_dir_y], ax
; }
	jmp	L47
L46:
; else
; if
; RPN'ized expression: "key 113 == "
; Expanded expression: "(@-2) *(2) 113 == "
; Fused expression:    "== *(@-2) 113 IF! "
	mov	ax, [bp-2]
	cmp	ax, 113
	jne	L49
; {
; RPN'ized expression: "game_over 1 = "
; Expanded expression: "game_over 1 =(2) "
; Fused expression:    "=(170) *game_over 1 "
	mov	ax, 1
	mov	[_game_over], ax
; }
L49:
L47:
L44:
L41:
L38:
; }
L35:
L33:
	leave
	ret

; glb update_game : () void
section .text
	global	_update_game
_update_game:
	push	bp
	mov	bp, sp
	 sub	sp,          6
; loc     i : (@-2) : int
; loc     old_tail : (@-6) : struct <something>
; RPN'ized expression: "old_tail snake snake_len 1 - + *u = "
; Expanded expression: " (@-6)  snake snake_len *(2) 1 - 4 * +  4u  L53 ()6 "
; Fused expression:    "( (@-6) , - *snake_len 1 * ax 4 + snake ax , 4u , L53 )6 "
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
; RPN'ized expression: "( 0 , 0 , 15 style ) "
; Expanded expression: " 0  0  15  style ()6 "
; Fused expression:    "( 0 , 0 , 15 , style )6 "
	push	0
	push	0
	push	15
	call	_style
	sub	sp, -6
; RPN'ized expression: "( old_tail &u y -> *u , old_tail &u x -> *u move_cursor ) "
; Expanded expression: " (@-4) *(2)  (@-6) *(2)  move_cursor ()4 "
; Fused expression:    "( *(2) (@-4) , *(2) (@-6) , move_cursor )4 "
	push	word [bp-4]
	push	word [bp-6]
	call	_move_cursor
	sub	sp, -4

section .rodata
L54:
	db	"  "
	times	1 db 0

section .text
; RPN'ized expression: "( L54 puts ) "
; Expanded expression: " L54  puts ()2 "
; Fused expression:    "( L54 , puts )2 "
	push	L54
	call	_puts
	sub	sp, -2
; for
; RPN'ized expression: "i snake_len 1 - = "
; Expanded expression: "(@-2) snake_len *(2) 1 - =(2) "
; Fused expression:    "- *snake_len 1 =(170) *(@-2) ax "
	mov	ax, [_snake_len]
	dec	ax
	mov	[bp-2], ax
L55:
; RPN'ized expression: "i 0 > "
; Expanded expression: "(@-2) *(2) 0 > "
; Fused expression:    "> *(@-2) 0 IF! "
	mov	ax, [bp-2]
	cmp	ax, 0
	jle	L58
; RPN'ized expression: "i --p "
; Expanded expression: "(@-2) --p(2) "
; {
; RPN'ized expression: "snake i + *u snake i 1 - + *u = "
; Expanded expression: " snake (@-2) *(2) 4 * +  snake (@-2) *(2) 1 - 4 * +  4u  L53 ()6 "
; Fused expression:    "( * *(@-2) 4 + snake ax , - *(@-2) 1 * ax 4 + snake ax , 4u , L53 )6 "
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
; }
L56:
; Fused expression:    "--p(2) *(@-2) "
	mov	ax, [bp-2]
	dec	word [bp-2]
	jmp	L55
L58:
; RPN'ized expression: "snake 0 + *u &u x -> *u dir_x += "
; Expanded expression: "snake 0 + 0 + dir_x *(2) +=(2) "
; Fused expression:    "+ snake 0 + ax 0 +=(170) *ax *dir_x "
	mov	ax, _snake
	mov	bx, ax
	mov	ax, [bx]
	add	ax, [_dir_x]
	mov	[bx], ax
; RPN'ized expression: "snake 0 + *u &u y -> *u dir_y += "
; Expanded expression: "snake 0 + 2 + dir_y *(2) +=(2) "
; Fused expression:    "+ snake 0 + ax 2 +=(170) *ax *dir_y "
	mov	ax, _snake
	add	ax, 2
	mov	bx, ax
	mov	ax, [bx]
	add	ax, [_dir_y]
	mov	[bx], ax
; if
; RPN'ized expression: "snake 0 + *u &u x -> *u 0 <= snake 0 + *u &u x -> *u 30 > || snake 0 + *u &u y -> *u 0 <= || snake 0 + *u &u y -> *u 20 > || "
; Expanded expression: "snake 0 + 0 + *(2) 0 <= [sh||->63] snake 0 + 0 + *(2) 30 > ||[63] _Bool [sh||->62] snake 0 + 2 + *(2) 0 <= ||[62] _Bool [sh||->61] snake 0 + 2 + *(2) 20 > ||[61] "
; Fused expression:    "+ snake 0 + ax 0 <= *ax 0 [sh||->63] + snake 0 + ax 0 > *ax 30 ||[63] _Bool [sh||->62] + snake 0 + ax 2 <= *ax 0 ||[62] _Bool [sh||->61] + snake 0 + ax 2 > *ax 20 ||[61]  "
	mov	ax, _snake
	mov	bx, ax
	mov	ax, [bx]
	cmp	ax, 0
	setle	al
	cbw
; JumpIfNotZero
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
; JumpIfNotZero
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
; JumpIfNotZero
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
; JumpIfZero
	test	ax, ax
	je	L59
; {
; RPN'ized expression: "game_over 1 = "
; Expanded expression: "game_over 1 =(2) "
; Fused expression:    "=(170) *game_over 1 "
	mov	ax, 1
	mov	[_game_over], ax
; return
	jmp	L51
; }
L59:
; for
; RPN'ized expression: "i 1 = "
; Expanded expression: "(@-2) 1 =(2) "
; Fused expression:    "=(170) *(@-2) 1 "
	mov	ax, 1
	mov	[bp-2], ax
L64:
; RPN'ized expression: "i snake_len < "
; Expanded expression: "(@-2) *(2) snake_len *(2) < "
; Fused expression:    "< *(@-2) *snake_len IF! "
	mov	ax, [bp-2]
	cmp	ax, [_snake_len]
	jge	L67
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; {
; if
; RPN'ized expression: "snake 0 + *u &u x -> *u snake i + *u &u x -> *u == snake 0 + *u &u y -> *u snake i + *u &u y -> *u == && "
; Expanded expression: "snake 0 + 0 + *(2) snake (@-2) *(2) 4 * + 0 + *(2) == [sh&&->70] snake 0 + 2 + *(2) snake (@-2) *(2) 4 * + 2 + *(2) == &&[70] "
; Fused expression:    "+ snake 0 + ax 0 push-ax * *(@-2) 4 + snake ax + ax 0 == **sp *ax [sh&&->70] + snake 0 + ax 2 push-ax * *(@-2) 4 + snake ax + ax 2 == **sp *ax &&[70]  "
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
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L68
; {
; RPN'ized expression: "game_over 1 = "
; Expanded expression: "game_over 1 =(2) "
; Fused expression:    "=(170) *game_over 1 "
	mov	ax, 1
	mov	[_game_over], ax
; return
	jmp	L51
; }
L68:
; }
L65:
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L64
L67:
; if
; RPN'ized expression: "snake 0 + *u &u x -> *u fruit &u x -> *u == snake 0 + *u &u y -> *u fruit &u y -> *u == && "
; Expanded expression: "snake 0 + 0 + *(2) fruit 0 + *(2) == [sh&&->73] snake 0 + 2 + *(2) fruit 2 + *(2) == &&[73] "
; Fused expression:    "+ snake 0 + ax 0 push-ax + fruit 0 == **sp *ax [sh&&->73] + snake 0 + ax 2 push-ax + fruit 2 == **sp *ax &&[73]  "
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
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L71
; {
; RPN'ized expression: "score 10 += "
; Expanded expression: "score 10 +=(2) "
; Fused expression:    "+=(170) *score 10 "
	mov	ax, [_score]
	add	ax, 10
	mov	[_score], ax
; if
; RPN'ized expression: "snake_len 60 < "
; Expanded expression: "snake_len *(2) 60 < "
; Fused expression:    "< *snake_len 60 IF! "
	mov	ax, [_snake_len]
	cmp	ax, 60
	jge	L74
; {
; RPN'ized expression: "snake snake_len + *u old_tail = "
; Expanded expression: " snake snake_len *(2) 4 * +  (@-6)  4u  L53 ()6 "
; Fused expression:    "( * *snake_len 4 + snake ax , (@-6) , 4u , L53 )6 "
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
; RPN'ized expression: "snake_len ++p "
; Expanded expression: "snake_len ++p(2) "
; Fused expression:    "++p(2) *snake_len "
	mov	ax, [_snake_len]
	inc	word [_snake_len]
; }
L74:
; RPN'ized expression: "( spawn_fruit ) "
; Expanded expression: " spawn_fruit ()0 "
; Fused expression:    "( spawn_fruit )0 "
	call	_spawn_fruit
; }
L71:
; if
; RPN'ized expression: "snake_len 1 > "
; Expanded expression: "snake_len *(2) 1 > "
; Fused expression:    "> *snake_len 1 IF! "
	mov	ax, [_snake_len]
	cmp	ax, 1
	jle	L76
; {
; RPN'ized expression: "( 0 , 10 , 1 style ) "
; Expanded expression: " 0  10  1  style ()6 "
; Fused expression:    "( 0 , 10 , 1 , style )6 "
	push	0
	push	10
	push	1
	call	_style
	sub	sp, -6
; RPN'ized expression: "( snake 1 + *u &u y -> *u , snake 1 + *u &u x -> *u move_cursor ) "
; Expanded expression: " snake 4 + 2 + *(2)  snake 4 + 0 + *(2)  move_cursor ()4 "
; Fused expression:    "( + snake 4 + ax 2 *(2) ax , + snake 4 + ax 0 *(2) ax , move_cursor )4 "
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
; RPN'ized expression: "( L78 puts ) "
; Expanded expression: " L78  puts ()2 "
; Fused expression:    "( L78 , puts )2 "
	push	L78
	call	_puts
	sub	sp, -2
; }
L76:
; RPN'ized expression: "( 0 , 2 , 15 style ) "
; Expanded expression: " 0  2  15  style ()6 "
; Fused expression:    "( 0 , 2 , 15 , style )6 "
	push	0
	push	2
	push	15
	call	_style
	sub	sp, -6
; RPN'ized expression: "( snake 0 + *u &u y -> *u , snake 0 + *u &u x -> *u move_cursor ) "
; Expanded expression: " snake 0 + 2 + *(2)  snake 0 + 0 + *(2)  move_cursor ()4 "
; Fused expression:    "( + snake 0 + ax 2 *(2) ax , + snake 0 + ax 0 *(2) ax , move_cursor )4 "
	mov	ax, _snake
	add	ax, 2
	mov	bx, ax
	push	word [bx]
	mov	ax, _snake
	mov	bx, ax
	push	word [bx]
	call	_move_cursor
	sub	sp, -4
; if
; RPN'ized expression: "dir_x 1 == "
; Expanded expression: "dir_x *(2) 1 == "
; Fused expression:    "== *dir_x 1 IF! "
	mov	ax, [_dir_x]
	cmp	ax, 1
	jne	L79

section .rodata
L81:
	db	";)"
	times	1 db 0

section .text
; RPN'ized expression: "( L81 puts ) "
; Expanded expression: " L81  puts ()2 "
; Fused expression:    "( L81 , puts )2 "
	push	L81
	call	_puts
	sub	sp, -2
L79:
; if
; RPN'ized expression: "dir_x 1 -u == "
; Expanded expression: "dir_x *(2) -1 == "
; Fused expression:    "== *dir_x -1 IF! "
	mov	ax, [_dir_x]
	cmp	ax, -1
	jne	L82

section .rodata
L84:
	db	"(:"
	times	1 db 0

section .text
; RPN'ized expression: "( L84 puts ) "
; Expanded expression: " L84  puts ()2 "
; Fused expression:    "( L84 , puts )2 "
	push	L84
	call	_puts
	sub	sp, -2
L82:
; if
; RPN'ized expression: "dir_y 1 == "
; Expanded expression: "dir_y *(2) 1 == "
; Fused expression:    "== *dir_y 1 IF! "
	mov	ax, [_dir_y]
	cmp	ax, 1
	jne	L85

section .rodata
L87:
	db	"><"
	times	1 db 0

section .text
; RPN'ized expression: "( L87 puts ) "
; Expanded expression: " L87  puts ()2 "
; Fused expression:    "( L87 , puts )2 "
	push	L87
	call	_puts
	sub	sp, -2
L85:
; if
; RPN'ized expression: "dir_y 1 -u == "
; Expanded expression: "dir_y *(2) -1 == "
; Fused expression:    "== *dir_y -1 IF! "
	mov	ax, [_dir_y]
	cmp	ax, -1
	jne	L88

section .rodata
L90:
	db	"^^"
	times	1 db 0

section .text
; RPN'ized expression: "( L90 puts ) "
; Expanded expression: " L90  puts ()2 "
; Fused expression:    "( L90 , puts )2 "
	push	L90
	call	_puts
	sub	sp, -2
L88:

section .rodata
L91:
	db	8,8
	times	1 db 0

section .text
; RPN'ized expression: "( L91 puts ) "
; Expanded expression: " L91  puts ()2 "
; Fused expression:    "( L91 , puts )2 "
	push	L91
	call	_puts
	sub	sp, -2
L51:
	leave
	ret

; glb delay : (
; prm     n : int
;     ) void
section .text
	global	_delay
_delay:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     n : (@4) : int
; RPN'ized expression: "( n , 20 syscal ) "
; Expanded expression: " (@4) *(2)  20  syscal ()4 "
; Fused expression:    "( *(2) (@4) , 20 , syscal )4 "
	push	word [bp+4]
	push	20
	call	_syscal
	sub	sp, -4
L92:
	leave
	ret

; glb main : () int
section .text
	global	_main
_main:
	push	bp
	mov	bp, sp
	 sub	sp,         20
; RPN'ized expression: "20 "
; Expanded expression: "20 "
; Expression value: 20
; loc     name : (@-20) : [20u] char

section .rodata
L96:
	db	"Enter Snake Name: "
	times	1 db 0

section .text
; RPN'ized expression: "( L96 puts ) "
; Expanded expression: " L96  puts ()2 "
; Fused expression:    "( L96 , puts )2 "
	push	L96
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( name gets ) "
; Expanded expression: " (@-20)  gets ()2 "
; Fused expression:    "( (@-20) , gets )2 "
	lea	ax, [bp-20]
	push	ax
	call	_gets
	sub	sp, -2

section .rodata
L97:
	db	"Get ready, "
	times	1 db 0

section .text
; RPN'ized expression: "( L97 puts ) "
; Expanded expression: " L97  puts ()2 "
; Fused expression:    "( L97 , puts )2 "
	push	L97
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( name puts ) "
; Expanded expression: " (@-20)  puts ()2 "
; Fused expression:    "( (@-20) , puts )2 "
	lea	ax, [bp-20]
	push	ax
	call	_puts
	sub	sp, -2

section .rodata
L98:
	db	"!",10
	times	1 db 0

section .text
; RPN'ized expression: "( L98 puts ) "
; Expanded expression: " L98  puts ()2 "
; Fused expression:    "( L98 , puts )2 "
	push	L98
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 50 , 20 syscal ) "
; Expanded expression: " 50  20  syscal ()4 "
; Fused expression:    "( 50 , 20 , syscal )4 "
	push	50
	push	20
	call	_syscal
	sub	sp, -4
; RPN'ized expression: "( init_game ) "
; Expanded expression: " init_game ()0 "
; Fused expression:    "( init_game )0 "
	call	_init_game
; while
; RPN'ized expression: "game_over 0 == "
; Expanded expression: "game_over *(2) 0 == "
L99:
; Fused expression:    "== *game_over 0 IF! "
	mov	ax, [_game_over]
	cmp	ax, 0
	jne	L100
; {
; RPN'ized expression: "( process_input ) "
; Expanded expression: " process_input ()0 "
; Fused expression:    "( process_input )0 "
	call	_process_input
; RPN'ized expression: "( update_game ) "
; Expanded expression: " update_game ()0 "
; Fused expression:    "( update_game )0 "
	call	_update_game
; RPN'ized expression: "( 0 , 5 syscal ) "
; Expanded expression: " 0  5  syscal ()4 "
; Fused expression:    "( 0 , 5 , syscal )4 "
	push	0
	push	5
	call	_syscal
	sub	sp, -4
; RPN'ized expression: "( 20 1 + , 6 syscal ) "
; Expanded expression: " 21  6  syscal ()4 "
; Fused expression:    "( 21 , 6 , syscal )4 "
	push	21
	push	6
	call	_syscal
	sub	sp, -4

section .rodata
L101:
	db	"Score: ~i |"
	times	1 db 0

section .text
; RPN'ized expression: "( score , L101 pformat ) "
; Expanded expression: " score *(2)  L101  pformat ()4 "
; Fused expression:    "( *(2) score , L101 , pformat )4 "
	push	word [_score]
	push	L101
	call	_pformat
	sub	sp, -4
; RPN'ized expression: "( 15 delay ) "
; Expanded expression: " 15  delay ()2 "
; Fused expression:    "( 15 , delay )2 "
	push	15
	call	_delay
	sub	sp, -2
; }
	jmp	L99
L100:
; RPN'ized expression: "( getchar ) "
; Expanded expression: " getchar ()0 "
; Fused expression:    "( getchar )0 "
	call	_getchar
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
; RPN'ized expression: "( 20 2 / , 30 4 / move_cursor ) "
; Expanded expression: " 10  7  move_cursor ()4 "
; Fused expression:    "( 10 , 7 , move_cursor )4 "
	push	10
	push	7
	call	_move_cursor
	sub	sp, -4

section .rodata
L102:
	db	"GAME OVER!"
	times	1 db 0

section .text
; RPN'ized expression: "( L102 puts ) "
; Expanded expression: " L102  puts ()2 "
; Fused expression:    "( L102 , puts )2 "
	push	L102
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( 20 2 / 1 + , 30 4 / move_cursor ) "
; Expanded expression: " 11  7  move_cursor ()4 "
; Fused expression:    "( 11 , 7 , move_cursor )4 "
	push	11
	push	7
	call	_move_cursor
	sub	sp, -4

section .rodata
L103:
	db	"Score: "
	times	1 db 0

section .text
; RPN'ized expression: "( L103 puts ) "
; Expanded expression: " L103  puts ()2 "
; Fused expression:    "( L103 , puts )2 "
	push	L103
	call	_puts
	sub	sp, -2
; RPN'ized expression: "( score puti ) "
; Expanded expression: " score *(2)  puti ()2 "
; Fused expression:    "( *(2) score , puti )2 "
	push	word [_score]
	call	_puti
	sub	sp, -2
; RPN'ized expression: "( 10 putchar ) "
; Expanded expression: " 10  putchar ()2 "
; Fused expression:    "( 10 , putchar )2 "
	push	10
	call	_putchar
	sub	sp, -2
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L94
; Fused expression:    "0  "
	mov	ax, 0
L94:
	leave
	ret

section .text
L53:
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


	extern	_syscal
	extern	_style
	extern	_puts
	extern	_putchar
	extern	_kbhit
	extern	_getchar
	extern	_gets
	extern	_pformat
	extern	_puti

; Syntax/declaration table/stack:
; Bytes used: 865/15360


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
; Macro WIDTH = `30`
; Macro HEIGHT = `20`
; Macro UP = `'w'`
; Macro DOWN = `'s'`
; Macro LEFT = `'a'`
; Macro RIGHT = `'d'`
; Macro QUIT = `'q'`
; Bytes used: 695/5120


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
; Ident x
; Ident y
; Ident Point
; Ident snake
; Ident snake_len
; Ident fruit
; Ident dir_x
; Ident dir_y
; Ident score
; Ident game_over
; Ident basic_rand
; Ident min
; Ident max
; Ident move_cursor
; Ident setup_board
; Ident spawn_fruit
; Ident init_game
; Ident process_input
; Ident update_game
; Ident delay
; Ident main
; Bytes used: 434/5632

; Next label number: 104
; Compilation succeeded.
