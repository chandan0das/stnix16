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
; *                             kernel/kernel.asm                             *
; *                                                                           *
; ***************************************************************************

bits 16
section .text
global _start

extern _main

_start:
	pop ax
	mov [boot_drive], al

	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x8000
	
	cli                             ; Disable interrupts while setting vector
	mov word [es:0x180], _syscal_h  ; Offset for int 0x60
	mov word [es:0x182], cs         ; Segment for int 0x60
	
	; Timer ISR (IRQ 0 -> INT 0x20)
	mov word [0x80], _timer_isr
	mov word [0x82], 0x0000
	
	; Keyboard ISR (IRQ 1 -> INT 0x21)
	mov word [0x84], _keyboard_isr
	mov word [0x86], 0x0000
	sti					 ; Re-enable interrupts
	
	
	call _main
	
boot_drive db 0

global _get_boot_drive
_get_boot_drive:
	mov al, [boot_drive]
	ret


global __sp
__sp:
	mov ax, sp
	ret

global __hlt
__hlt:
	sti
	hlt
	ret

global __poweroff
__poweroff:
	mov ax, 0x5307	; APM Set Power State
	mov bx, 0x0001	; All devices
	mov cx, 0x0003	; Off
	int 0x15
	
	; If APM fails, we hang
	cli
	hlt
	jmp $
	
extern _timer_handler
_timer_isr:
	pusha
	call _timer_handler
	mov al, 0x20		; EOI
	out 0x20, al
	popa
	iret

extern _keyboard_handler
_keyboard_isr:
	pusha
	call _keyboard_handler
	mov al, 0x20		; EOI
	out 0x20, al
	popa
	iret

	
%include "kernel/syscall_h.asm"	
%include "drivers/drivers.asm"
%include "drivers/ram_disk.asm"
%include "drivers/diskdump.asm"

; == intermodule dependencies ==
; any_module  uses (kernel)
; main 		  uses (kernel, any_module)
; 

; == initial memory layout ==
; 0xFFFF ┌─────────────────┐
;        │   Dumping Space │
; 0xE000 ├─────────────────┤
;        │   USER SPACE    │
;        │                 │
; 0xA000 ├─────────────────┤
;        │   KERNEL   ▲    │
; 0x8000 ├═════════════════┤
;        │   STACK    ▼    │
;        │                 │
;        │                 │
;        │   HEAP     ▲    │
; 0x0800 ├─────────────────┤
;        │  (IVT / BIOS)   │
; 0x0000 └─────────────────┘
;
; RAM-DISK : 0x10000 ~ 0x1FFFF

dd 0xDEADC0DE