
bits 16
section .text
global _start

extern _main
extern _prog_start

_start:
	push bp
	mov bp, sp
	
	push word [bp+4]
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

	mov ax, [bp+4]
	mov bx, [bp+6]
	mov cx, [bp+8]
	mov dx, [bp+10]

	int 0x60
	
	pop dx
	pop cx
	pop bx

	pop bp
	ret
