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
; *                            drivers/diskdump.asm                           *
; *                                                                           *
; ***************************************************************************

[bits 16]
extern _get_boot_drive
extern _probe_drive
global _dump_disk

_dump_disk:
	push bp
	mov bp, sp
	push es
	
	push 0x70
	push 0x08
	
	call _pic_remap
	add sp, 4
	
	mov dl, [bp+4]      ; current disk number
	mov dh, 0           ;     head <-- 0
	mov ch, 0           ; cylinder <-- 0
	mov cl, 1           ;   sector <-- 1
	
	xor ax, ax
	mov es, ax
	mov bx, 0xE000
	
	mov al, 16
	
	mov ah, 0x02                ; read sectors
	int 0x13
	jc .error
	xor ax, ax                  ; AX=0 -> success
	jmp .done
.error:
	mov ax, 1                   ; AX=1 -> error
.done:
	push 0x28
	push 0x20
	call _pic_remap
	add sp, 4

	pop es
	pop bp
	ret