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
; *                          user/progs/asm/main.asm                          *
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
; RPN'ized expression: "16 "
; Expanded expression: "16 "
; Expression value: 16
; glb Label : struct <something>
; RPN'ized expression: "64 "
; Expanded expression: "64 "
; Expression value: 64
; glb label_table : [64u] struct <something>
section .bss
	alignb 2
	global	_label_table
_label_table:
	resb	1152

; glb label_count : int
section .data
	align 2
	global	_label_count
_label_count:
; =
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	dw	0

; RPN'ized expression: "128 "
; Expanded expression: "128 "
; Expression value: 128
; glb line_buffer : [128u] char
section .bss
	global	_line_buffer
_line_buffer:
	resb	128

; RPN'ized expression: "1024 "
; Expanded expression: "1024 "
; Expression value: 1024
; glb output_binary : [1024u] unsigned char
section .bss
	global	_output_binary
_output_binary:
	resb	1024

; glb binary_size : int
section .data
	align 2
	global	_binary_size
_binary_size:
; =
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
	dw	0

; glb str_eq : (
; prm     a : * char
; prm     b : * char
;     ) int
section .text
	global	_str_eq
_str_eq:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     a : (@4) : * char
; loc     b : (@6) : * char
; loc     i : (@-2) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; while
; RPN'ized expression: "a i + *u b i + *u && "
; Expanded expression: "(@4) *(2) (@-2) *(2) + *(-1) _Bool [sh&&->5] (@6) *(2) (@-2) *(2) + *(-1) _Bool &&[5] "
L3:
; Fused expression:    "+ *(@4) *(@-2) *(-1) ax _Bool [sh&&->5] + *(@6) *(@-2) *(-1) ax _Bool &&[5]  "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L4
; {
; if
; RPN'ized expression: "a i + *u b i + *u != "
; Expanded expression: "(@4) *(2) (@-2) *(2) + *(-1) (@6) *(2) (@-2) *(2) + *(-1) != "
; Fused expression:    "+ *(@4) *(@-2) push-ax + *(@6) *(@-2) != **sp *ax IF! "
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
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L1
L6:
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; }
	jmp	L3
L4:
; return
; RPN'ized expression: "a i + *u b i + *u == "
; Expanded expression: "(@4) *(2) (@-2) *(2) + *(-1) (@6) *(2) (@-2) *(2) + *(-1) == "
; Fused expression:    "+ *(@4) *(@-2) push-ax + *(@6) *(@-2) == **sp *ax  "
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

; glb str_copy : (
; prm     dst : * char
; prm     src : * char
; prm     max : int
;     ) void
section .text
	global	_str_copy
_str_copy:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     dst : (@4) : * char
; loc     src : (@6) : * char
; loc     max : (@8) : int
; loc     i : (@-2) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; while
; RPN'ized expression: "src i + *u i max 1 - < && "
; Expanded expression: "(@6) *(2) (@-2) *(2) + *(-1) _Bool [sh&&->12] (@-2) *(2) (@8) *(2) 1 - < &&[12] "
L10:
; Fused expression:    "+ *(@6) *(@-2) *(-1) ax _Bool [sh&&->12] - *(@8) 1 < *(@-2) ax &&[12]  "
	mov	ax, [bp+6]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L11
; {
; RPN'ized expression: "dst i + *u src i + *u = "
; Expanded expression: "(@4) *(2) (@-2) *(2) + (@6) *(2) (@-2) *(2) + *(-1) =(-1) "
; Fused expression:    "+ *(@4) *(@-2) push-ax + *(@6) *(@-2) =(119) **sp *ax "
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
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; }
	jmp	L10
L11:
; RPN'ized expression: "dst i + *u 0 = "
; Expanded expression: "(@4) *(2) (@-2) *(2) + 0 =(-1) "
; Fused expression:    "+ *(@4) *(@-2) =(122) *ax 0 "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
L8:
	leave
	ret

; glb clean_token : (
; prm     dst : * char
; prm     src : * char
;     ) void
section .text
	global	_clean_token
_clean_token:
	push	bp
	mov	bp, sp
	 sub	sp,          6
; loc     dst : (@4) : * char
; loc     src : (@6) : * char
; loc     i : (@-2) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; loc     j : (@-4) : int
; RPN'ized expression: "j 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; while
; RPN'ized expression: "src i + *u "
; Expanded expression: "(@6) *(2) (@-2) *(2) + *(-1) "
L15:
; Fused expression:    "+ *(@6) *(@-2) *(-1) ax  "
	mov	ax, [bp+6]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
; JumpIfZero
	test	ax, ax
	je	L16
; {
; loc         c : (@-6) : char
; RPN'ized expression: "c src i + *u = "
; Expanded expression: "(@-6) (@6) *(2) (@-2) *(2) + *(-1) =(-1) "
; Fused expression:    "+ *(@6) *(@-2) =(167) *(@-6) *ax "
	mov	ax, [bp+6]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-6], ax
; if
; RPN'ized expression: "c 32 != c 9 != && c 10 != && c 13 != && c 44 != && "
; Expanded expression: "(@-6) *(-1) 32 != [sh&&->22] (@-6) *(-1) 9 != &&[22] _Bool [sh&&->21] (@-6) *(-1) 10 != &&[21] _Bool [sh&&->20] (@-6) *(-1) 13 != &&[20] _Bool [sh&&->19] (@-6) *(-1) 44 != &&[19] "
; Fused expression:    "!= *(@-6) 32 [sh&&->22] != *(@-6) 9 &&[22] _Bool [sh&&->21] != *(@-6) 10 &&[21] _Bool [sh&&->20] != *(@-6) 13 &&[20] _Bool [sh&&->19] != *(@-6) 44 &&[19]  "
	mov	al, [bp-6]
	cbw
	cmp	ax, 32
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L19
	mov	al, [bp-6]
	cbw
	cmp	ax, 44
	setne	al
	cbw
L19:
; JumpIfZero
	test	ax, ax
	je	L17
; RPN'ized expression: "dst j ++p + *u c = "
; Expanded expression: "(@4) *(2) (@-4) ++p(2) + (@-6) *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-4) + *(@4) ax =(119) *ax *(@-6) "
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
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; }
	jmp	L15
L16:
; RPN'ized expression: "dst j + *u 0 = "
; Expanded expression: "(@4) *(2) (@-4) *(2) + 0 =(-1) "
; Fused expression:    "+ *(@4) *(@-4) =(122) *ax 0 "
	mov	ax, [bp+4]
	add	ax, [bp-4]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
L13:
	leave
	ret

; glb find_label : (
; prm     name : * char
;     ) int
section .text
	global	_find_label
_find_label:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     name : (@4) : * char
; loc     i : (@-2) : int
; for
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
L25:
; RPN'ized expression: "i label_count < "
; Expanded expression: "(@-2) *(2) label_count *(2) < "
; Fused expression:    "< *(@-2) *label_count IF! "
	mov	ax, [bp-2]
	cmp	ax, [_label_count]
	jge	L28
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; if
; RPN'ized expression: "( name , label_table i + *u &u name -> *u str_eq ) "
; Expanded expression: " (@4) *(2)  label_table (@-2) *(2) 18 * + 0 +  str_eq ()4 "
; Fused expression:    "( *(2) (@4) , * *(@-2) 18 + label_table ax + ax 0 , str_eq )4  "
	push	word [bp+4]
	mov	ax, [bp-2]
	imul	ax, ax, 18
	mov	cx, ax
	mov	ax, _label_table
	add	ax, cx
	push	ax
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L29
; return
; RPN'ized expression: "label_table i + *u &u address -> *u "
; Expanded expression: "label_table (@-2) *(2) 18 * + 16 + *(2) "
; Fused expression:    "* *(@-2) 18 + label_table ax + ax 16 *(2) ax  "
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
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L25
L28:
; return
; RPN'ized expression: "1 -u "
; Expanded expression: "-1 "
; Expression value: -1
; Fused expression:    "-1  "
	mov	ax, -1
L23:
	leave
	ret

; glb add_label : (
; prm     name : * char
; prm     addr : int
;     ) void
section .text
	global	_add_label
_add_label:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     name : (@4) : * char
; loc     addr : (@6) : int
; if
; RPN'ized expression: "label_count 64 >= "
; Expanded expression: "label_count *(2) 64 >= "
; Fused expression:    ">= *label_count 64 IF! "
	mov	ax, [_label_count]
	cmp	ax, 64
	jl	L33
; return
	jmp	L31
L33:
; RPN'ized expression: "( 16 , name , label_table label_count + *u &u name -> *u str_copy ) "
; Expanded expression: " 16  (@4) *(2)  label_table label_count *(2) 18 * + 0 +  str_copy ()6 "
; Fused expression:    "( 16 , *(2) (@4) , * *label_count 18 + label_table ax + ax 0 , str_copy )6 "
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
; RPN'ized expression: "label_table label_count + *u &u address -> *u addr = "
; Expanded expression: "label_table label_count *(2) 18 * + 16 + (@6) *(2) =(2) "
; Fused expression:    "* *label_count 18 + label_table ax + ax 16 =(170) *ax *(@6) "
	mov	ax, [_label_count]
	imul	ax, ax, 18
	mov	cx, ax
	mov	ax, _label_table
	add	ax, cx
	add	ax, 16
	mov	bx, ax
	mov	ax, [bp+6]
	mov	[bx], ax
; RPN'ized expression: "label_count ++p "
; Expanded expression: "label_count ++p(2) "
; Fused expression:    "++p(2) *label_count "
	mov	ax, [_label_count]
	inc	word [_label_count]
L31:
	leave
	ret

; glb is_bp_mem : (
; prm     tok : * char
; prm     disp : * int
;     ) int
section .text
	global	_is_bp_mem
_is_bp_mem:
	push	bp
	mov	bp, sp
	 sub	sp,         14
; loc     tok : (@4) : * char
; loc     disp : (@6) : * int
; loc     i : (@-2) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; if
; RPN'ized expression: "tok 0 + *u 91 != "
; Expanded expression: "(@4) *(2) 0 + *(-1) 91 != "
; Fused expression:    "+ *(@4) 0 != *ax 91 IF! "
	mov	ax, [bp+4]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 91
	je	L37
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L35
L37:
; RPN'ized expression: "i 1 = "
; Expanded expression: "(@-2) 1 =(2) "
; Fused expression:    "=(170) *(@-2) 1 "
	mov	ax, 1
	mov	[bp-2], ax
; if
; RPN'ized expression: "tok i + *u 98 == tok i 1 + + *u 112 == && 0 == "
; Expanded expression: "(@4) *(2) (@-2) *(2) + *(-1) 98 == [sh&&->41] (@4) *(2) (@-2) *(2) 1 + + *(-1) 112 == &&[41] 0 == "
; Fused expression:    "+ *(@4) *(@-2) == *ax 98 [sh&&->41] + *(@-2) 1 + *(@4) ax == *ax 112 &&[41] == ax 0 IF! "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 98
	sete	al
	cbw
; JumpIfZero
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
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L35
L39:
; RPN'ized expression: "i 2 += "
; Expanded expression: "(@-2) 2 +=(2) "
; Fused expression:    "+=(170) *(@-2) 2 "
	mov	ax, [bp-2]
	add	ax, 2
	mov	[bp-2], ax
; if
; RPN'ized expression: "tok i + *u 93 == "
; Expanded expression: "(@4) *(2) (@-2) *(2) + *(-1) 93 == "
; Fused expression:    "+ *(@4) *(@-2) == *ax 93 IF! "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 93
	jne	L42
; {
; RPN'ized expression: "disp *u 0 = "
; Expanded expression: "(@6) *(2) 0 =(2) "
; Fused expression:    "*(2) (@6) =(170) *ax 0 "
	mov	ax, [bp+6]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], ax
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1  "
	mov	ax, 1
	jmp	L35
; }
L42:
; if
; RPN'ized expression: "tok i + *u 43 != tok i + *u 45 != && "
; Expanded expression: "(@4) *(2) (@-2) *(2) + *(-1) 43 != [sh&&->46] (@4) *(2) (@-2) *(2) + *(-1) 45 != &&[46] "
; Fused expression:    "+ *(@4) *(@-2) != *ax 43 [sh&&->46] + *(@4) *(@-2) != *ax 45 &&[46]  "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 43
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L44
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L35
L44:
; {
; loc         sign : (@-4) : int
; RPN'ized expression: "sign tok i + *u 45 == 1 1 -u ? = "
; Expanded expression: "(@-4) (@4) *(2) (@-2) *(2) + *(-1) 45 == [sh||->47] 1 goto &&[47] -1 &&[48] =(2) "
; Fused expression:    "+ *(@4) *(@-2) == *ax 45 [sh||->47] 1 [goto->48] &&[47] -1 &&[48] =(170) *(@-4) ax "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 45
	sete	al
	cbw
; JumpIfNotZero
	test	ax, ax
	jne	L47
	mov	ax, 1
	jmp	L48
L47:
	mov	ax, -1
L48:
	mov	[bp-4], ax
; RPN'ized expression: "8 "
; Expanded expression: "8 "
; Expression value: 8
; loc         num : (@-12) : [8u] char
; loc         n : (@-14) : int
; RPN'ized expression: "n 0 = "
; Expanded expression: "(@-14) 0 =(2) "
; Fused expression:    "=(170) *(@-14) 0 "
	mov	ax, 0
	mov	[bp-14], ax
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; while
; RPN'ized expression: "tok i + *u tok i + *u 93 != && "
; Expanded expression: "(@4) *(2) (@-2) *(2) + *(-1) _Bool [sh&&->51] (@4) *(2) (@-2) *(2) + *(-1) 93 != &&[51] "
L49:
; Fused expression:    "+ *(@4) *(@-2) *(-1) ax _Bool [sh&&->51] + *(@4) *(@-2) != *ax 93 &&[51]  "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L50
; {
; if
; RPN'ized expression: "n 7 < "
; Expanded expression: "(@-14) *(2) 7 < "
; Fused expression:    "< *(@-14) 7 IF! "
	mov	ax, [bp-14]
	cmp	ax, 7
	jge	L52
; RPN'ized expression: "num n ++p + *u tok i + *u = "
; Expanded expression: "(@-12) (@-14) ++p(2) + (@4) *(2) (@-2) *(2) + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-14) + (@-12) ax push-ax + *(@4) *(@-2) =(119) **sp *ax "
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
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; }
	jmp	L49
L50:
; RPN'ized expression: "num n + *u 0 = "
; Expanded expression: "(@-12) (@-14) *(2) + 0 =(-1) "
; Fused expression:    "+ (@-12) *(@-14) =(122) *ax 0 "
	lea	ax, [bp-12]
	add	ax, [bp-14]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; RPN'ized expression: "disp *u sign ( num , 11 syscal ) * = "
; Expanded expression: "(@6) *(2) (@-4) *(2)  (@-12)  11  syscal ()4 * =(2) "
; Fused expression:    "*(2) (@6) push-ax ( (@-12) , 11 , syscal )4 * *(@-4) ax =(170) **sp ax "
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
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1  "
	mov	ax, 1
	jmp	L35
; }
L35:
	leave
	ret

; glb reg_id : (
; prm     r : * char
;     ) int
section .text
	global	_reg_id
_reg_id:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     r : (@4) : * char
; if

section .rodata
L58:
	db	"ax"
	times	1 db 0

