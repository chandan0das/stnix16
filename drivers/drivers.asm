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
; *                            drivers/drivers.asm                            *
; *                                                                           *
; ***************************************************************************

[bits 16]
global _outb, _inb, _vga_poke, _vga_scroll

_outb:
	push bp
	mov bp, sp
	mov dx, [bp+4]
	mov ax, [bp+6]
	out dx, al
	pop bp
	ret

_inb:		   
	push bp
	mov bp, sp
	mov dx, [bp+4]
	in al, dx
	pop bp
	ret

_vga_poke:	  
	push bp
	mov bp, sp
	push es
	mov ax, 0xB800
	mov es, ax
	mov bx, [bp+4]
	mov ah, [bp+6]
	mov al, [bp+8]
	mov [es:bx], ax
	pop es
	pop bp
	ret

_vga_scroll:
	push bp
	mov bp, sp
	push ds
	push es
	push ax
	push bx

	mov ax, 0xB800
	mov ds, ax
	mov es, ax

	; Step 1: Scroll up - move rows 1 to 24 into rows 0 to 23
	mov si, 160
	mov di, 0
	mov cx, 1920		  ; 24 * 80 words
	cld
	rep movsw

	; Step 2: Clear bottom row using the passed style
	mov al, [bp+4]		; Load the style byte (foreground + background + blink)
	mov ah, al			; Duplicate style into AH
	mov al, ' '		   ; Character = space
	; Now AX = (style << 8) | ' '

	mov di, 3840		  ; Start of bottom row (25th line)
	mov cx, 80			; 80 characters
	rep stosw			 ; Fill the line

	pop bx
	pop ax
	pop es
	pop ds
	pop bp
	ret
	

global _pic_remap

_pic_remap:	 ; void pic_remap(uint8_t master_offset, uint8_t slave_offset)
	push bp
	mov bp, sp
	pusha
	
	; ICW1: Start initialization
	mov al, 0x11       ; ICW1
	out 0x20, al
	out 0xA0, al
	; ICW2: Vector offsets (IRQ 0-7 -> INT 32-39, IRQ 8-15 -> INT 40-47)
	mov al, [bp+4]     ; ICW2 - Master offset (use 0x20)
	out 0x21, al
	mov al, [bp+6]     ; ICW2 - Slave offset (use 0x28)
	out 0xA1, al
	; ICW3: PIC cascading
	mov al, 0x04
	out 0x21, al
	mov al, 0x02
	out 0xA1, al
	; ICW4: 8086 mode
	mov al, 0x01       ; ICW4
	out 0x21, al
	out 0xA1, al
	; everything unmasked for now — for debugging
	mov al, 0x00       ; allow all master IRQs
	out 0x21, al
	mov al, 0x00       ; allow all slave IRQs
	out 0xA1, al

	popa
	pop bp
	ret
	
;Master PIC (0x21)		 Slave PIC (0xA1)
;Bit 0 = IRQ0  Timer	   Bit 0 = IRQ8  RTC
;Bit 1 = IRQ1  Keyboard	Bit 1 = IRQ9  
;Bit 2 = IRQ2  Cascade	 Bit 2 = IRQ10
;Bit 3 = IRQ3  COM2		Bit 3 = IRQ11
;Bit 4 = IRQ4  COM1		Bit 4 = IRQ12 PS/2 Mouse
;Bit 5 = IRQ5			  Bit 5 = IRQ13 FPU
;Bit 6 = IRQ6  Floppy	  Bit 6 = IRQ14 HDD Primary
;Bit 7 = IRQ7  LPT1		Bit 7 = IRQ15 HDD Secondary