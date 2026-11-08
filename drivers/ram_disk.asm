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
; *                            drivers/ram_disk.asm                           *
; *                                                                           *
; ***************************************************************************

[bits 16]
extern _get_boot_drive
global _transfer_to_ram, _commit_to_disk
global _ram_read, _ram_write
global _probe_drive

; --- int probe_drive(uint8_t bios_id) -----------------------------------
; returns 1 if drive exists, 0 if not
_probe_drive:
    push bp
	push 0x70
	push 0x08
	call _pic_remap
	add sp, 4
	
    mov bp, sp
    mov dl, [bp+4]      ; bios_id
    xor ah, ah          ; reset
    int 0x13
    jc .not_found
    mov ax, 1
    jmp .done
.not_found:
    xor ax, ax
.done:

	push 0x28
	push 0x20
	call _pic_remap
	add sp, 4
	
    pop bp
    ret


; --- Transfer disk -> RAM (0x10000) ----------------------------------------
_transfer_to_ram:
   	push es
	
	push 0x70
	push 0x08
	call _pic_remap
	add sp, 4
	
	mov ax, 0x1000
	mov es, ax
	xor bx, bx
	
	call _get_boot_drive
	mov dl, al         	; current disk number
	mov dh, 0   		;     head <-- 0
	mov ch, 0   		; cylinder <-- 0
	mov cl, 1   		;   sector <-- 1
	cmp dl, 0x80
    je .hdd_mode
.fdd_mode:
    mov al, 32                  ; safe for floppy
    jmp .do_read
.hdd_mode:
    mov al, 128                 ; max for hard disk
.do_read:
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
    ret

; --- Transfer RAM -> disk --------------------------------------------------
_commit_to_disk:
   	push es
	
	push 0x70
	push 0x08
	call _pic_remap
	add sp, 4
	
	mov ax, 0x1000
	mov es, ax
	xor bx, bx
	
	mov dl, 0x80        ; always commit or install to hard disk
	mov dh, 0   		;     head <-- 0
	mov ch, 0   		; cylinder <-- 0
	mov cl, 1   		;   sector <-- 1
	mov ah, 0x03		; write sectors
	mov al, 128   		; loads 1~128 sectors)
	int 0x13    		; disk service interrupt
	jc .error           ; jump if CF=1 (error)
    xor ax, ax          ; success -> AX=0
    jmp .done
.error:
    mov ax, 1           ; error -> AX=1
.done:
	push 0x28
	push 0x20
	call _pic_remap
	add sp, 4
	
	pop es
	ret
    

; --- void _ram_write(uint16_t block, void* buf) ---------------------------
_ram_write:
    push bp
    mov bp, sp
    push es
    push ds
    push si
    push di
    push cx

    ; -- source: DS:SI = caller's buf --------------------------------------
    mov si, [bp+6]          ; buf pointer

    ; -- destination: ramdisk[block * 512] ---------------------------------
    mov ax, [bp+4]          ; block number
    mov cx, 0x0020          ; 512 / 16 = 32 = 0x20 segments per block
    mul cx                  ; AX = block * 0x20
    add ax, 0x1000          ; AX = final segment
    mov es, ax
    xor di, di              ; offset always 0

    mov cx, 256             ; copy 512 bytes (256 words)
    cld
    rep movsw

    pop cx
    pop di
    pop si
    pop ds
    pop es
    pop bp
    ret

; --- void _ram_read(uint16_t block, void* buf) ----------------------------
; ramdisk block -> buf (DS:ptr)
_ram_read:
    push bp
    mov bp, sp
    push es
    push ds
    push si
    push di
    push cx

    ; -- source: ramdisk[block * 512] --------------------------------------
    mov ax, [bp+4]          ; block number
    mov cx, 0x0020          ; segments per block
    mul cx                  ; AX = block * 0x20
    add ax, 0x1000          ; AX = segment
    mov ds, ax
    xor si, si              ; offset always 0

    ; -- destination: caller's buf ------------------------------------------
    mov di, [bp+6]          ; buf offset
    mov ax, ss
    mov es, ax
    mov cx, 256
    cld
    rep movsw

    pop cx
    pop di
    pop si
    pop ds
    pop es
    pop bp
    ret