section .text
; RPN'ized expression: "( L58 , r str_eq ) "
; Expanded expression: " L58  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L58 , *(2) (@4) , str_eq )4  "
	push	L58
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L56
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L54
L56:
; if

section .rodata
L61:
	db	"cx"
	times	1 db 0

section .text
; RPN'ized expression: "( L61 , r str_eq ) "
; Expanded expression: " L61  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L61 , *(2) (@4) , str_eq )4  "
	push	L61
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L59
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1  "
	mov	ax, 1
	jmp	L54
L59:
; if

section .rodata
L64:
	db	"dx"
	times	1 db 0

section .text
; RPN'ized expression: "( L64 , r str_eq ) "
; Expanded expression: " L64  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L64 , *(2) (@4) , str_eq )4  "
	push	L64
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L62
; return
; RPN'ized expression: "2 "
; Expanded expression: "2 "
; Expression value: 2
; Fused expression:    "2  "
	mov	ax, 2
	jmp	L54
L62:
; if

section .rodata
L67:
	db	"bx"
	times	1 db 0

section .text
; RPN'ized expression: "( L67 , r str_eq ) "
; Expanded expression: " L67  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L67 , *(2) (@4) , str_eq )4  "
	push	L67
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L65
; return
; RPN'ized expression: "3 "
; Expanded expression: "3 "
; Expression value: 3
; Fused expression:    "3  "
	mov	ax, 3
	jmp	L54
L65:
; if

section .rodata
L70:
	db	"sp"
	times	1 db 0

section .text
; RPN'ized expression: "( L70 , r str_eq ) "
; Expanded expression: " L70  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L70 , *(2) (@4) , str_eq )4  "
	push	L70
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L68
; return
; RPN'ized expression: "4 "
; Expanded expression: "4 "
; Expression value: 4
; Fused expression:    "4  "
	mov	ax, 4
	jmp	L54
L68:
; if

section .rodata
L73:
	db	"bp"
	times	1 db 0

section .text
; RPN'ized expression: "( L73 , r str_eq ) "
; Expanded expression: " L73  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L73 , *(2) (@4) , str_eq )4  "
	push	L73
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L71
; return
; RPN'ized expression: "5 "
; Expanded expression: "5 "
; Expression value: 5
; Fused expression:    "5  "
	mov	ax, 5
	jmp	L54
L71:
; if

section .rodata
L76:
	db	"si"
	times	1 db 0

section .text
; RPN'ized expression: "( L76 , r str_eq ) "
; Expanded expression: " L76  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L76 , *(2) (@4) , str_eq )4  "
	push	L76
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L74
; return
; RPN'ized expression: "6 "
; Expanded expression: "6 "
; Expression value: 6
; Fused expression:    "6  "
	mov	ax, 6
	jmp	L54
L74:
; if

section .rodata
L79:
	db	"di"
	times	1 db 0

section .text
; RPN'ized expression: "( L79 , r str_eq ) "
; Expanded expression: " L79  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L79 , *(2) (@4) , str_eq )4  "
	push	L79
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L77
; return
; RPN'ized expression: "7 "
; Expanded expression: "7 "
; Expression value: 7
; Fused expression:    "7  "
	mov	ax, 7
	jmp	L54
L77:
; return
; RPN'ized expression: "1 -u "
; Expanded expression: "-1 "
; Expression value: -1
; Fused expression:    "-1  "
	mov	ax, -1
L54:
	leave
	ret

; glb emit1 : (
; prm     pass : int
; prm     b0 : unsigned char
;     ) void
section .text
	global	_emit1
_emit1:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     pass : (@4) : int
; loc     b0 : (@6) : unsigned char
; if
; RPN'ized expression: "pass "
; Expanded expression: "(@4) *(2) "
; Fused expression:    "*(2) (@4)  "
	mov	ax, [bp+4]
; JumpIfZero
	test	ax, ax
	je	L82
; RPN'ized expression: "output_binary binary_size + *u b0 = "
; Expanded expression: "output_binary binary_size *(2) + (@6) *(1) =(1) "
; Fused expression:    "+ output_binary *binary_size =(153) *ax *(@6) "
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	al, [bp+6]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
L82:
; RPN'ized expression: "binary_size ++p "
; Expanded expression: "binary_size ++p(2) "
; Fused expression:    "++p(2) *binary_size "
	mov	ax, [_binary_size]
	inc	word [_binary_size]
L80:
	leave
	ret

; glb emit2 : (
; prm     pass : int
; prm     b0 : unsigned char
; prm     b1 : unsigned char
;     ) void
section .text
	global	_emit2
_emit2:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     pass : (@4) : int
; loc     b0 : (@6) : unsigned char
; loc     b1 : (@8) : unsigned char
; if
; RPN'ized expression: "pass "
; Expanded expression: "(@4) *(2) "
; Fused expression:    "*(2) (@4)  "
	mov	ax, [bp+4]
; JumpIfZero
	test	ax, ax
	je	L86
; {
; RPN'ized expression: "output_binary binary_size + *u b0 = "
; Expanded expression: "output_binary binary_size *(2) + (@6) *(1) =(1) "
; Fused expression:    "+ output_binary *binary_size =(153) *ax *(@6) "
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	al, [bp+6]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
; RPN'ized expression: "output_binary binary_size 1 + + *u b1 = "
; Expanded expression: "output_binary binary_size *(2) 1 + + (@8) *(1) =(1) "
; Fused expression:    "+ *binary_size 1 + output_binary ax =(153) *ax *(@8) "
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
; }
L86:
; RPN'ized expression: "binary_size 2 += "
; Expanded expression: "binary_size 2 +=(2) "
; Fused expression:    "+=(170) *binary_size 2 "
	mov	ax, [_binary_size]
	add	ax, 2
	mov	[_binary_size], ax
L84:
	leave
	ret

; glb emit3 : (
; prm     pass : int
; prm     b0 : unsigned char
; prm     b1 : unsigned char
; prm     b2 : unsigned char
;     ) void
section .text
	global	_emit3
_emit3:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     pass : (@4) : int
; loc     b0 : (@6) : unsigned char
; loc     b1 : (@8) : unsigned char
; loc     b2 : (@10) : unsigned char
; if
; RPN'ized expression: "pass "
; Expanded expression: "(@4) *(2) "
; Fused expression:    "*(2) (@4)  "
	mov	ax, [bp+4]
; JumpIfZero
	test	ax, ax
	je	L90
; {
; RPN'ized expression: "output_binary binary_size + *u b0 = "
; Expanded expression: "output_binary binary_size *(2) + (@6) *(1) =(1) "
; Fused expression:    "+ output_binary *binary_size =(153) *ax *(@6) "
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	al, [bp+6]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
; RPN'ized expression: "output_binary binary_size 1 + + *u b1 = "
; Expanded expression: "output_binary binary_size *(2) 1 + + (@8) *(1) =(1) "
; Fused expression:    "+ *binary_size 1 + output_binary ax =(153) *ax *(@8) "
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
; RPN'ized expression: "output_binary binary_size 2 + + *u b2 = "
; Expanded expression: "output_binary binary_size *(2) 2 + + (@10) *(1) =(1) "
; Fused expression:    "+ *binary_size 2 + output_binary ax =(153) *ax *(@10) "
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
; }
L90:
; RPN'ized expression: "binary_size 3 += "
; Expanded expression: "binary_size 3 +=(2) "
; Fused expression:    "+=(170) *binary_size 3 "
	mov	ax, [_binary_size]
	add	ax, 3
	mov	[_binary_size], ax
L88:
	leave
	ret

; glb emit4 : (
; prm     pass : int
; prm     b0 : unsigned char
; prm     b1 : unsigned char
; prm     b2 : unsigned char
; prm     b3 : unsigned char
;     ) void
section .text
	global	_emit4
_emit4:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     pass : (@4) : int
; loc     b0 : (@6) : unsigned char
; loc     b1 : (@8) : unsigned char
; loc     b2 : (@10) : unsigned char
; loc     b3 : (@12) : unsigned char
; if
; RPN'ized expression: "pass "
; Expanded expression: "(@4) *(2) "
; Fused expression:    "*(2) (@4)  "
	mov	ax, [bp+4]
; JumpIfZero
	test	ax, ax
	je	L94
; {
; RPN'ized expression: "output_binary binary_size + *u b0 = "
; Expanded expression: "output_binary binary_size *(2) + (@6) *(1) =(1) "
; Fused expression:    "+ output_binary *binary_size =(153) *ax *(@6) "
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	al, [bp+6]
	mov	ah, 0
	mov	[bx], al
	mov	ah, 0
; RPN'ized expression: "output_binary binary_size 1 + + *u b1 = "
; Expanded expression: "output_binary binary_size *(2) 1 + + (@8) *(1) =(1) "
; Fused expression:    "+ *binary_size 1 + output_binary ax =(153) *ax *(@8) "
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
; RPN'ized expression: "output_binary binary_size 2 + + *u b2 = "
; Expanded expression: "output_binary binary_size *(2) 2 + + (@10) *(1) =(1) "
; Fused expression:    "+ *binary_size 2 + output_binary ax =(153) *ax *(@10) "
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
; RPN'ized expression: "output_binary binary_size 3 + + *u b3 = "
; Expanded expression: "output_binary binary_size *(2) 3 + + (@12) *(1) =(1) "
; Fused expression:    "+ *binary_size 3 + output_binary ax =(153) *ax *(@12) "
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
; }
L94:
; RPN'ized expression: "binary_size 4 += "
; Expanded expression: "binary_size 4 +=(2) "
; Fused expression:    "+=(170) *binary_size 4 "
	mov	ax, [_binary_size]
	add	ax, 4
	mov	[_binary_size], ax
L92:
	leave
	ret

; glb resolve_imm : (
; prm     tok : * char
;     ) int
section .text
	global	_resolve_imm
_resolve_imm:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     tok : (@4) : * char
; loc     v : (@-2) : int
; RPN'ized expression: "v ( tok find_label ) = "
; Expanded expression: "(@-2)  (@4) *(2)  find_label ()2 =(2) "
; Fused expression:    "( *(2) (@4) , find_label )2 =(170) *(@-2) ax "
	push	word [bp+4]
	call	_find_label
	sub	sp, -2
	mov	[bp-2], ax
; if
; RPN'ized expression: "v 1 -u == "
; Expanded expression: "(@-2) *(2) -1 == "
; Fused expression:    "== *(@-2) -1 IF! "
	mov	ax, [bp-2]
	cmp	ax, -1
	jne	L98
; RPN'ized expression: "v ( tok , 11 syscal ) = "
; Expanded expression: "(@-2)  (@4) *(2)  11  syscal ()4 =(2) "
; Fused expression:    "( *(2) (@4) , 11 , syscal )4 =(170) *(@-2) ax "
	push	word [bp+4]
	push	11
	call	_syscal
	sub	sp, -4
	mov	[bp-2], ax
L98:
; return
; RPN'ized expression: "v "
; Expanded expression: "(@-2) *(2) "
; Fused expression:    "*(2) (@-2)  "
	mov	ax, [bp-2]
L96:
	leave
	ret

; glb emit_db : (
; prm     args : * char
; prm     pass : int
;     ) void
section .text
	global	_emit_db
_emit_db:
	push	bp
	mov	bp, sp
	 sub	sp,         14
; loc     args : (@4) : * char
; loc     pass : (@6) : int
; loc     i : (@-2) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; while
; RPN'ized expression: "args i + *u 32 == args i + *u 9 == || "
; Expanded expression: "(@4) *(2) (@-2) *(2) + *(-1) 32 == [sh||->104] (@4) *(2) (@-2) *(2) + *(-1) 9 == ||[104] "
L102:
; Fused expression:    "+ *(@4) *(@-2) == *ax 32 [sh||->104] + *(@4) *(@-2) == *ax 9 ||[104]  "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	sete	al
	cbw
; JumpIfNotZero
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
; JumpIfZero
	test	ax, ax
	je	L103
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L102
L103:
; if
; RPN'ized expression: "args i + *u 34 == "
; Expanded expression: "(@4) *(2) (@-2) *(2) + *(-1) 34 == "
; Fused expression:    "+ *(@4) *(@-2) == *ax 34 IF! "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 34
	jne	L105
; {
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; while
; RPN'ized expression: "args i + *u 34 != args i + *u && "
; Expanded expression: "(@4) *(2) (@-2) *(2) + *(-1) 34 != [sh&&->109] (@4) *(2) (@-2) *(2) + *(-1) _Bool &&[109] "
L107:
; Fused expression:    "+ *(@4) *(@-2) != *ax 34 [sh&&->109] + *(@4) *(@-2) *(-1) ax _Bool &&[109]  "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 34
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L108
; {
; loc             <something> : unsigned char
; RPN'ized expression: "( args i + *u (something110) , pass emit1 ) "
; Expanded expression: " (@4) *(2) (@-2) *(2) + *(-1) unsigned char  (@6) *(2)  emit1 ()4 "
; Fused expression:    "( + *(@4) *(@-2) *(-1) ax unsigned char , *(2) (@6) , emit1 )4 "
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
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; }
	jmp	L107
L108:
; }
	jmp	L106
L105:
; else
; {
; RPN'ized expression: "8 "
; Expanded expression: "8 "
; Expression value: 8
; loc         num : (@-10) : [8u] char
; loc         n : (@-12) : int
; RPN'ized expression: "n 0 = "
; Expanded expression: "(@-12) 0 =(2) "
; Fused expression:    "=(170) *(@-12) 0 "
	mov	ax, 0
	mov	[bp-12], ax
; while
; RPN'ized expression: "args i + *u "
; Expanded expression: "(@4) *(2) (@-2) *(2) + *(-1) "
L111:
; Fused expression:    "+ *(@4) *(@-2) *(-1) ax  "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
; JumpIfZero
	test	ax, ax
	je	L112
; {
; loc             c : (@-14) : char
; RPN'ized expression: "c args i + *u = "
; Expanded expression: "(@-14) (@4) *(2) (@-2) *(2) + *(-1) =(-1) "
; Fused expression:    "+ *(@4) *(@-2) =(167) *(@-14) *ax "
	mov	ax, [bp+4]
	add	ax, [bp-2]
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-14], ax
; if
; RPN'ized expression: "c 32 != c 9 != && c 44 != && c 10 != && c 59 != && "
; Expanded expression: "(@-14) *(-1) 32 != [sh&&->118] (@-14) *(-1) 9 != &&[118] _Bool [sh&&->117] (@-14) *(-1) 44 != &&[117] _Bool [sh&&->116] (@-14) *(-1) 10 != &&[116] _Bool [sh&&->115] (@-14) *(-1) 59 != &&[115] "
; Fused expression:    "!= *(@-14) 32 [sh&&->118] != *(@-14) 9 &&[118] _Bool [sh&&->117] != *(@-14) 44 &&[117] _Bool [sh&&->116] != *(@-14) 10 &&[116] _Bool [sh&&->115] != *(@-14) 59 &&[115]  "
	mov	al, [bp-14]
	cbw
	cmp	ax, 32
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L115
	mov	al, [bp-14]
	cbw
	cmp	ax, 59
	setne	al
	cbw
L115:
; JumpIfZero
	test	ax, ax
	je	L113
; {
; if
; RPN'ized expression: "n 7 < "
; Expanded expression: "(@-12) *(2) 7 < "
; Fused expression:    "< *(@-12) 7 IF! "
	mov	ax, [bp-12]
	cmp	ax, 7
	jge	L119
; RPN'ized expression: "num n ++p + *u c = "
; Expanded expression: "(@-10) (@-12) ++p(2) + (@-14) *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-12) + (@-10) ax =(119) *ax *(@-14) "
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
; }
	jmp	L114
L113:
; else
; if
; RPN'ized expression: "n 0 > "
; Expanded expression: "(@-12) *(2) 0 > "
; Fused expression:    "> *(@-12) 0 IF! "
	mov	ax, [bp-12]
	cmp	ax, 0
	jle	L121
; {
; RPN'ized expression: "num n + *u 0 = "
; Expanded expression: "(@-10) (@-12) *(2) + 0 =(-1) "
; Fused expression:    "+ (@-10) *(@-12) =(122) *ax 0 "
	lea	ax, [bp-10]
	add	ax, [bp-12]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; loc                 <something> : unsigned char
; RPN'ized expression: "( ( num , 11 syscal ) (something123) , pass emit1 ) "
; Expanded expression: "  (@-10)  11  syscal ()4 unsigned char  (@6) *(2)  emit1 ()4 "
; Fused expression:    "( ( (@-10) , 11 , syscal )4 unsigned char , *(2) (@6) , emit1 )4 "
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
; RPN'ized expression: "n 0 = "
; Expanded expression: "(@-12) 0 =(2) "
; Fused expression:    "=(170) *(@-12) 0 "
	mov	ax, 0
	mov	[bp-12], ax
; }
L121:
L114:
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; }
	jmp	L111
