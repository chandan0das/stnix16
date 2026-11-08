/*
Copyright (c) 2026, Chandan Das
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/*****************************************************************************/
/*                                                                           */
/*                                  STNIX 16                                 */
/*                                                                           */
/*                A 16-bit monolithic operating system for x86               */
/*                                                                           */
/*                               drivers/char.c                              */
/*                                                                           */
/*****************************************************************************/

#include "drivers.h"
#include "kernel.h"
#include "char.h"
#include "keyboard.h"

int cursor_x = 0, cursor_y = 0;
unsigned char _char_style = 0x1E; // 0x70

// to me : do not change these functions for now =========================== ///
void char_init() {
	cursor_x = 0; cursor_y = 0;
	update_cursor();
	k_char_style( WHITE, BLACK, 0);
}

void update_cursor() {
	unsigned int pos = cursor_y * VGA_WIDTH + cursor_x;
	outb(0x3D4, 0x0F);
	outb(0x3D5, (unsigned int )(pos & 0xFF));
	outb(0x3D4, 0x0E);
	outb(0x3D5, (unsigned int )((pos >> 8) & 0xFF));
}

int  k_get_x(void) { return cursor_x; }
int  k_get_y(void) { return cursor_y; }
void k_set_x(int x) { cursor_x = x; }
void k_set_y(int y) { cursor_y = y; }

void k_char_style(unsigned char fg, unsigned char bg, unsigned char blink) {
	unsigned char attr = 0;
	if (blink) attr |= 0x80;   // bit 7 = blink
	attr |= (bg & 0x07) << 4;  // background in bits 4–6
	attr |= (fg & 0x0F);       // foreground in bits 0–3
	_char_style = attr;
}


void k_putchar(char c) {
	if (cursor_x >= VGA_WIDTH) { cursor_x = 0; cursor_y++; }
	if (cursor_y >= VGA_HEIGHT) { vga_scroll(_char_style); cursor_y = VGA_HEIGHT-1; }
	
	// handles special character
	if (c == '\n') { cursor_x = 0; cursor_y++; }
	else if (c == '\b') { if (cursor_x > 0) cursor_x--; }
	else if (c == '\t') { 
		cursor_x = (cursor_x + 8) & ~(8 - 1);
		if (cursor_x >= VGA_WIDTH) { cursor_x = 0; cursor_y++; }
	}
	else if (c == '\r') { cursor_x = 0; }
	
	// normal character writing
	else {
		unsigned int offset = (cursor_y * VGA_WIDTH + cursor_x) * 2;
		vga_poke(offset, _char_style, c);
		cursor_x++;
	}
	update_cursor();
}

void k_clrscr(void) {
	for (int i = 0; i < 2000; i++) k_putchar(' ');
	cursor_x = 0; cursor_y = 0;
}

int _pformat(const char * f, ...) {
	int count = 0;
	const char* p = f;
	int *args = (int*)(&f +1);
	while (*p) {
		if (*p == '~') {
			p++;
			switch (*p) {
				case 'c' : _putchar((char)*args++);        break;
				case 's' : _puts((const char*)*args++);    break;
				case 'i' : _puti((int)*args++);            break;
				case 'x' : _putx((unsigned int)*args++);   break;
				default  : _putchar('~'); _putchar(*p);
			}
		}
		else {
			_putchar(*p);
		}
		p++;
	}
	return 0;
} 

int _puti(int n) {
	char buf[20];
	int i = 19, sign = 0;
	buf[i] = '\0';
	
	if (n < 0) {sign = 1; n = -n; }
	do {
		buf[--i] = (n%10) + '0';
		n /= 10;
	} while (n > 0);
	
	if (sign) buf[--i] = '-';
	return _puts(&buf[i]);
}

int _putx(unsigned int n) {
    char buf[11] = "00000000000";
    int i = 10;
    const char* hex = "0123456789ABCDEF";
    buf[i] = '\0';

    do {
        buf[--i] = hex[n & 0xF];
        n >>= 4;
    } while (n > 0);
	
	i = i&~1;
    //buf[--i] = 'x';
    //buf[--i] = '0';
    return _puts(&buf[i]);	
}


int _atoi(const char* s) {
	int n = 0, sign = 1;
	while (*s == ' ' || *s =='\t' || *s == '+') s++;
	if (*s == '-') {
		sign = -1; s++; 
	}
	while (*s >= '0' && *s <= '9') {
		n = n*10 + (*s-'0');
		s++;
	}
	return sign*n;
}

char* _gets(char* s) {
	char in;
	int i = 0;
	in = _getchar();
	while (in != '\n') {
		if (in == '\b') {
			if (i > 0) {
				i--;
				_putchar('\b');
				_putchar(' ');
				_putchar('\b');
			}
		} else {
			_putchar(in);
			s[i++] = in;
		}
		in = _getchar();
	}
	s[i] = '\0';
	_putchar('\r');
	_putchar('\n');
	return s;
}

int _puts(const char* s) {
	int count = 0;
    while (*s) {
        _putchar(*s);
        s++; count++;
    }
	return count;
}

void _putchar(char c) { k_putchar(c); }
char _getchar() { return i_getchar(); }
void _clrscr(void) { k_clrscr(); }
