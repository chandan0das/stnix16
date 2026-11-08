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
/*                              kernel/syscall.c                             */
/*                                                                           */
/*****************************************************************************/

#include "syscall.h"

#include "char.h"
#include "keyboard.h"
#include "time.h"
#include "mm.h"
#include "fs.h"

// syscall dispatcher
int syscal_d(int num, ...) {
	int *args = &num;
	switch(num)
	{
		case STYL:        k_char_style(args[1], args[2], args[3]); break;
		case CLRS:        _clrscr(); break;
		case GETX: return (int)k_get_x();
		case GETY: return (int)k_get_y();
		case SETX:        k_set_x(args[1]); break;
		case SETY:        k_set_y(args[1]); break;
		
		case PUTC:        _putchar(args[1]); break;
		case GETC: return (int)_getchar();
		case PUTS: return (int)_puts(args[1]);
		case GETS: return (int)_gets(args[1]);
		case ATOI: return (int)_atoi(args[1]);
		case PUTI: return (int)_puti(args[1]);
		case PUTH: return (int)_putx(args[1]);
		case KHIT: return (int)key_hit();
		
		case SLEEP:        sleep_n(args[1]); break;
	
		case ALOC: return (int)mm_alloc(args[1]);
		case RLOC: return (int)mm_ralloc(args[1], args[2]);
		case FREE:         mm_free(args[1]); break;
		
		case  MKDIR: return (int)fs_mkdir(args[1]);
		case     LS: return (int)fs_list(args[1], args[2]);
		case     CD: return (int)fs_cd(args[1]);
		case DELETE: return (int)fs_delete(args[1]);
		
		case F_OPEN :  return (int)fs_open(args[1], args[2]);
		case F_CLOSE:  return (int)fs_close(args[1]);
		case F_READ :  return (int)fs_read(args[1], args[2], args[3]);
		case F_WRITE:  return (int)fs_write(args[1], args[2], args[3]);
		case F_SEEK :  return (int)fs_seek(args[1], args[2]);
		case F_TELL :  return (int)fs_tell(args[1]);
		case F_SIZE :  return (int)fs_size(args[1]);
	}
	return 0;
}