L112:
; if
; RPN'ized expression: "n 0 > "
; Expanded expression: "(@-12) *(2) 0 > "
; Fused expression:    "> *(@-12) 0 IF! "
	mov	ax, [bp-12]
	cmp	ax, 0
	jle	L124
; {
; RPN'ized expression: "num n + *u 0 = "
; Expanded expression: "(@-10) (@-12) *(2) + 0 =(-1) "
; Fused expression:    "+ (@-10) *(@-12) =(122) *ax 0 "
	lea	ax, [bp-10]
	add	ax, [bp-12]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; loc             <something> : unsigned char
; RPN'ized expression: "( ( num , 11 syscal ) (something126) , pass emit1 ) "
; Expanded expression: "  (@-10)  11  syscal ()4 unsigned char  (@6) *(2)  emit1 ()4 "
; Fused expression:    "( ( (@-10) , 11 , syscal )4 unsigned char , *(2) (@6) , emit1 )4 "
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
; }
L124:
; }
L106:
L100:
	leave
	ret

; glb assemble_line : (
; prm     op : * char
; prm     a1 : * char
; prm     a2 : * char
; prm     pass : int
;     ) void
section .text
	global	_assemble_line
_assemble_line:
	push	bp
	mov	bp, sp
	 sub	sp,         72
; loc     op : (@4) : * char
; loc     a1 : (@6) : * char
; loc     a2 : (@8) : * char
; loc     pass : (@10) : int
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
; loc     c1 : (@-32) : [32u] char
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
; loc     c2 : (@-64) : [32u] char
; RPN'ized expression: "( a1 , c1 clean_token ) "
; Expanded expression: " (@6) *(2)  (@-32)  clean_token ()4 "
; Fused expression:    "( *(2) (@6) , (@-32) , clean_token )4 "
	push	word [bp+6]
	lea	ax, [bp-32]
	push	ax
	call	_clean_token
	sub	sp, -4
; RPN'ized expression: "( a2 , c2 clean_token ) "
; Expanded expression: " (@8) *(2)  (@-64)  clean_token ()4 "
; Fused expression:    "( *(2) (@8) , (@-64) , clean_token )4 "
	push	word [bp+8]
	lea	ax, [bp-64]
	push	ax
	call	_clean_token
	sub	sp, -4
; loc     r1 : (@-66) : int
; RPN'ized expression: "r1 ( c1 reg_id ) = "
; Expanded expression: "(@-66)  (@-32)  reg_id ()2 =(2) "
; Fused expression:    "( (@-32) , reg_id )2 =(170) *(@-66) ax "
	lea	ax, [bp-32]
	push	ax
	call	_reg_id
	sub	sp, -2
	mov	[bp-66], ax
; loc     r2 : (@-68) : int
; RPN'ized expression: "r2 ( c2 reg_id ) = "
; Expanded expression: "(@-68)  (@-64)  reg_id ()2 =(2) "
; Fused expression:    "( (@-64) , reg_id )2 =(170) *(@-68) ax "
	lea	ax, [bp-64]
	push	ax
	call	_reg_id
	sub	sp, -2
	mov	[bp-68], ax
; if

section .rodata
L131:
	db	"db"
	times	1 db 0

section .text
; RPN'ized expression: "( L131 , op str_eq ) "
; Expanded expression: " L131  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L131 , *(2) (@4) , str_eq )4  "
	push	L131
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L129
; {
; RPN'ized expression: "( pass , a1 emit_db ) "
; Expanded expression: " (@10) *(2)  (@6) *(2)  emit_db ()4 "
; Fused expression:    "( *(2) (@10) , *(2) (@6) , emit_db )4 "
	push	word [bp+10]
	push	word [bp+6]
	call	_emit_db
	sub	sp, -4
; return
	jmp	L127
; }
L129:
; if

section .rodata
L134:
	db	"nop"
	times	1 db 0

section .text
; RPN'ized expression: "( L134 , op str_eq ) "
; Expanded expression: " L134  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L134 , *(2) (@4) , str_eq )4  "
	push	L134
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L132
; {
; RPN'ized expression: "( 144 , pass emit1 ) "
; Expanded expression: " 144  (@10) *(2)  emit1 ()4 "
; Fused expression:    "( 144 , *(2) (@10) , emit1 )4 "
	push	144
	push	word [bp+10]
	call	_emit1
	sub	sp, -4
; return
	jmp	L127
; }
L132:
; if

section .rodata
L137:
	db	"ret"
	times	1 db 0

section .text
; RPN'ized expression: "( L137 , op str_eq ) "
; Expanded expression: " L137  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L137 , *(2) (@4) , str_eq )4  "
	push	L137
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L135
; {
; RPN'ized expression: "( 195 , pass emit1 ) "
; Expanded expression: " 195  (@10) *(2)  emit1 ()4 "
; Fused expression:    "( 195 , *(2) (@10) , emit1 )4 "
	push	195
	push	word [bp+10]
	call	_emit1
	sub	sp, -4
; return
	jmp	L127
; }
L135:
; if

section .rodata
L140:
	db	"int"
	times	1 db 0

section .text
; RPN'ized expression: "( L140 , op str_eq ) "
; Expanded expression: " L140  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L140 , *(2) (@4) , str_eq )4  "
	push	L140
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L138
; {
; loc         <something> : unsigned char
; RPN'ized expression: "( ( c1 , 11 syscal ) (something141) , 205 , pass emit2 ) "
; Expanded expression: "  (@-32)  11  syscal ()4 unsigned char  205  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( ( (@-32) , 11 , syscal )4 unsigned char , 205 , *(2) (@10) , emit2 )6 "
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
; return
	jmp	L127
; }
L138:
; if

section .rodata
L144:
	db	"push"
	times	1 db 0

section .text
; RPN'ized expression: "( L144 , op str_eq ) "
; Expanded expression: " L144  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L144 , *(2) (@4) , str_eq )4  "
	push	L144
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L142
; {
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L145
; {
; RPN'ized expression: "( 80 r1 + , pass emit1 ) "
; Expanded expression: " 80 (@-66) *(2) +  (@10) *(2)  emit1 ()4 "
; Fused expression:    "( + 80 *(@-66) , *(2) (@10) , emit1 )4 "
	mov	ax, 80
	add	ax, [bp-66]
	push	ax
	push	word [bp+10]
	call	_emit1
	sub	sp, -4
; return
	jmp	L127
; }
L145:
; loc         v : (@-70) : int
; RPN'ized expression: "v ( c1 resolve_imm ) = "
; Expanded expression: "(@-70)  (@-32)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-32) , resolve_imm )2 =(170) *(@-70) ax "
	lea	ax, [bp-32]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
; loc         <something> : unsigned char
; loc         <something> : unsigned char
; RPN'ized expression: "( v 8 >> 255 & (something148) , v 255 & (something147) , 104 , pass emit3 ) "
; Expanded expression: " (@-70) *(2) 8 >> 255 & unsigned char  (@-70) *(2) 255 & unsigned char  104  (@10) *(2)  emit3 ()8 "
; Fused expression:    "( >> *(@-70) 8 & ax 255 unsigned char , & *(@-70) 255 unsigned char , 104 , *(2) (@10) , emit3 )8 "
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
; return
	jmp	L127
; }
L142:
; if

section .rodata
L151:
	db	"pop"
	times	1 db 0

section .text
; RPN'ized expression: "( L151 , op str_eq ) "
; Expanded expression: " L151  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L151 , *(2) (@4) , str_eq )4  "
	push	L151
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L149
; {
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L152
; {
; RPN'ized expression: "( 88 r1 + , pass emit1 ) "
; Expanded expression: " 88 (@-66) *(2) +  (@10) *(2)  emit1 ()4 "
; Fused expression:    "( + 88 *(@-66) , *(2) (@10) , emit1 )4 "
	mov	ax, 88
	add	ax, [bp-66]
	push	ax
	push	word [bp+10]
	call	_emit1
	sub	sp, -4
; return
	jmp	L127
; }
L152:
; return
	jmp	L127
; }
L149:
; if

section .rodata
L156:
	db	"mov"
	times	1 db 0

section .text
; RPN'ized expression: "( L156 , op str_eq ) "
; Expanded expression: " L156  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L156 , *(2) (@4) , str_eq )4  "
	push	L156
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L154
; {
; loc         disp : (@-70) : int
; if
; RPN'ized expression: "r1 1 -u != ( disp &u , c2 is_bp_mem ) && "
; Expanded expression: "(@-66) *(2) -1 != [sh&&->159]  (@-70)  (@-64)  is_bp_mem ()4 _Bool &&[159] "
; Fused expression:    "!= *(@-66) -1 [sh&&->159] ( (@-70) , (@-64) , is_bp_mem )4 _Bool &&[159]  "
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L157
; {
; loc             <something> : unsigned char
; RPN'ized expression: "( disp 255 & (something160) , 70 r1 3 << + , 139 , pass emit3 ) "
; Expanded expression: " (@-70) *(2) 255 & unsigned char  70 (@-66) *(2) 3 << +  139  (@10) *(2)  emit3 ()8 "
; Fused expression:    "( & *(@-70) 255 unsigned char , << *(@-66) 3 + 70 ax , 139 , *(2) (@10) , emit3 )8 "
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
; return
	jmp	L127
; }
L157:
; if
; RPN'ized expression: "( disp &u , c1 is_bp_mem ) r2 1 -u != && "
; Expanded expression: " (@-70)  (@-32)  is_bp_mem ()4 _Bool [sh&&->163] (@-68) *(2) -1 != &&[163] "
; Fused expression:    "( (@-70) , (@-32) , is_bp_mem )4 _Bool [sh&&->163] != *(@-68) -1 &&[163]  "
	lea	ax, [bp-70]
	push	ax
	lea	ax, [bp-32]
	push	ax
	call	_is_bp_mem
	sub	sp, -4
	test	ax, ax
	setne	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L163
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L163:
; JumpIfZero
	test	ax, ax
	je	L161
; {
; loc             <something> : unsigned char
; RPN'ized expression: "( disp 255 & (something164) , 70 r2 3 << + , 137 , pass emit3 ) "
; Expanded expression: " (@-70) *(2) 255 & unsigned char  70 (@-68) *(2) 3 << +  137  (@10) *(2)  emit3 ()8 "
; Fused expression:    "( & *(@-70) 255 unsigned char , << *(@-68) 3 + 70 ax , 137 , *(2) (@10) , emit3 )8 "
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
; return
	jmp	L127
; }
L161:
; if
; RPN'ized expression: "( disp &u , c1 is_bp_mem ) r2 1 -u == && "
; Expanded expression: " (@-70)  (@-32)  is_bp_mem ()4 _Bool [sh&&->167] (@-68) *(2) -1 == &&[167] "
; Fused expression:    "( (@-70) , (@-32) , is_bp_mem )4 _Bool [sh&&->167] == *(@-68) -1 &&[167]  "
	lea	ax, [bp-70]
	push	ax
	lea	ax, [bp-32]
	push	ax
	call	_is_bp_mem
	sub	sp, -4
	test	ax, ax
	setne	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L167
	mov	ax, [bp-68]
	cmp	ax, -1
	sete	al
	cbw
L167:
; JumpIfZero
	test	ax, ax
	je	L165
; {
; loc             v : (@-72) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-72)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-72) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-72], ax
; if
; RPN'ized expression: "pass "
; Expanded expression: "(@10) *(2) "
; Fused expression:    "*(2) (@10)  "
	mov	ax, [bp+10]
; JumpIfZero
	test	ax, ax
	je	L168
; {
; RPN'ized expression: "output_binary binary_size + *u 199 = "
; Expanded expression: "output_binary binary_size *(2) + 199 =(1) "
; Fused expression:    "+ output_binary *binary_size =(154) *ax 199 "
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 199
	mov	[bx], al
	mov	ah, 0
; RPN'ized expression: "output_binary binary_size 1 + + *u 70 = "
; Expanded expression: "output_binary binary_size *(2) 1 + + 70 =(1) "
; Fused expression:    "+ *binary_size 1 + output_binary ax =(154) *ax 70 "
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	ax, 70
	mov	[bx], al
	mov	ah, 0
; loc                 <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 2 + + *u disp 255 & (something170) = "
; Expanded expression: "output_binary binary_size *(2) 2 + + (@-70) *(2) 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 2 + output_binary ax push-ax & *(@-70) 255 unsigned char =(154) **sp ax "
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
; loc                 <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 3 + + *u v 255 & (something171) = "
; Expanded expression: "output_binary binary_size *(2) 3 + + (@-72) *(2) 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 3 + output_binary ax push-ax & *(@-72) 255 unsigned char =(154) **sp ax "
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
; loc                 <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 4 + + *u v 8 >> 255 & (something172) = "
; Expanded expression: "output_binary binary_size *(2) 4 + + (@-72) *(2) 8 >> 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 4 + output_binary ax push-ax >> *(@-72) 8 & ax 255 unsigned char =(154) **sp ax "
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
; }
L168:
; RPN'ized expression: "binary_size 5 += "
; Expanded expression: "binary_size 5 +=(2) "
; Fused expression:    "+=(170) *binary_size 5 "
	mov	ax, [_binary_size]
	add	ax, 5
	mov	[_binary_size], ax
; return
	jmp	L127
; }
L165:
; if
; RPN'ized expression: "r1 1 -u != r2 1 -u != && "
; Expanded expression: "(@-66) *(2) -1 != [sh&&->175] (@-68) *(2) -1 != &&[175] "
; Fused expression:    "!= *(@-66) -1 [sh&&->175] != *(@-68) -1 &&[175]  "
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L175
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L175:
; JumpIfZero
	test	ax, ax
	je	L173
; {
; RPN'ized expression: "( 192 r2 3 << + r1 + , 137 , pass emit2 ) "
; Expanded expression: " 192 (@-68) *(2) 3 << + (@-66) *(2) +  137  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( << *(@-68) 3 + 192 ax + ax *(@-66) , 137 , *(2) (@10) , emit2 )6 "
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
; }
	jmp	L174
