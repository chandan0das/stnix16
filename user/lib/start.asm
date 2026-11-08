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
; *                             user/lib/start.asm                            *
; *                                                                           *
; ***************************************************************************

bits 16
section .text
global _start

extern _main
extern _prog_start

_start:
	push bp
	mov bp, sp
	
	push word [bp+4]    ; cmd_line
    call _prog_start
    add sp, 2
	
	pop bp
	ret


global _syscal
_syscal:
	push bp
	mov bp, sp
	
	push bx
	push cx
	push dx

	mov ax, [bp+4]   ; syscall number
	mov bx, [bp+6]   ; arg1
	mov cx, [bp+8]   ; arg2
	mov dx, [bp+10]  ; arg3

	int 0x60		 ; trigger syscall
	
	pop dx
	pop cx
	pop bx

	pop bp
	ret
