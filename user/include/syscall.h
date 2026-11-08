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
/*                           user/include/syscall.h                          */
/*                                                                           */
/*****************************************************************************/

#ifndef SYSCALL_H
#define SYSCALL_H


#define  STYL   1         // void k_char_style(unsigned char fg, unsigned char bg, unsigned char blink);
#define  CLRS   2         // void _clrscr(void);
#define  GETX   3         // int  k_get_x(void); 
#define  GETY   4         // int  k_get_y(void); 
#define  SETX   5         // void k_set_x(int x);
#define  SETY   6         // void k_set_y(int y);
#define  PUTC   7         // void _putchar(char c);
#define  GETC   8         // char _getchar();
#define  PUTS   9         // int   _puts(const char* s);
#define  GETS   10        // char* _gets(char* s);
#define  ATOI   11        // int _atoi(const char* s);
#define  PUTI   12        // int  int _puti(int n);
#define  PUTH   13        // int _putx(unsigned int n);
#define  KHIT   14        // int key_hit();

#define  SLEEP  20

#define  ALOC   30        // void* mm_alloc(int size);
#define  RLOC   31        // void* mm_ralloc(void* ptr, int size);  
#define  FREE   32        // void  mm_free(void* ptr);

#define    MKDIR   40     // int  _mkdir(const char* name);
#define       LS   41     // int  _list(dirent_info* buf, int max_ent);
#define       CD   42     // int  _cd(const char* name); * not path, . .. / <dir_name> can be used *
#define   DELETE   43     // int  _delete(const char* name);

/* 
#define  O_CREATE    1
#define  O_READ      2
#define  O_WRITE     4
*/

#define   F_OPEN   45     // int  fs_open (const char* name, unsigned char mode);
#define  F_CLOSE   46     // int  fs_close(int fdes);
#define   F_READ   47     // int  fs_read (int fdes, void* buf, unsigned int len);
#define  F_WRITE   48     // int  fs_write(int fdes, const void* buf, unsigned int len);
#define   F_SEEK   49     // int  fs_seek (int fdes, unsigned int pos);
#define   F_TELL   50     // int  fs_tell (int fdes);
#define   F_SIZE   51     // int  fs_size (int fdes);


int  syscal(int num, ...);


#endif