L173:
; else
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L176
; {
; loc             v : (@-72) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-72)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-72) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-72], ax
; loc             <something> : unsigned char
; loc             <something> : unsigned char
; RPN'ized expression: "( v 8 >> 255 & (something179) , v 255 & (something178) , 184 r1 + , pass emit3 ) "
; Expanded expression: " (@-72) *(2) 8 >> 255 & unsigned char  (@-72) *(2) 255 & unsigned char  184 (@-66) *(2) +  (@10) *(2)  emit3 ()8 "
; Fused expression:    "( >> *(@-72) 8 & ax 255 unsigned char , & *(@-72) 255 unsigned char , + 184 *(@-66) , *(2) (@10) , emit3 )8 "
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
; }
L176:
L174:
; return
	jmp	L127
; }
L154:
; if

section .rodata
L182:
	db	"add"
	times	1 db 0

section .text
; RPN'ized expression: "( L182 , op str_eq ) "
; Expanded expression: " L182  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L182 , *(2) (@4) , str_eq )4  "
	push	L182
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L180
; {
; if
; RPN'ized expression: "r1 1 -u != r2 1 -u != && "
; Expanded expression: "(@-66) *(2) -1 != [sh&&->185] (@-68) *(2) -1 != &&[185] "
; Fused expression:    "!= *(@-66) -1 [sh&&->185] != *(@-68) -1 &&[185]  "
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L185
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L185:
; JumpIfZero
	test	ax, ax
	je	L183
; {
; RPN'ized expression: "( 192 r2 3 << + r1 + , 1 , pass emit2 ) "
; Expanded expression: " 192 (@-68) *(2) 3 << + (@-66) *(2) +  1  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( << *(@-68) 3 + 192 ax + ax *(@-66) , 1 , *(2) (@10) , emit2 )6 "
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
; }
	jmp	L184
L183:
; else
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L186
; {
; loc             v : (@-70) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-70)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-70) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
; loc             <something> : unsigned char
; loc             <something> : unsigned char
; RPN'ized expression: "( v 8 >> 255 & (something189) , v 255 & (something188) , 192 r1 + , 129 , pass emit4 ) "
; Expanded expression: " (@-70) *(2) 8 >> 255 & unsigned char  (@-70) *(2) 255 & unsigned char  192 (@-66) *(2) +  129  (@10) *(2)  emit4 ()10 "
; Fused expression:    "( >> *(@-70) 8 & ax 255 unsigned char , & *(@-70) 255 unsigned char , + 192 *(@-66) , 129 , *(2) (@10) , emit4 )10 "
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
; }
L186:
L184:
; return
	jmp	L127
; }
L180:
; if

section .rodata
L192:
	db	"sub"
	times	1 db 0

section .text
; RPN'ized expression: "( L192 , op str_eq ) "
; Expanded expression: " L192  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L192 , *(2) (@4) , str_eq )4  "
	push	L192
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L190
; {
; if
; RPN'ized expression: "r1 1 -u != r2 1 -u != && "
; Expanded expression: "(@-66) *(2) -1 != [sh&&->195] (@-68) *(2) -1 != &&[195] "
; Fused expression:    "!= *(@-66) -1 [sh&&->195] != *(@-68) -1 &&[195]  "
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L195
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L195:
; JumpIfZero
	test	ax, ax
	je	L193
; {
; RPN'ized expression: "( 192 r2 3 << + r1 + , 41 , pass emit2 ) "
; Expanded expression: " 192 (@-68) *(2) 3 << + (@-66) *(2) +  41  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( << *(@-68) 3 + 192 ax + ax *(@-66) , 41 , *(2) (@10) , emit2 )6 "
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
; }
	jmp	L194
L193:
; else
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L196
; {
; loc             v : (@-70) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-70)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-70) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
; loc             <something> : unsigned char
; loc             <something> : unsigned char
; RPN'ized expression: "( v 8 >> 255 & (something199) , v 255 & (something198) , 232 r1 + , 129 , pass emit4 ) "
; Expanded expression: " (@-70) *(2) 8 >> 255 & unsigned char  (@-70) *(2) 255 & unsigned char  232 (@-66) *(2) +  129  (@10) *(2)  emit4 ()10 "
; Fused expression:    "( >> *(@-70) 8 & ax 255 unsigned char , & *(@-70) 255 unsigned char , + 232 *(@-66) , 129 , *(2) (@10) , emit4 )10 "
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
; }
L196:
L194:
; return
	jmp	L127
; }
L190:
; if

section .rodata
L202:
	db	"mul"
	times	1 db 0

section .text
; RPN'ized expression: "( L202 , op str_eq ) "
; Expanded expression: " L202  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L202 , *(2) (@4) , str_eq )4  "
	push	L202
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L200
; {
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L203
; RPN'ized expression: "( 224 r1 + , 247 , pass emit2 ) "
; Expanded expression: " 224 (@-66) *(2) +  247  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( + 224 *(@-66) , 247 , *(2) (@10) , emit2 )6 "
	mov	ax, 224
	add	ax, [bp-66]
	push	ax
	push	247
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
L203:
; return
	jmp	L127
; }
L200:
; if

section .rodata
L207:
	db	"div"
	times	1 db 0

section .text
; RPN'ized expression: "( L207 , op str_eq ) "
; Expanded expression: " L207  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L207 , *(2) (@4) , str_eq )4  "
	push	L207
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L205
; {
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L208
; RPN'ized expression: "( 240 r1 + , 247 , pass emit2 ) "
; Expanded expression: " 240 (@-66) *(2) +  247  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( + 240 *(@-66) , 247 , *(2) (@10) , emit2 )6 "
	mov	ax, 240
	add	ax, [bp-66]
	push	ax
	push	247
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
L208:
; return
	jmp	L127
; }
L205:
; if

section .rodata
L212:
	db	"inc"
	times	1 db 0

section .text
; RPN'ized expression: "( L212 , op str_eq ) "
; Expanded expression: " L212  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L212 , *(2) (@4) , str_eq )4  "
	push	L212
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L210
; {
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L213
; {
; RPN'ized expression: "( 64 r1 + , pass emit1 ) "
; Expanded expression: " 64 (@-66) *(2) +  (@10) *(2)  emit1 ()4 "
; Fused expression:    "( + 64 *(@-66) , *(2) (@10) , emit1 )4 "
	mov	ax, 64
	add	ax, [bp-66]
	push	ax
	push	word [bp+10]
	call	_emit1
	sub	sp, -4
; return
	jmp	L127
; }
L213:
; return
	jmp	L127
; }
L210:
; if

section .rodata
L217:
	db	"dec"
	times	1 db 0

section .text
; RPN'ized expression: "( L217 , op str_eq ) "
; Expanded expression: " L217  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L217 , *(2) (@4) , str_eq )4  "
	push	L217
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L215
; {
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L218
; {
; RPN'ized expression: "( 72 r1 + , pass emit1 ) "
; Expanded expression: " 72 (@-66) *(2) +  (@10) *(2)  emit1 ()4 "
; Fused expression:    "( + 72 *(@-66) , *(2) (@10) , emit1 )4 "
	mov	ax, 72
	add	ax, [bp-66]
	push	ax
	push	word [bp+10]
	call	_emit1
	sub	sp, -4
; return
	jmp	L127
; }
L218:
; return
	jmp	L127
; }
L215:
; if

section .rodata
L222:
	db	"and"
	times	1 db 0

section .text
; RPN'ized expression: "( L222 , op str_eq ) "
; Expanded expression: " L222  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L222 , *(2) (@4) , str_eq )4  "
	push	L222
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L220
; {
; if
; RPN'ized expression: "r1 1 -u != r2 1 -u != && "
; Expanded expression: "(@-66) *(2) -1 != [sh&&->225] (@-68) *(2) -1 != &&[225] "
; Fused expression:    "!= *(@-66) -1 [sh&&->225] != *(@-68) -1 &&[225]  "
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L225
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L225:
; JumpIfZero
	test	ax, ax
	je	L223
; {
; RPN'ized expression: "( 192 r2 3 << + r1 + , 33 , pass emit2 ) "
; Expanded expression: " 192 (@-68) *(2) 3 << + (@-66) *(2) +  33  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( << *(@-68) 3 + 192 ax + ax *(@-66) , 33 , *(2) (@10) , emit2 )6 "
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
; }
	jmp	L224
L223:
; else
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L226
; {
; loc             v : (@-70) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-70)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-70) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
; loc             <something> : unsigned char
; loc             <something> : unsigned char
; RPN'ized expression: "( v 8 >> 255 & (something229) , v 255 & (something228) , 224 r1 + , 129 , pass emit4 ) "
; Expanded expression: " (@-70) *(2) 8 >> 255 & unsigned char  (@-70) *(2) 255 & unsigned char  224 (@-66) *(2) +  129  (@10) *(2)  emit4 ()10 "
; Fused expression:    "( >> *(@-70) 8 & ax 255 unsigned char , & *(@-70) 255 unsigned char , + 224 *(@-66) , 129 , *(2) (@10) , emit4 )10 "
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
; }
L226:
L224:
; return
	jmp	L127
; }
L220:
; if

section .rodata
L232:
	db	"or"
	times	1 db 0

section .text
; RPN'ized expression: "( L232 , op str_eq ) "
; Expanded expression: " L232  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L232 , *(2) (@4) , str_eq )4  "
	push	L232
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L230
; {
; if
; RPN'ized expression: "r1 1 -u != r2 1 -u != && "
; Expanded expression: "(@-66) *(2) -1 != [sh&&->235] (@-68) *(2) -1 != &&[235] "
; Fused expression:    "!= *(@-66) -1 [sh&&->235] != *(@-68) -1 &&[235]  "
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L235
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L235:
; JumpIfZero
	test	ax, ax
	je	L233
; {
; RPN'ized expression: "( 192 r2 3 << + r1 + , 9 , pass emit2 ) "
; Expanded expression: " 192 (@-68) *(2) 3 << + (@-66) *(2) +  9  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( << *(@-68) 3 + 192 ax + ax *(@-66) , 9 , *(2) (@10) , emit2 )6 "
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
; }
	jmp	L234
L233:
; else
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L236
; {
; loc             v : (@-70) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-70)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-70) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
; loc             <something> : unsigned char
; loc             <something> : unsigned char
; RPN'ized expression: "( v 8 >> 255 & (something239) , v 255 & (something238) , 200 r1 + , 129 , pass emit4 ) "
; Expanded expression: " (@-70) *(2) 8 >> 255 & unsigned char  (@-70) *(2) 255 & unsigned char  200 (@-66) *(2) +  129  (@10) *(2)  emit4 ()10 "
; Fused expression:    "( >> *(@-70) 8 & ax 255 unsigned char , & *(@-70) 255 unsigned char , + 200 *(@-66) , 129 , *(2) (@10) , emit4 )10 "
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
; }
L236:
L234:
; return
	jmp	L127
; }
L230:
; if

section .rodata
L242:
	db	"xor"
	times	1 db 0

section .text
; RPN'ized expression: "( L242 , op str_eq ) "
; Expanded expression: " L242  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L242 , *(2) (@4) , str_eq )4  "
	push	L242
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L240
; {
; if
; RPN'ized expression: "r1 1 -u != r2 1 -u != && "
; Expanded expression: "(@-66) *(2) -1 != [sh&&->245] (@-68) *(2) -1 != &&[245] "
; Fused expression:    "!= *(@-66) -1 [sh&&->245] != *(@-68) -1 &&[245]  "
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L245
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L245:
; JumpIfZero
	test	ax, ax
	je	L243
; {
; RPN'ized expression: "( 192 r2 3 << + r1 + , 49 , pass emit2 ) "
; Expanded expression: " 192 (@-68) *(2) 3 << + (@-66) *(2) +  49  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( << *(@-68) 3 + 192 ax + ax *(@-66) , 49 , *(2) (@10) , emit2 )6 "
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
; }
	jmp	L244
L243:
; else
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L246
; {
; loc             v : (@-70) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-70)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-70) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
; loc             <something> : unsigned char
; loc             <something> : unsigned char
; RPN'ized expression: "( v 8 >> 255 & (something249) , v 255 & (something248) , 240 r1 + , 129 , pass emit4 ) "
; Expanded expression: " (@-70) *(2) 8 >> 255 & unsigned char  (@-70) *(2) 255 & unsigned char  240 (@-66) *(2) +  129  (@10) *(2)  emit4 ()10 "
; Fused expression:    "( >> *(@-70) 8 & ax 255 unsigned char , & *(@-70) 255 unsigned char , + 240 *(@-66) , 129 , *(2) (@10) , emit4 )10 "
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
; }
L246:
L244:
; return
	jmp	L127
; }
L240:
; if

section .rodata
L252:
	db	"not"
	times	1 db 0

section .text
; RPN'ized expression: "( L252 , op str_eq ) "
; Expanded expression: " L252  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L252 , *(2) (@4) , str_eq )4  "
	push	L252
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L250
; {
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L253
; RPN'ized expression: "( 208 r1 + , 247 , pass emit2 ) "
; Expanded expression: " 208 (@-66) *(2) +  247  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( + 208 *(@-66) , 247 , *(2) (@10) , emit2 )6 "
	mov	ax, 208
	add	ax, [bp-66]
	push	ax
	push	247
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
L253:
; return
	jmp	L127
; }
L250:
; if

section .rodata
L257:
	db	"test"
	times	1 db 0

section .text
; RPN'ized expression: "( L257 , op str_eq ) "
; Expanded expression: " L257  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L257 , *(2) (@4) , str_eq )4  "
	push	L257
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L255
; {
; if
; RPN'ized expression: "r1 1 -u != r2 1 -u != && "
; Expanded expression: "(@-66) *(2) -1 != [sh&&->260] (@-68) *(2) -1 != &&[260] "
; Fused expression:    "!= *(@-66) -1 [sh&&->260] != *(@-68) -1 &&[260]  "
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L260
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L260:
; JumpIfZero
	test	ax, ax
	je	L258
; {
; RPN'ized expression: "( 192 r2 3 << + r1 + , 133 , pass emit2 ) "
; Expanded expression: " 192 (@-68) *(2) 3 << + (@-66) *(2) +  133  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( << *(@-68) 3 + 192 ax + ax *(@-66) , 133 , *(2) (@10) , emit2 )6 "
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
; }
	jmp	L259
L258:
; else
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L261
; {
; loc             v : (@-70) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-70)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-70) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
; loc             <something> : unsigned char
; loc             <something> : unsigned char
; RPN'ized expression: "( v 8 >> 255 & (something264) , v 255 & (something263) , 192 r1 + , 247 , pass emit4 ) "
; Expanded expression: " (@-70) *(2) 8 >> 255 & unsigned char  (@-70) *(2) 255 & unsigned char  192 (@-66) *(2) +  247  (@10) *(2)  emit4 ()10 "
; Fused expression:    "( >> *(@-70) 8 & ax 255 unsigned char , & *(@-70) 255 unsigned char , + 192 *(@-66) , 247 , *(2) (@10) , emit4 )10 "
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
; }
L261:
L259:
; return
	jmp	L127
; }
L255:
; if

section .rodata
L267:
	db	"shl"
	times	1 db 0

