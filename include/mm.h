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
/*                                include/mm.h                               */
/*                                                                           */
/*****************************************************************************/

#ifndef MM_H
#define MM_H


#ifndef NULL
 #define NULL (void*)0
#endif

#define STACK_START 0x8000
#define STACK_END   0x5000 // change to 0x4000



int check_stack();


void* mm_cpy(void* s1, const void* s2, int n);
void  mm_set(void *s, int c, unsigned int n);

int   mm_strcmp(const char* s1, const char* s2);
void  mm_strcpy(char* s1, const char* s2);
void  mm_strncpy(char* s1, const char* s2, int n);
unsigned int mm_strlen(const char *s);

char* mm_strchr(const char* s, int c);

#define HEAP_START  0x0800
#define HEAP_END    STACK_END
#define HEAP_SIZE   (HEAP_END - HEAP_START)

typedef struct mm_blk {
	int free;
	int size;
	struct mm_blk* next;
} mm_block;

int   mm_init();
void* mm_alloc(int size);
void* mm_ralloc(void* ptr, int size); 
void  mm_free(void* ptr);

#endif