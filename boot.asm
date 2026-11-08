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
; *                                  boot.asm                                 *
; *                                                                           *
; ***************************************************************************

; sector number 1
[org 0x7c00]    		; as BIOS loads it to 0x7c00
[bits 16]       		; for backward compatibility

bootloader:
	; for now setting all segments to 0 
	xor ax, ax
    mov ds, ax
    mov es, ax
	mov ss, ax
	mov sp, 0x7C00		; stack grows upward
	
	mov [OSDisk], dl	; current disk number
	mov bx, 0x8000
	call loadkernel		; load into ES:BX = 0x0000:0x8000 = 0x8000
	
	mov al, [OSDisk]
	push ax
	jmp 0x8000  		; control transfer to kernel (kernel.asm)
	
loadkernel:
; reading binaries of kernel.asm from 2nd sector
	mov ah, 0x02		; read disk mode
	mov dl, [OSDisk]	; current disk number
	mov dh, 0   		;     head <-- 0
	mov ch, 0   		; cylinder <-- 0
	mov cl, 2   		;   sector <-- 2
	mov al, 31   		; sectors <-- 32 (loads 2~32 sectors)
	int 0x13    		; disk service interrupt
	ret

OSDisk db 0

times 510-($-$$) db 0 	; padding to ensure 510 bytes
db 0x55, 0xaa         	; boot signature ; total 512 bytes