section .text
; RPN'ized expression: "( L267 , op str_eq ) "
; Expanded expression: " L267  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L267 , *(2) (@4) , str_eq )4  "
	push	L267
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L265
; {
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L268
; {
; if

section .rodata
L272:
	db	"cl"
	times	1 db 0

section .text
; RPN'ized expression: "( L272 , c2 str_eq ) "
; Expanded expression: " L272  (@-64)  str_eq ()4 "
; Fused expression:    "( L272 , (@-64) , str_eq )4  "
	push	L272
	lea	ax, [bp-64]
	push	ax
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L270
; {
; RPN'ized expression: "( 224 r1 + , 211 , pass emit2 ) "
; Expanded expression: " 224 (@-66) *(2) +  211  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( + 224 *(@-66) , 211 , *(2) (@10) , emit2 )6 "
	mov	ax, 224
	add	ax, [bp-66]
	push	ax
	push	211
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
; }
	jmp	L271
L270:
; else
; {
; loc                 v : (@-70) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-70)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-70) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
; loc                 <something> : unsigned char
; RPN'ized expression: "( v 255 & (something273) , 224 r1 + , 193 , pass emit3 ) "
; Expanded expression: " (@-70) *(2) 255 & unsigned char  224 (@-66) *(2) +  193  (@10) *(2)  emit3 ()8 "
; Fused expression:    "( & *(@-70) 255 unsigned char , + 224 *(@-66) , 193 , *(2) (@10) , emit3 )8 "
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
; }
L271:
; }
L268:
; return
	jmp	L127
; }
L265:
; if

section .rodata
L276:
	db	"shr"
	times	1 db 0

section .text
; RPN'ized expression: "( L276 , op str_eq ) "
; Expanded expression: " L276  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L276 , *(2) (@4) , str_eq )4  "
	push	L276
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L274
; {
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L277
; {
; if

section .rodata
L281:
	db	"cl"
	times	1 db 0

section .text
; RPN'ized expression: "( L281 , c2 str_eq ) "
; Expanded expression: " L281  (@-64)  str_eq ()4 "
; Fused expression:    "( L281 , (@-64) , str_eq )4  "
	push	L281
	lea	ax, [bp-64]
	push	ax
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L279
; {
; RPN'ized expression: "( 232 r1 + , 211 , pass emit2 ) "
; Expanded expression: " 232 (@-66) *(2) +  211  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( + 232 *(@-66) , 211 , *(2) (@10) , emit2 )6 "
	mov	ax, 232
	add	ax, [bp-66]
	push	ax
	push	211
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
; }
	jmp	L280
L279:
; else
; {
; loc                 v : (@-70) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-70)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-70) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
; loc                 <something> : unsigned char
; RPN'ized expression: "( v 255 & (something282) , 232 r1 + , 193 , pass emit3 ) "
; Expanded expression: " (@-70) *(2) 255 & unsigned char  232 (@-66) *(2) +  193  (@10) *(2)  emit3 ()8 "
; Fused expression:    "( & *(@-70) 255 unsigned char , + 232 *(@-66) , 193 , *(2) (@10) , emit3 )8 "
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
; }
L280:
; }
L277:
; return
	jmp	L127
; }
L274:
; if

section .rodata
L285:
	db	"rol"
	times	1 db 0

section .text
; RPN'ized expression: "( L285 , op str_eq ) "
; Expanded expression: " L285  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L285 , *(2) (@4) , str_eq )4  "
	push	L285
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L283
; {
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L286
; {
; if

section .rodata
L290:
	db	"cl"
	times	1 db 0

section .text
; RPN'ized expression: "( L290 , c2 str_eq ) "
; Expanded expression: " L290  (@-64)  str_eq ()4 "
; Fused expression:    "( L290 , (@-64) , str_eq )4  "
	push	L290
	lea	ax, [bp-64]
	push	ax
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L288
; {
; RPN'ized expression: "( 192 r1 + , 211 , pass emit2 ) "
; Expanded expression: " 192 (@-66) *(2) +  211  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( + 192 *(@-66) , 211 , *(2) (@10) , emit2 )6 "
	mov	ax, 192
	add	ax, [bp-66]
	push	ax
	push	211
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
; }
	jmp	L289
L288:
; else
; {
; loc                 v : (@-70) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-70)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-70) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
; loc                 <something> : unsigned char
; RPN'ized expression: "( v 255 & (something291) , 192 r1 + , 193 , pass emit3 ) "
; Expanded expression: " (@-70) *(2) 255 & unsigned char  192 (@-66) *(2) +  193  (@10) *(2)  emit3 ()8 "
; Fused expression:    "( & *(@-70) 255 unsigned char , + 192 *(@-66) , 193 , *(2) (@10) , emit3 )8 "
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
; }
L289:
; }
L286:
; return
	jmp	L127
; }
L283:
; if

section .rodata
L294:
	db	"ror"
	times	1 db 0

section .text
; RPN'ized expression: "( L294 , op str_eq ) "
; Expanded expression: " L294  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L294 , *(2) (@4) , str_eq )4  "
	push	L294
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L292
; {
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L295
; {
; if

section .rodata
L299:
	db	"cl"
	times	1 db 0

section .text
; RPN'ized expression: "( L299 , c2 str_eq ) "
; Expanded expression: " L299  (@-64)  str_eq ()4 "
; Fused expression:    "( L299 , (@-64) , str_eq )4  "
	push	L299
	lea	ax, [bp-64]
	push	ax
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L297
; {
; RPN'ized expression: "( 200 r1 + , 211 , pass emit2 ) "
; Expanded expression: " 200 (@-66) *(2) +  211  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( + 200 *(@-66) , 211 , *(2) (@10) , emit2 )6 "
	mov	ax, 200
	add	ax, [bp-66]
	push	ax
	push	211
	push	word [bp+10]
	call	_emit2
	sub	sp, -6
; }
	jmp	L298
L297:
; else
; {
; loc                 v : (@-70) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-70)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-70) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
; loc                 <something> : unsigned char
; RPN'ized expression: "( v 255 & (something300) , 200 r1 + , 193 , pass emit3 ) "
; Expanded expression: " (@-70) *(2) 255 & unsigned char  200 (@-66) *(2) +  193  (@10) *(2)  emit3 ()8 "
; Fused expression:    "( & *(@-70) 255 unsigned char , + 200 *(@-66) , 193 , *(2) (@10) , emit3 )8 "
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
; }
L298:
; }
L295:
; return
	jmp	L127
; }
L292:
; if

section .rodata
L303:
	db	"cmp"
	times	1 db 0

section .text
; RPN'ized expression: "( L303 , op str_eq ) "
; Expanded expression: " L303  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L303 , *(2) (@4) , str_eq )4  "
	push	L303
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L301
; {
; if
; RPN'ized expression: "r1 1 -u != r2 1 -u != && "
; Expanded expression: "(@-66) *(2) -1 != [sh&&->306] (@-68) *(2) -1 != &&[306] "
; Fused expression:    "!= *(@-66) -1 [sh&&->306] != *(@-68) -1 &&[306]  "
	mov	ax, [bp-66]
	cmp	ax, -1
	setne	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L306
	mov	ax, [bp-68]
	cmp	ax, -1
	setne	al
	cbw
L306:
; JumpIfZero
	test	ax, ax
	je	L304
; {
; RPN'ized expression: "( 192 r2 3 << + r1 + , 57 , pass emit2 ) "
; Expanded expression: " 192 (@-68) *(2) 3 << + (@-66) *(2) +  57  (@10) *(2)  emit2 ()6 "
; Fused expression:    "( << *(@-68) 3 + 192 ax + ax *(@-66) , 57 , *(2) (@10) , emit2 )6 "
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
; }
	jmp	L305
L304:
; else
; if
; RPN'ized expression: "r1 1 -u != "
; Expanded expression: "(@-66) *(2) -1 != "
; Fused expression:    "!= *(@-66) -1 IF! "
	mov	ax, [bp-66]
	cmp	ax, -1
	je	L307
; {
; loc             v : (@-70) : int
; RPN'ized expression: "v ( c2 resolve_imm ) = "
; Expanded expression: "(@-70)  (@-64)  resolve_imm ()2 =(2) "
; Fused expression:    "( (@-64) , resolve_imm )2 =(170) *(@-70) ax "
	lea	ax, [bp-64]
	push	ax
	call	_resolve_imm
	sub	sp, -2
	mov	[bp-70], ax
; loc             <something> : unsigned char
; loc             <something> : unsigned char
; RPN'ized expression: "( v 8 >> 255 & (something310) , v 255 & (something309) , 248 r1 + , 129 , pass emit4 ) "
; Expanded expression: " (@-70) *(2) 8 >> 255 & unsigned char  (@-70) *(2) 255 & unsigned char  248 (@-66) *(2) +  129  (@10) *(2)  emit4 ()10 "
; Fused expression:    "( >> *(@-70) 8 & ax 255 unsigned char , & *(@-70) 255 unsigned char , + 248 *(@-66) , 129 , *(2) (@10) , emit4 )10 "
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
; }
L307:
L305:
; return
	jmp	L127
; }
L301:
; if

section .rodata
L313:
	db	"jmp"
	times	1 db 0

section .text
; RPN'ized expression: "( L313 , op str_eq ) "
; Expanded expression: " L313  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L313 , *(2) (@4) , str_eq )4  "
	push	L313
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L311
; {
; if
; RPN'ized expression: "pass "
; Expanded expression: "(@10) *(2) "
; Fused expression:    "*(2) (@10)  "
	mov	ax, [bp+10]
; JumpIfZero
	test	ax, ax
	je	L314
; {
; loc             target : (@-70) : int
; RPN'ized expression: "target ( c1 find_label ) = "
; Expanded expression: "(@-70)  (@-32)  find_label ()2 =(2) "
; Fused expression:    "( (@-32) , find_label )2 =(170) *(@-70) ax "
	lea	ax, [bp-32]
	push	ax
	call	_find_label
	sub	sp, -2
	mov	[bp-70], ax
; loc             offset : (@-72) : int
; RPN'ized expression: "offset target 49152u binary_size + 3 + - = "
; Expanded expression: "(@-72) (@-70) *(2) 49152u binary_size *(2) + 3 + - =(2) "
; Fused expression:    "+ 49152u *binary_size + ax 3 - *(@-70) ax =(170) *(@-72) ax "
	mov	ax, -16384
	add	ax, [_binary_size]
	add	ax, 3
	mov	cx, ax
	mov	ax, [bp-70]
	sub	ax, cx
	mov	[bp-72], ax
; RPN'ized expression: "output_binary binary_size + *u 233 = "
; Expanded expression: "output_binary binary_size *(2) + 233 =(1) "
; Fused expression:    "+ output_binary *binary_size =(154) *ax 233 "
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 233
	mov	[bx], al
	mov	ah, 0
; loc             <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 1 + + *u offset 255 & (something316) = "
; Expanded expression: "output_binary binary_size *(2) 1 + + (@-72) *(2) 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 1 + output_binary ax push-ax & *(@-72) 255 unsigned char =(154) **sp ax "
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
; loc             <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 2 + + *u offset 8 >> 255 & (something317) = "
; Expanded expression: "output_binary binary_size *(2) 2 + + (@-72) *(2) 8 >> 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 2 + output_binary ax push-ax >> *(@-72) 8 & ax 255 unsigned char =(154) **sp ax "
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
; }
L314:
; RPN'ized expression: "binary_size 3 += "
; Expanded expression: "binary_size 3 +=(2) "
; Fused expression:    "+=(170) *binary_size 3 "
	mov	ax, [_binary_size]
	add	ax, 3
	mov	[_binary_size], ax
; return
	jmp	L127
; }
L311:
; if

section .rodata
L320:
	db	"call"
	times	1 db 0

section .text
; RPN'ized expression: "( L320 , op str_eq ) "
; Expanded expression: " L320  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L320 , *(2) (@4) , str_eq )4  "
	push	L320
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L318
; {
; if
; RPN'ized expression: "pass "
; Expanded expression: "(@10) *(2) "
; Fused expression:    "*(2) (@10)  "
	mov	ax, [bp+10]
; JumpIfZero
	test	ax, ax
	je	L321
; {
; loc             target : (@-70) : int
; RPN'ized expression: "target ( c1 find_label ) = "
; Expanded expression: "(@-70)  (@-32)  find_label ()2 =(2) "
; Fused expression:    "( (@-32) , find_label )2 =(170) *(@-70) ax "
	lea	ax, [bp-32]
	push	ax
	call	_find_label
	sub	sp, -2
	mov	[bp-70], ax
; loc             offset : (@-72) : int
; RPN'ized expression: "offset target 49152u binary_size + 3 + - = "
; Expanded expression: "(@-72) (@-70) *(2) 49152u binary_size *(2) + 3 + - =(2) "
; Fused expression:    "+ 49152u *binary_size + ax 3 - *(@-70) ax =(170) *(@-72) ax "
	mov	ax, -16384
	add	ax, [_binary_size]
	add	ax, 3
	mov	cx, ax
	mov	ax, [bp-70]
	sub	ax, cx
	mov	[bp-72], ax
; RPN'ized expression: "output_binary binary_size + *u 232 = "
; Expanded expression: "output_binary binary_size *(2) + 232 =(1) "
; Fused expression:    "+ output_binary *binary_size =(154) *ax 232 "
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 232
	mov	[bx], al
	mov	ah, 0
; loc             <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 1 + + *u offset 255 & (something323) = "
; Expanded expression: "output_binary binary_size *(2) 1 + + (@-72) *(2) 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 1 + output_binary ax push-ax & *(@-72) 255 unsigned char =(154) **sp ax "
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
; loc             <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 2 + + *u offset 8 >> 255 & (something324) = "
; Expanded expression: "output_binary binary_size *(2) 2 + + (@-72) *(2) 8 >> 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 2 + output_binary ax push-ax >> *(@-72) 8 & ax 255 unsigned char =(154) **sp ax "
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
; }
L321:
; RPN'ized expression: "binary_size 3 += "
; Expanded expression: "binary_size 3 +=(2) "
; Fused expression:    "+=(170) *binary_size 3 "
	mov	ax, [_binary_size]
	add	ax, 3
	mov	[_binary_size], ax
; return
	jmp	L127
; }
L318:
; if

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
; RPN'ized expression: "( L327 , op str_eq ) ( L328 , op str_eq ) || "
; Expanded expression: " L327  (@4) *(2)  str_eq ()4 _Bool [sh||->329]  L328  (@4) *(2)  str_eq ()4 _Bool ||[329] "
; Fused expression:    "( L327 , *(2) (@4) , str_eq )4 _Bool [sh||->329] ( L328 , *(2) (@4) , str_eq )4 _Bool ||[329]  "
	push	L327
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	setne	al
	cbw
; JumpIfNotZero
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
; JumpIfZero
	test	ax, ax
	je	L325
