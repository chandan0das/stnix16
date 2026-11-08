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
/*                             drivers/keyboard.c                            */
/*                                                                           */
/*****************************************************************************/

#include "keyboard.h"
#include "time.h"

static char map_normal[] = {
	0, 27, '1','2','3','4','5','6','7','8','9','0','-','=','\b',
	'\t','q','w','e','r','t','y','u','i','o','p','[',']','\n',
	0, 'a','s','d','f','g','h','j','k','l',';','\'','`',0,'\\',
	'z','x','c','v','b','n','m',',','.','/',0,'*',0,' '
};

static char map_shift[] = {
	0, 27, '!','@','#','$','%','^','&','*','(',')','_','+','\b',
	'\t','Q','W','E','R','T','Y','U','I','O','P','{','}','\n',
	0, 'A','S','D','F','G','H','J','K','L',':','"','~',0,'|',
	'Z','X','C','V','B','N','M','<','>','?',0,'*',0,' '
};
static int shift_held = 0;
static char last_char = 0;

/*
this function uses pulling for getchar
int p_getchar() {
	unsigned char s_code;
	while (1) {
		while ((inb(0x64) & 1)== 0);
		s_code = inb(0x60);
		
		if (s_code == 0x2A || s_code == 0x36) {
			shift_held = 1;
		continue; }
		if (s_code ==	 0xAA || s_code == 0xB6) {
			shift_held = 0;
		continue; }
		if (s_code & 0x80) continue;
		
		if (s_code < 58) {
			char c = shift_held ?
			map_shift[s_code]: map_normal[s_code];
			if (c != 0) {
				return c;
			}
		}
	}
}
*/

void keyboard_handler() {
	unsigned char s_code = inb(0x60);
	if (s_code == 0xAA || s_code == 0xB6) { shift_held = 0; return; }
	if (s_code == 0x2A || s_code == 0x36) { shift_held = 1; return; }
	if (s_code & 0x80) return;
	last_char = shift_held ?
		map_shift[s_code]: map_normal[s_code];
}

int key_hit() {
	return last_char;
}

int i_getchar() {
	while (!key_hit()) _hlt();
	char c = last_char;
	last_char = 0;
	return c;
}