; {
; if
; RPN'ized expression: "pass "
; Expanded expression: "(@10) *(2) "
; Fused expression:    "*(2) (@10)  "
	mov	ax, [bp+10]
; JumpIfZero
	test	ax, ax
	je	L330
; {
; loc             target : (@-70) : int
; RPN'ized expression: "target ( c1 find_label ) = "
; Expanded expression: "(@-70)  (@-32)  find_label ()2 =(2) "
; Fused expression:    "( (@-32) , find_label )2 =(170) *(@-70) ax "
	lea	ax, [bp-32]
	push	ax
	call	_find_label
	sub	sp, -2
	mov	[bp-70], ax
; loc             offset : (@-72) : int
; RPN'ized expression: "offset target 49152u binary_size + 4 + - = "
; Expanded expression: "(@-72) (@-70) *(2) 49152u binary_size *(2) + 4 + - =(2) "
; Fused expression:    "+ 49152u *binary_size + ax 4 - *(@-70) ax =(170) *(@-72) ax "
	mov	ax, -16384
	add	ax, [_binary_size]
	add	ax, 4
	mov	cx, ax
	mov	ax, [bp-70]
	sub	ax, cx
	mov	[bp-72], ax
; RPN'ized expression: "output_binary binary_size + *u 15 = "
; Expanded expression: "output_binary binary_size *(2) + 15 =(1) "
; Fused expression:    "+ output_binary *binary_size =(154) *ax 15 "
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 15
	mov	[bx], al
	mov	ah, 0
; RPN'ized expression: "output_binary binary_size 1 + + *u 132 = "
; Expanded expression: "output_binary binary_size *(2) 1 + + 132 =(1) "
; Fused expression:    "+ *binary_size 1 + output_binary ax =(154) *ax 132 "
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	ax, 132
	mov	[bx], al
	mov	ah, 0
; loc             <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 2 + + *u offset 255 & (something332) = "
; Expanded expression: "output_binary binary_size *(2) 2 + + (@-72) *(2) 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 2 + output_binary ax push-ax & *(@-72) 255 unsigned char =(154) **sp ax "
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
; loc             <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 3 + + *u offset 8 >> 255 & (something333) = "
; Expanded expression: "output_binary binary_size *(2) 3 + + (@-72) *(2) 8 >> 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 3 + output_binary ax push-ax >> *(@-72) 8 & ax 255 unsigned char =(154) **sp ax "
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
; }
L330:
; RPN'ized expression: "binary_size 4 += "
; Expanded expression: "binary_size 4 +=(2) "
; Fused expression:    "+=(170) *binary_size 4 "
	mov	ax, [_binary_size]
	add	ax, 4
	mov	[_binary_size], ax
; return
	jmp	L127
; }
L325:
; if

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
; RPN'ized expression: "( L336 , op str_eq ) ( L337 , op str_eq ) || "
; Expanded expression: " L336  (@4) *(2)  str_eq ()4 _Bool [sh||->338]  L337  (@4) *(2)  str_eq ()4 _Bool ||[338] "
; Fused expression:    "( L336 , *(2) (@4) , str_eq )4 _Bool [sh||->338] ( L337 , *(2) (@4) , str_eq )4 _Bool ||[338]  "
	push	L336
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
	test	ax, ax
	setne	al
	cbw
; JumpIfNotZero
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
; JumpIfZero
	test	ax, ax
	je	L334
; {
; if
; RPN'ized expression: "pass "
; Expanded expression: "(@10) *(2) "
; Fused expression:    "*(2) (@10)  "
	mov	ax, [bp+10]
; JumpIfZero
	test	ax, ax
	je	L339
; {
; loc             target : (@-70) : int
; RPN'ized expression: "target ( c1 find_label ) = "
; Expanded expression: "(@-70)  (@-32)  find_label ()2 =(2) "
; Fused expression:    "( (@-32) , find_label )2 =(170) *(@-70) ax "
	lea	ax, [bp-32]
	push	ax
	call	_find_label
	sub	sp, -2
	mov	[bp-70], ax
; loc             offset : (@-72) : int
; RPN'ized expression: "offset target 49152u binary_size + 4 + - = "
; Expanded expression: "(@-72) (@-70) *(2) 49152u binary_size *(2) + 4 + - =(2) "
; Fused expression:    "+ 49152u *binary_size + ax 4 - *(@-70) ax =(170) *(@-72) ax "
	mov	ax, -16384
	add	ax, [_binary_size]
	add	ax, 4
	mov	cx, ax
	mov	ax, [bp-70]
	sub	ax, cx
	mov	[bp-72], ax
; RPN'ized expression: "output_binary binary_size + *u 15 = "
; Expanded expression: "output_binary binary_size *(2) + 15 =(1) "
; Fused expression:    "+ output_binary *binary_size =(154) *ax 15 "
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 15
	mov	[bx], al
	mov	ah, 0
; RPN'ized expression: "output_binary binary_size 1 + + *u 133 = "
; Expanded expression: "output_binary binary_size *(2) 1 + + 133 =(1) "
; Fused expression:    "+ *binary_size 1 + output_binary ax =(154) *ax 133 "
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	ax, 133
	mov	[bx], al
	mov	ah, 0
; loc             <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 2 + + *u offset 255 & (something341) = "
; Expanded expression: "output_binary binary_size *(2) 2 + + (@-72) *(2) 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 2 + output_binary ax push-ax & *(@-72) 255 unsigned char =(154) **sp ax "
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
; loc             <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 3 + + *u offset 8 >> 255 & (something342) = "
; Expanded expression: "output_binary binary_size *(2) 3 + + (@-72) *(2) 8 >> 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 3 + output_binary ax push-ax >> *(@-72) 8 & ax 255 unsigned char =(154) **sp ax "
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
; }
L339:
; RPN'ized expression: "binary_size 4 += "
; Expanded expression: "binary_size 4 +=(2) "
; Fused expression:    "+=(170) *binary_size 4 "
	mov	ax, [_binary_size]
	add	ax, 4
	mov	[_binary_size], ax
; return
	jmp	L127
; }
L334:
; if

section .rodata
L345:
	db	"jg"
	times	1 db 0

section .text
; RPN'ized expression: "( L345 , op str_eq ) "
; Expanded expression: " L345  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L345 , *(2) (@4) , str_eq )4  "
	push	L345
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L343
; {
; if
; RPN'ized expression: "pass "
; Expanded expression: "(@10) *(2) "
; Fused expression:    "*(2) (@10)  "
	mov	ax, [bp+10]
; JumpIfZero
	test	ax, ax
	je	L346
; {
; loc             target : (@-70) : int
; RPN'ized expression: "target ( c1 find_label ) = "
; Expanded expression: "(@-70)  (@-32)  find_label ()2 =(2) "
; Fused expression:    "( (@-32) , find_label )2 =(170) *(@-70) ax "
	lea	ax, [bp-32]
	push	ax
	call	_find_label
	sub	sp, -2
	mov	[bp-70], ax
; loc             offset : (@-72) : int
; RPN'ized expression: "offset target 49152u binary_size + 4 + - = "
; Expanded expression: "(@-72) (@-70) *(2) 49152u binary_size *(2) + 4 + - =(2) "
; Fused expression:    "+ 49152u *binary_size + ax 4 - *(@-70) ax =(170) *(@-72) ax "
	mov	ax, -16384
	add	ax, [_binary_size]
	add	ax, 4
	mov	cx, ax
	mov	ax, [bp-70]
	sub	ax, cx
	mov	[bp-72], ax
; RPN'ized expression: "output_binary binary_size + *u 15 = "
; Expanded expression: "output_binary binary_size *(2) + 15 =(1) "
; Fused expression:    "+ output_binary *binary_size =(154) *ax 15 "
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 15
	mov	[bx], al
	mov	ah, 0
; RPN'ized expression: "output_binary binary_size 1 + + *u 143 = "
; Expanded expression: "output_binary binary_size *(2) 1 + + 143 =(1) "
; Fused expression:    "+ *binary_size 1 + output_binary ax =(154) *ax 143 "
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	ax, 143
	mov	[bx], al
	mov	ah, 0
; loc             <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 2 + + *u offset 255 & (something348) = "
; Expanded expression: "output_binary binary_size *(2) 2 + + (@-72) *(2) 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 2 + output_binary ax push-ax & *(@-72) 255 unsigned char =(154) **sp ax "
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
; loc             <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 3 + + *u offset 8 >> 255 & (something349) = "
; Expanded expression: "output_binary binary_size *(2) 3 + + (@-72) *(2) 8 >> 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 3 + output_binary ax push-ax >> *(@-72) 8 & ax 255 unsigned char =(154) **sp ax "
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
; }
L346:
; RPN'ized expression: "binary_size 4 += "
; Expanded expression: "binary_size 4 +=(2) "
; Fused expression:    "+=(170) *binary_size 4 "
	mov	ax, [_binary_size]
	add	ax, 4
	mov	[_binary_size], ax
; return
	jmp	L127
; }
L343:
; if

section .rodata
L352:
	db	"jl"
	times	1 db 0

section .text
; RPN'ized expression: "( L352 , op str_eq ) "
; Expanded expression: " L352  (@4) *(2)  str_eq ()4 "
; Fused expression:    "( L352 , *(2) (@4) , str_eq )4  "
	push	L352
	push	word [bp+4]
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L350
; {
; if
; RPN'ized expression: "pass "
; Expanded expression: "(@10) *(2) "
; Fused expression:    "*(2) (@10)  "
	mov	ax, [bp+10]
; JumpIfZero
	test	ax, ax
	je	L353
; {
; loc             target : (@-70) : int
; RPN'ized expression: "target ( c1 find_label ) = "
; Expanded expression: "(@-70)  (@-32)  find_label ()2 =(2) "
; Fused expression:    "( (@-32) , find_label )2 =(170) *(@-70) ax "
	lea	ax, [bp-32]
	push	ax
	call	_find_label
	sub	sp, -2
	mov	[bp-70], ax
; loc             offset : (@-72) : int
; RPN'ized expression: "offset target 49152u binary_size + 4 + - = "
; Expanded expression: "(@-72) (@-70) *(2) 49152u binary_size *(2) + 4 + - =(2) "
; Fused expression:    "+ 49152u *binary_size + ax 4 - *(@-70) ax =(170) *(@-72) ax "
	mov	ax, -16384
	add	ax, [_binary_size]
	add	ax, 4
	mov	cx, ax
	mov	ax, [bp-70]
	sub	ax, cx
	mov	[bp-72], ax
; RPN'ized expression: "output_binary binary_size + *u 15 = "
; Expanded expression: "output_binary binary_size *(2) + 15 =(1) "
; Fused expression:    "+ output_binary *binary_size =(154) *ax 15 "
	mov	ax, _output_binary
	add	ax, [_binary_size]
	mov	bx, ax
	mov	ax, 15
	mov	[bx], al
	mov	ah, 0
; RPN'ized expression: "output_binary binary_size 1 + + *u 140 = "
; Expanded expression: "output_binary binary_size *(2) 1 + + 140 =(1) "
; Fused expression:    "+ *binary_size 1 + output_binary ax =(154) *ax 140 "
	mov	ax, [_binary_size]
	inc	ax
	mov	cx, ax
	mov	ax, _output_binary
	add	ax, cx
	mov	bx, ax
	mov	ax, 140
	mov	[bx], al
	mov	ah, 0
; loc             <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 2 + + *u offset 255 & (something355) = "
; Expanded expression: "output_binary binary_size *(2) 2 + + (@-72) *(2) 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 2 + output_binary ax push-ax & *(@-72) 255 unsigned char =(154) **sp ax "
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
; loc             <something> : unsigned char
; RPN'ized expression: "output_binary binary_size 3 + + *u offset 8 >> 255 & (something356) = "
; Expanded expression: "output_binary binary_size *(2) 3 + + (@-72) *(2) 8 >> 255 & unsigned char =(1) "
; Fused expression:    "+ *binary_size 3 + output_binary ax push-ax >> *(@-72) 8 & ax 255 unsigned char =(154) **sp ax "
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
; }
L353:
; RPN'ized expression: "binary_size 4 += "
; Expanded expression: "binary_size 4 +=(2) "
; Fused expression:    "+=(170) *binary_size 4 "
	mov	ax, [_binary_size]
	add	ax, 4
	mov	[_binary_size], ax
; return
	jmp	L127
; }
L350:
L127:
	leave
	ret

; glb parse_line : (
; prm     line : * char
; prm     pass : int
;     ) void
section .text
	global	_parse_line
_parse_line:
	push	bp
	mov	bp, sp
	 sub	sp,        118
; loc     line : (@4) : * char
; loc     pass : (@6) : int
; RPN'ized expression: "16 "
; Expanded expression: "16 "
; Expression value: 16

section .data
L359:
	times	16 db 0

section .text
; loc     op : (@-16) : [16u] char
; =
; Fused expression:    "( (@-16) , L359 , 16u , L360 )6 "
	lea	ax, [bp-16]
	push	ax
	push	L359
	push	16
	call	L360
	sub	sp, -6
; RPN'ized expression: "64 "
; Expanded expression: "64 "
; Expression value: 64

section .data
L361:
	times	64 db 0

section .text
; loc     a1 : (@-80) : [64u] char
; =
; Fused expression:    "( (@-80) , L361 , 64u , L360 )6 "
	lea	ax, [bp-80]
	push	ax
	push	L361
	push	64
	call	L360
	sub	sp, -6
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32

section .data
L362:
	times	32 db 0

section .text
; loc     a2 : (@-112) : [32u] char
; =
; Fused expression:    "( (@-112) , L362 , 32u , L360 )6 "
	lea	ax, [bp-112]
	push	ax
	push	L362
	push	32
	call	L360
	sub	sp, -6
; loc     i : (@-114) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-114) 0 =(2) "
; Fused expression:    "=(170) *(@-114) 0 "
	mov	ax, 0
	mov	[bp-114], ax
; loc     j : (@-116) : int
; RPN'ized expression: "j 0 = "
; Expanded expression: "(@-116) 0 =(2) "
; Fused expression:    "=(170) *(@-116) 0 "
	mov	ax, 0
	mov	[bp-116], ax
; while
; RPN'ized expression: "line i + *u 32 == line i + *u 9 == || "
; Expanded expression: "(@4) *(2) (@-114) *(2) + *(-1) 32 == [sh||->365] (@4) *(2) (@-114) *(2) + *(-1) 9 == ||[365] "
L363:
; Fused expression:    "+ *(@4) *(@-114) == *ax 32 [sh||->365] + *(@4) *(@-114) == *ax 9 ||[365]  "
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	sete	al
	cbw
; JumpIfNotZero
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
; JumpIfZero
	test	ax, ax
	je	L364
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-114) ++p(2) "
; Fused expression:    "++p(2) *(@-114) "
	mov	ax, [bp-114]
	inc	word [bp-114]
	jmp	L363
L364:
; if
; RPN'ized expression: "line i + *u 0 == line i + *u 10 == || line i + *u 59 == || "
; Expanded expression: "(@4) *(2) (@-114) *(2) + *(-1) 0 == [sh||->369] (@4) *(2) (@-114) *(2) + *(-1) 10 == ||[369] _Bool [sh||->368] (@4) *(2) (@-114) *(2) + *(-1) 59 == ||[368] "
; Fused expression:    "+ *(@4) *(@-114) == *ax 0 [sh||->369] + *(@4) *(@-114) == *ax 10 ||[369] _Bool [sh||->368] + *(@4) *(@-114) == *ax 59 ||[368]  "
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 0
	sete	al
	cbw
; JumpIfNotZero
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
; JumpIfNotZero
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
; JumpIfZero
	test	ax, ax
	je	L366
; return
	jmp	L357
L366:
; loc     k : (@-118) : int
; RPN'ized expression: "k i = "
; Expanded expression: "(@-118) (@-114) *(2) =(2) "
; Fused expression:    "=(170) *(@-118) *(@-114) "
	mov	ax, [bp-114]
	mov	[bp-118], ax
; while
; RPN'ized expression: "line k + *u line k + *u 32 != && line k + *u 9 != && line k + *u 58 != && "
; Expanded expression: "(@4) *(2) (@-118) *(2) + *(-1) _Bool [sh&&->374] (@4) *(2) (@-118) *(2) + *(-1) 32 != &&[374] _Bool [sh&&->373] (@4) *(2) (@-118) *(2) + *(-1) 9 != &&[373] _Bool [sh&&->372] (@4) *(2) (@-118) *(2) + *(-1) 58 != &&[372] "
L370:
; Fused expression:    "+ *(@4) *(@-118) *(-1) ax _Bool [sh&&->374] + *(@4) *(@-118) != *ax 32 &&[374] _Bool [sh&&->373] + *(@4) *(@-118) != *ax 9 &&[373] _Bool [sh&&->372] + *(@4) *(@-118) != *ax 58 &&[372]  "
	mov	ax, [bp+4]
	add	ax, [bp-118]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L371
; RPN'ized expression: "k ++p "
; Expanded expression: "(@-118) ++p(2) "
; Fused expression:    "++p(2) *(@-118) "
	mov	ax, [bp-118]
	inc	word [bp-118]
	jmp	L370
L371:
; if
; RPN'ized expression: "line k + *u 58 == "
; Expanded expression: "(@4) *(2) (@-118) *(2) + *(-1) 58 == "
; Fused expression:    "+ *(@4) *(@-118) == *ax 58 IF! "
	mov	ax, [bp+4]
	add	ax, [bp-118]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 58
	jne	L375
; {
; if
; RPN'ized expression: "pass 0 == "
; Expanded expression: "(@6) *(2) 0 == "
; Fused expression:    "== *(@6) 0 IF! "
	mov	ax, [bp+6]
	cmp	ax, 0
	jne	L377
; {
; RPN'ized expression: "j 0 = "
; Expanded expression: "(@-116) 0 =(2) "
; Fused expression:    "=(170) *(@-116) 0 "
	mov	ax, 0
	mov	[bp-116], ax
; while
; RPN'ized expression: "i k < j 15 < && "
; Expanded expression: "(@-114) *(2) (@-118) *(2) < [sh&&->381] (@-116) *(2) 15 < &&[381] "
L379:
; Fused expression:    "< *(@-114) *(@-118) [sh&&->381] < *(@-116) 15 &&[381]  "
	mov	ax, [bp-114]
	cmp	ax, [bp-118]
	setl	al
	cbw
; JumpIfZero
	test	ax, ax
	je	L381
	mov	ax, [bp-116]
	cmp	ax, 15
	setl	al
	cbw
L381:
; JumpIfZero
	test	ax, ax
	je	L380
; {
; RPN'ized expression: "label_table label_count + *u &u name -> *u j ++p + *u line i ++p + *u = "
; Expanded expression: "label_table label_count *(2) 18 * + 0 + (@-116) ++p(2) + (@4) *(2) (@-114) ++p(2) + *(-1) =(-1) "
; Fused expression:    "* *label_count 18 + label_table ax + ax 0 push-ax ++p(2) *(@-116) + *sp ax push-ax ++p(2) *(@-114) + *(@4) ax =(119) **sp *ax "
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
; }
	jmp	L379
L380:
; RPN'ized expression: "label_table label_count + *u &u name -> *u j + *u 0 = "
; Expanded expression: "label_table label_count *(2) 18 * + 0 + (@-116) *(2) + 0 =(-1) "
; Fused expression:    "* *label_count 18 + label_table ax + ax 0 + ax *(@-116) =(122) *ax 0 "
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
; RPN'ized expression: "label_table label_count + *u &u address -> *u 49152u binary_size + = "
; Expanded expression: "label_table label_count *(2) 18 * + 16 + 49152u binary_size *(2) + =(2) "
; Fused expression:    "* *label_count 18 + label_table ax + ax 16 push-ax + 49152u *binary_size =(170) **sp ax "
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
; RPN'ized expression: "label_count ++p "
; Expanded expression: "label_count ++p(2) "
; Fused expression:    "++p(2) *label_count "
	mov	ax, [_label_count]
	inc	word [_label_count]
; }
L377:
; return
	jmp	L357
; }
L375:
; RPN'ized expression: "j 0 = "
; Expanded expression: "(@-116) 0 =(2) "
; Fused expression:    "=(170) *(@-116) 0 "
	mov	ax, 0
	mov	[bp-116], ax
; while
; RPN'ized expression: "line i + *u line i + *u 32 != && line i + *u 9 != && line i + *u 10 != && "
; Expanded expression: "(@4) *(2) (@-114) *(2) + *(-1) _Bool [sh&&->386] (@4) *(2) (@-114) *(2) + *(-1) 32 != &&[386] _Bool [sh&&->385] (@4) *(2) (@-114) *(2) + *(-1) 9 != &&[385] _Bool [sh&&->384] (@4) *(2) (@-114) *(2) + *(-1) 10 != &&[384] "
L382:
; Fused expression:    "+ *(@4) *(@-114) *(-1) ax _Bool [sh&&->386] + *(@4) *(@-114) != *ax 32 &&[386] _Bool [sh&&->385] + *(@4) *(@-114) != *ax 9 &&[385] _Bool [sh&&->384] + *(@4) *(@-114) != *ax 10 &&[384]  "
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L383
; {
; if
; RPN'ized expression: "j 15 < "
; Expanded expression: "(@-116) *(2) 15 < "
; Fused expression:    "< *(@-116) 15 IF! "
	mov	ax, [bp-116]
	cmp	ax, 15
	jge	L387
; RPN'ized expression: "op j ++p + *u line i + *u = "
; Expanded expression: "(@-16) (@-116) ++p(2) + (@4) *(2) (@-114) *(2) + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-116) + (@-16) ax push-ax + *(@4) *(@-114) =(119) **sp *ax "
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
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-114) ++p(2) "
; Fused expression:    "++p(2) *(@-114) "
	mov	ax, [bp-114]
	inc	word [bp-114]
; }
	jmp	L382
L383:
; RPN'ized expression: "op j + *u 0 = "
; Expanded expression: "(@-16) (@-116) *(2) + 0 =(-1) "
; Fused expression:    "+ (@-16) *(@-116) =(122) *ax 0 "
	lea	ax, [bp-16]
	add	ax, [bp-116]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; if

section .rodata
L391:
	db	"db"
	times	1 db 0

section .text
; RPN'ized expression: "( L391 , op str_eq ) "
; Expanded expression: " L391  (@-16)  str_eq ()4 "
; Fused expression:    "( L391 , (@-16) , str_eq )4  "
	push	L391
	lea	ax, [bp-16]
	push	ax
	call	_str_eq
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L389
; {
; while
; RPN'ized expression: "line i + *u 32 == line i + *u 9 == || "
; Expanded expression: "(@4) *(2) (@-114) *(2) + *(-1) 32 == [sh||->394] (@4) *(2) (@-114) *(2) + *(-1) 9 == ||[394] "
L392:
; Fused expression:    "+ *(@4) *(@-114) == *ax 32 [sh||->394] + *(@4) *(@-114) == *ax 9 ||[394]  "
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	sete	al
	cbw
; JumpIfNotZero
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
; JumpIfZero
	test	ax, ax
	je	L393
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-114) ++p(2) "
; Fused expression:    "++p(2) *(@-114) "
	mov	ax, [bp-114]
	inc	word [bp-114]
	jmp	L392
L393:
; RPN'ized expression: "j 0 = "
; Expanded expression: "(@-116) 0 =(2) "
; Fused expression:    "=(170) *(@-116) 0 "
	mov	ax, 0
	mov	[bp-116], ax
; while
; RPN'ized expression: "line i + *u line i + *u 10 != && "
; Expanded expression: "(@4) *(2) (@-114) *(2) + *(-1) _Bool [sh&&->397] (@4) *(2) (@-114) *(2) + *(-1) 10 != &&[397] "
L395:
; Fused expression:    "+ *(@4) *(@-114) *(-1) ax _Bool [sh&&->397] + *(@4) *(@-114) != *ax 10 &&[397]  "
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L396
; {
; if
; RPN'ized expression: "j 63 < "
; Expanded expression: "(@-116) *(2) 63 < "
; Fused expression:    "< *(@-116) 63 IF! "
	mov	ax, [bp-116]
	cmp	ax, 63
	jge	L398
; RPN'ized expression: "a1 j ++p + *u line i + *u = "
; Expanded expression: "(@-80) (@-116) ++p(2) + (@4) *(2) (@-114) *(2) + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-116) + (@-80) ax push-ax + *(@4) *(@-114) =(119) **sp *ax "
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
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-114) ++p(2) "
; Fused expression:    "++p(2) *(@-114) "
	mov	ax, [bp-114]
	inc	word [bp-114]
; }
	jmp	L395
L396:
; RPN'ized expression: "a1 j + *u 0 = "
; Expanded expression: "(@-80) (@-116) *(2) + 0 =(-1) "
; Fused expression:    "+ (@-80) *(@-116) =(122) *ax 0 "
	lea	ax, [bp-80]
	add	ax, [bp-116]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; RPN'ized expression: "( pass , a2 , a1 , op assemble_line ) "
; Expanded expression: " (@6) *(2)  (@-112)  (@-80)  (@-16)  assemble_line ()8 "
; Fused expression:    "( *(2) (@6) , (@-112) , (@-80) , (@-16) , assemble_line )8 "
	push	word [bp+6]
	lea	ax, [bp-112]
	push	ax
	lea	ax, [bp-80]
	push	ax
	lea	ax, [bp-16]
	push	ax
	call	_assemble_line
	sub	sp, -8
; return
	jmp	L357
; }
L389:
; while
; RPN'ized expression: "line i + *u 32 == line i + *u 9 == || line i + *u 44 == || "
; Expanded expression: "(@4) *(2) (@-114) *(2) + *(-1) 32 == [sh||->403] (@4) *(2) (@-114) *(2) + *(-1) 9 == ||[403] _Bool [sh||->402] (@4) *(2) (@-114) *(2) + *(-1) 44 == ||[402] "
L400:
; Fused expression:    "+ *(@4) *(@-114) == *ax 32 [sh||->403] + *(@4) *(@-114) == *ax 9 ||[403] _Bool [sh||->402] + *(@4) *(@-114) == *ax 44 ||[402]  "
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	sete	al
	cbw
; JumpIfNotZero
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
; JumpIfNotZero
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
; JumpIfZero
	test	ax, ax
	je	L401
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-114) ++p(2) "
; Fused expression:    "++p(2) *(@-114) "
	mov	ax, [bp-114]
	inc	word [bp-114]
	jmp	L400
L401:
; RPN'ized expression: "j 0 = "
; Expanded expression: "(@-116) 0 =(2) "
; Fused expression:    "=(170) *(@-116) 0 "
	mov	ax, 0
	mov	[bp-116], ax
; while
; RPN'ized expression: "line i + *u line i + *u 44 != && line i + *u 32 != && line i + *u 9 != && line i + *u 10 != && line i + *u 59 != && "
; Expanded expression: "(@4) *(2) (@-114) *(2) + *(-1) _Bool [sh&&->410] (@4) *(2) (@-114) *(2) + *(-1) 44 != &&[410] _Bool [sh&&->409] (@4) *(2) (@-114) *(2) + *(-1) 32 != &&[409] _Bool [sh&&->408] (@4) *(2) (@-114) *(2) + *(-1) 9 != &&[408] _Bool [sh&&->407] (@4) *(2) (@-114) *(2) + *(-1) 10 != &&[407] _Bool [sh&&->406] (@4) *(2) (@-114) *(2) + *(-1) 59 != &&[406] "
L404:
; Fused expression:    "+ *(@4) *(@-114) *(-1) ax _Bool [sh&&->410] + *(@4) *(@-114) != *ax 44 &&[410] _Bool [sh&&->409] + *(@4) *(@-114) != *ax 32 &&[409] _Bool [sh&&->408] + *(@4) *(@-114) != *ax 9 &&[408] _Bool [sh&&->407] + *(@4) *(@-114) != *ax 10 &&[407] _Bool [sh&&->406] + *(@4) *(@-114) != *ax 59 &&[406]  "
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L405
; {
; if
; RPN'ized expression: "j 63 < "
; Expanded expression: "(@-116) *(2) 63 < "
; Fused expression:    "< *(@-116) 63 IF! "
	mov	ax, [bp-116]
	cmp	ax, 63
	jge	L411
; RPN'ized expression: "a1 j ++p + *u line i + *u = "
; Expanded expression: "(@-80) (@-116) ++p(2) + (@4) *(2) (@-114) *(2) + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-116) + (@-80) ax push-ax + *(@4) *(@-114) =(119) **sp *ax "
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
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-114) ++p(2) "
; Fused expression:    "++p(2) *(@-114) "
	mov	ax, [bp-114]
	inc	word [bp-114]
; }
	jmp	L404
L405:
; RPN'ized expression: "a1 j + *u 0 = "
; Expanded expression: "(@-80) (@-116) *(2) + 0 =(-1) "
; Fused expression:    "+ (@-80) *(@-116) =(122) *ax 0 "
	lea	ax, [bp-80]
	add	ax, [bp-116]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; while
; RPN'ized expression: "line i + *u 32 == line i + *u 9 == || line i + *u 44 == || "
; Expanded expression: "(@4) *(2) (@-114) *(2) + *(-1) 32 == [sh||->416] (@4) *(2) (@-114) *(2) + *(-1) 9 == ||[416] _Bool [sh||->415] (@4) *(2) (@-114) *(2) + *(-1) 44 == ||[415] "
L413:
; Fused expression:    "+ *(@4) *(@-114) == *ax 32 [sh||->416] + *(@4) *(@-114) == *ax 9 ||[416] _Bool [sh||->415] + *(@4) *(@-114) == *ax 44 ||[415]  "
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 32
	sete	al
	cbw
; JumpIfNotZero
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
; JumpIfNotZero
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
; JumpIfZero
	test	ax, ax
	je	L414
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-114) ++p(2) "
; Fused expression:    "++p(2) *(@-114) "
	mov	ax, [bp-114]
	inc	word [bp-114]
	jmp	L413
L414:
; RPN'ized expression: "j 0 = "
; Expanded expression: "(@-116) 0 =(2) "
; Fused expression:    "=(170) *(@-116) 0 "
	mov	ax, 0
	mov	[bp-116], ax
; while
; RPN'ized expression: "line i + *u line i + *u 10 != && line i + *u 59 != && "
; Expanded expression: "(@4) *(2) (@-114) *(2) + *(-1) _Bool [sh&&->420] (@4) *(2) (@-114) *(2) + *(-1) 10 != &&[420] _Bool [sh&&->419] (@4) *(2) (@-114) *(2) + *(-1) 59 != &&[419] "
L417:
; Fused expression:    "+ *(@4) *(@-114) *(-1) ax _Bool [sh&&->420] + *(@4) *(@-114) != *ax 10 &&[420] _Bool [sh&&->419] + *(@4) *(@-114) != *ax 59 &&[419]  "
	mov	ax, [bp+4]
	add	ax, [bp-114]
	mov	bx, ax
	mov	al, [bx]
	cbw
	test	ax, ax
	setne	al
	cbw
; JumpIfZero
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
; JumpIfZero
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
; JumpIfZero
	test	ax, ax
	je	L418
; {
; if
; RPN'ized expression: "j 31 < "
; Expanded expression: "(@-116) *(2) 31 < "
; Fused expression:    "< *(@-116) 31 IF! "
	mov	ax, [bp-116]
	cmp	ax, 31
	jge	L421
; RPN'ized expression: "a2 j ++p + *u line i + *u = "
; Expanded expression: "(@-112) (@-116) ++p(2) + (@4) *(2) (@-114) *(2) + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-116) + (@-112) ax push-ax + *(@4) *(@-114) =(119) **sp *ax "
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
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-114) ++p(2) "
; Fused expression:    "++p(2) *(@-114) "
	mov	ax, [bp-114]
	inc	word [bp-114]
; }
	jmp	L417
L418:
; RPN'ized expression: "a2 j + *u 0 = "
; Expanded expression: "(@-112) (@-116) *(2) + 0 =(-1) "
; Fused expression:    "+ (@-112) *(@-116) =(122) *ax 0 "
	lea	ax, [bp-112]
	add	ax, [bp-116]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; if
; RPN'ized expression: "op 0 + *u "
; Expanded expression: "(@-16) *(-1) "
; Fused expression:    "*(-1) (@-16)  "
	mov	al, [bp-16]
	cbw
; JumpIfZero
	test	ax, ax
	je	L423
; RPN'ized expression: "( pass , a2 , a1 , op assemble_line ) "
; Expanded expression: " (@6) *(2)  (@-112)  (@-80)  (@-16)  assemble_line ()8 "
; Fused expression:    "( *(2) (@6) , (@-112) , (@-80) , (@-16) , assemble_line )8 "
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

; glb run_pass : (
; prm     fd : int
; prm     pass : int
;     ) void
section .text
	global	_run_pass
_run_pass:
	push	bp
	mov	bp, sp
	 sub	sp,          4
; loc     fd : (@4) : int
; loc     pass : (@6) : int
; loc     ch : (@-2) : char
; loc     lp : (@-4) : int
; RPN'ized expression: "lp 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; RPN'ized expression: "binary_size 0 = "
; Expanded expression: "binary_size 0 =(2) "
; Fused expression:    "=(170) *binary_size 0 "
	mov	ax, 0
	mov	[_binary_size], ax
; RPN'ized expression: "( 0 , fd , 49 syscal ) "
; Expanded expression: " 0  (@4) *(2)  49  syscal ()6 "
; Fused expression:    "( 0 , *(2) (@4) , 49 , syscal )6 "
	push	0
	push	word [bp+4]
	push	49
	call	_syscal
	sub	sp, -6
; while
; RPN'ized expression: "( 1 , ch &u , fd , 47 syscal ) 0 > "
; Expanded expression: " 1  (@-2)  (@4) *(2)  47  syscal ()8 0 > "
L427:
; Fused expression:    "( 1 , (@-2) , *(2) (@4) , 47 , syscal )8 > ax 0 IF! "
	push	1
	lea	ax, [bp-2]
	push	ax
	push	word [bp+4]
	push	47
	call	_syscal
	sub	sp, -8
	cmp	ax, 0
	jle	L428
; {
; if
; RPN'ized expression: "ch 10 == lp 128 1 - >= || "
; Expanded expression: "(@-2) *(-1) 10 == [sh||->431] (@-4) *(2) 127 >= ||[431] "
; Fused expression:    "== *(@-2) 10 [sh||->431] >= *(@-4) 127 ||[431]  "
	mov	al, [bp-2]
	cbw
	cmp	ax, 10
	sete	al
	cbw
; JumpIfNotZero
	test	ax, ax
	jne	L431
	mov	ax, [bp-4]
	cmp	ax, 127
	setge	al
	cbw
L431:
; JumpIfZero
	test	ax, ax
	je	L429
; {
; RPN'ized expression: "line_buffer lp + *u 0 = "
; Expanded expression: "line_buffer (@-4) *(2) + 0 =(-1) "
; Fused expression:    "+ line_buffer *(@-4) =(122) *ax 0 "
	mov	ax, _line_buffer
	add	ax, [bp-4]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; RPN'ized expression: "( pass , line_buffer parse_line ) "
; Expanded expression: " (@6) *(2)  line_buffer  parse_line ()4 "
; Fused expression:    "( *(2) (@6) , line_buffer , parse_line )4 "
	push	word [bp+6]
	push	_line_buffer
	call	_parse_line
	sub	sp, -4
; RPN'ized expression: "lp 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; }
	jmp	L430
L429:
; else
; {
; RPN'ized expression: "line_buffer lp ++p + *u ch = "
; Expanded expression: "line_buffer (@-4) ++p(2) + (@-2) *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-4) + line_buffer ax =(119) *ax *(@-2) "
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
; }
L430:
; }
	jmp	L427
L428:
; if
; RPN'ized expression: "lp 0 > "
; Expanded expression: "(@-4) *(2) 0 > "
; Fused expression:    "> *(@-4) 0 IF! "
	mov	ax, [bp-4]
	cmp	ax, 0
	jle	L432
; {
; RPN'ized expression: "line_buffer lp + *u 0 = "
; Expanded expression: "line_buffer (@-4) *(2) + 0 =(-1) "
; Fused expression:    "+ line_buffer *(@-4) =(122) *ax 0 "
	mov	ax, _line_buffer
	add	ax, [bp-4]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; RPN'ized expression: "( pass , line_buffer parse_line ) "
; Expanded expression: " (@6) *(2)  line_buffer  parse_line ()4 "
; Fused expression:    "( *(2) (@6) , line_buffer , parse_line )4 "
	push	word [bp+6]
	push	_line_buffer
	call	_parse_line
	sub	sp, -4
; }
L432:
L425:
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
	 sub	sp,         64
; loc     args : (@4) : * [32u] char
; RPN'ized expression: "30 "
; Expanded expression: "30 "
; Expression value: 30
; loc     src : (@-30) : [30u] char
; RPN'ized expression: "30 "
; Expanded expression: "30 "
; Expression value: 30

section .data
L436:
	db	"a.out"
	times	25 db 0

section .text
; loc     out : (@-60) : [30u] char
; =
; Fused expression:    "( (@-60) , L436 , 30u , L360 )6 "
	lea	ax, [bp-60]
	push	ax
	push	L436
	push	30
	call	L360
	sub	sp, -6
; loc     fd : (@-62) : int
; loc     ofd : (@-64) : int
; if
; RPN'ized expression: "args 1 + *u 0 + *u "
; Expanded expression: "(@4) *(2) 32 + *(-1) "
; Fused expression:    "+ *(@4) 32 *(-1) ax  "
	mov	ax, [bp+4]
	add	ax, 32
	mov	bx, ax
	mov	al, [bx]
	cbw
; JumpIfZero
	test	ax, ax
	je	L437
; {
; RPN'ized expression: "( 30 , args 1 + *u , src str_copy ) "
; Expanded expression: " 30  (@4) *(2) 32 +  (@-30)  str_copy ()6 "
; Fused expression:    "( 30 , + *(@4) 32 , (@-30) , str_copy )6 "
	push	30
	mov	ax, [bp+4]
	add	ax, 32
	push	ax
	lea	ax, [bp-30]
	push	ax
	call	_str_copy
	sub	sp, -6
; if
; RPN'ized expression: "args 2 + *u 0 + *u "
; Expanded expression: "(@4) *(2) 64 + *(-1) "
; Fused expression:    "+ *(@4) 64 *(-1) ax  "
	mov	ax, [bp+4]
	add	ax, 64
	mov	bx, ax
	mov	al, [bx]
	cbw
; JumpIfZero
	test	ax, ax
	je	L439
; RPN'ized expression: "( 30 , args 2 + *u , out str_copy ) "
; Expanded expression: " 30  (@4) *(2) 64 +  (@-60)  str_copy ()6 "
; Fused expression:    "( 30 , + *(@4) 64 , (@-60) , str_copy )6 "
	push	30
	mov	ax, [bp+4]
	add	ax, 64
	push	ax
	lea	ax, [bp-60]
	push	ax
	call	_str_copy
	sub	sp, -6
L439:
; }
	jmp	L438
L437:
; else
; {

section .rodata
L441:
	db	"source (.asm): "
	times	1 db 0

section .text
; RPN'ized expression: "( L441 , 9 syscal ) "
; Expanded expression: " L441  9  syscal ()4 "
; Fused expression:    "( L441 , 9 , syscal )4 "
	push	L441
	push	9
	call	_syscal
	sub	sp, -4
; RPN'ized expression: "( src , 10 syscal ) "
; Expanded expression: " (@-30)  10  syscal ()4 "
; Fused expression:    "( (@-30) , 10 , syscal )4 "
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
; RPN'ized expression: "( L442 , 9 syscal ) "
; Expanded expression: " L442  9  syscal ()4 "
; Fused expression:    "( L442 , 9 , syscal )4 "
	push	L442
	push	9
	call	_syscal
	sub	sp, -4
; RPN'ized expression: "( out , 10 syscal ) "
; Expanded expression: " (@-60)  10  syscal ()4 "
; Fused expression:    "( (@-60) , 10 , syscal )4 "
	lea	ax, [bp-60]
	push	ax
	push	10
	call	_syscal
	sub	sp, -4
; }
L438:
; RPN'ized expression: "fd ( 2 , src , 45 syscal ) = "
; Expanded expression: "(@-62)  2  (@-30)  45  syscal ()6 =(2) "
; Fused expression:    "( 2 , (@-30) , 45 , syscal )6 =(170) *(@-62) ax "
	push	2
	lea	ax, [bp-30]
	push	ax
	push	45
	call	_syscal
	sub	sp, -6
	mov	[bp-62], ax
; if
; RPN'ized expression: "fd 0 < "
; Expanded expression: "(@-62) *(2) 0 < "
; Fused expression:    "< *(@-62) 0 IF! "
	mov	ax, [bp-62]
	cmp	ax, 0
	jge	L443
; {

section .rodata
L445:
	db	"can't open source",10
	times	1 db 0

section .text
; RPN'ized expression: "( L445 , 9 syscal ) "
; Expanded expression: " L445  9  syscal ()4 "
; Fused expression:    "( L445 , 9 , syscal )4 "
	push	L445
	push	9
	call	_syscal
	sub	sp, -4
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1  "
	mov	ax, 1
	jmp	L434
; }
L443:
; RPN'ized expression: "label_count 0 = "
; Expanded expression: "label_count 0 =(2) "
; Fused expression:    "=(170) *label_count 0 "
	mov	ax, 0
	mov	[_label_count], ax
; RPN'ized expression: "( 0 , fd run_pass ) "
; Expanded expression: " 0  (@-62) *(2)  run_pass ()4 "
; Fused expression:    "( 0 , *(2) (@-62) , run_pass )4 "
	push	0
	push	word [bp-62]
	call	_run_pass
	sub	sp, -4
; RPN'ized expression: "( 1 , fd run_pass ) "
; Expanded expression: " 1  (@-62) *(2)  run_pass ()4 "
; Fused expression:    "( 1 , *(2) (@-62) , run_pass )4 "
	push	1
	push	word [bp-62]
	call	_run_pass
	sub	sp, -4
; RPN'ized expression: "( fd , 46 syscal ) "
; Expanded expression: " (@-62) *(2)  46  syscal ()4 "
; Fused expression:    "( *(2) (@-62) , 46 , syscal )4 "
	push	word [bp-62]
	push	46
	call	_syscal
	sub	sp, -4
; RPN'ized expression: "ofd ( 5 , out , 45 syscal ) = "
; Expanded expression: "(@-64)  5  (@-60)  45  syscal ()6 =(2) "
; Fused expression:    "( 5 , (@-60) , 45 , syscal )6 =(170) *(@-64) ax "
	push	5
	lea	ax, [bp-60]
	push	ax
	push	45
	call	_syscal
	sub	sp, -6
	mov	[bp-64], ax
; if
; RPN'ized expression: "ofd 0 < "
; Expanded expression: "(@-64) *(2) 0 < "
; Fused expression:    "< *(@-64) 0 IF! "
	mov	ax, [bp-64]
	cmp	ax, 0
	jge	L446
; {

section .rodata
L448:
	db	"can't open output",10
	times	1 db 0

section .text
; RPN'ized expression: "( L448 , 9 syscal ) "
; Expanded expression: " L448  9  syscal ()4 "
; Fused expression:    "( L448 , 9 , syscal )4 "
	push	L448
	push	9
	call	_syscal
	sub	sp, -4
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1  "
	mov	ax, 1
	jmp	L434
; }
L446:
; RPN'ized expression: "( binary_size , output_binary , ofd , 48 syscal ) "
; Expanded expression: " binary_size *(2)  output_binary  (@-64) *(2)  48  syscal ()8 "
; Fused expression:    "( *(2) binary_size , output_binary , *(2) (@-64) , 48 , syscal )8 "
	push	word [_binary_size]
	push	_output_binary
	push	word [bp-64]
	push	48
	call	_syscal
	sub	sp, -8
; RPN'ized expression: "( ofd , 46 syscal ) "
; Expanded expression: " (@-64) *(2)  46  syscal ()4 "
; Fused expression:    "( *(2) (@-64) , 46 , syscal )4 "
	push	word [bp-64]
	push	46
	call	_syscal
	sub	sp, -4

section .rodata
L449:
	db	"assembled: "
	times	1 db 0

section .text
; RPN'ized expression: "( L449 , 9 syscal ) "
; Expanded expression: " L449  9  syscal ()4 "
; Fused expression:    "( L449 , 9 , syscal )4 "
	push	L449
	push	9
	call	_syscal
	sub	sp, -4
; RPN'ized expression: "( binary_size , 12 syscal ) "
; Expanded expression: " binary_size *(2)  12  syscal ()4 "
; Fused expression:    "( *(2) binary_size , 12 , syscal )4 "
	push	word [_binary_size]
	push	12
	call	_syscal
	sub	sp, -4

section .rodata
L450:
	db	" bytes",10
	times	1 db 0

section .text
; RPN'ized expression: "( L450 , 9 syscal ) "
; Expanded expression: " L450  9  syscal ()4 "
; Fused expression:    "( L450 , 9 , syscal )4 "
	push	L450
	push	9
	call	_syscal
	sub	sp, -4
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L434
; Fused expression:    "0  "
	mov	ax, 0
L434:
	leave
	ret

section .text
L360:
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

; Syntax/declaration table/stack:
; Bytes used: 1495/15360


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
; Macro MAX_LINE_LEN = `128`
; Macro MAX_LABELS = `64`
; Macro MAX_CODE_SIZE = `1024`
; Macro LOAD_ADDRESS = `0xC000`
; Bytes used: 699/5120


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
; Ident name
; Ident address
; Ident Label
; Ident label_table
; Ident label_count
; Ident line_buffer
; Ident output_binary
; Ident binary_size
; Ident str_eq
; Ident a
; Ident b
; Ident str_copy
; Ident dst
; Ident src
; Ident max
; Ident clean_token
; Ident find_label
; Ident add_label
; Ident addr
; Ident is_bp_mem
; Ident tok
; Ident disp
; Ident reg_id
; Ident r
; Ident emit1
; Ident pass
; Ident b0
; Ident emit2
; Ident b1
; Ident emit3
; Ident b2
; Ident emit4
; Ident b3
; Ident resolve_imm
; Ident emit_db
; Ident args
; Ident assemble_line
; Ident op
; Ident a1
; Ident a2
; Ident parse_line
; Ident line
; Ident run_pass
; Ident fd
; Ident main
; Bytes used: 597/5632

; Next label number: 451
; Compilation succeeded.
