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
/*                                  mm/mm.c                                  */
/*                                                                           */
/*****************************************************************************/

#include "mm.h"
#include "kernel.h"

int check_stack() {
	if (_sp() < STACK_END) {
		return 1;
	}
	return 0;
}

void* mm_cpy(void* s1, const void* s2, int n) {
	unsigned char* t = (unsigned char*)s1;
	unsigned char* s = (unsigned char*)s2;
	for (int i = 0; i < n; i++) {
		t[i] = s[i];
	}
	return (void*)s1;
}
void mm_set(void* s, int c, unsigned int n) {
    unsigned char* p = (unsigned char*)s;
    while (n--) *p++ = (unsigned char)c;
}

int mm_strcmp(const char* s1, const char* s2) {
    while (*s1 && *s2 && *s1 == *s2) { s1++; s2++; }
    return (unsigned char)*s1 - (unsigned char)*s2;
}

void mm_strcpy(char* s1, const char* s2) {
    while (*s2) *s1++ = *s2++;
    *s1 = '\0';
}

void mm_strncpy(char* s1, const char* s2, int n) {
    while (n--) {
		if (*s2 == '\0') break;
		*s1++ = *s2++;
	}
    *s1 = '\0';
}

unsigned int mm_strlen(const char* s) {
    unsigned int n = 0;
    while (*s++) n++;
    return n;
}

char* mm_strchr(const char* s, int c) {
	while (*s) {
		if (*s == (char)c) {
			return (char*)s;
		}
		s++;
	}
	if (c == '\0') {
		return (char*)s;
	}
	return NULL;
}





static mm_block* mm_head = NULL;

int   mm_init() {
	mm_head = (mm_block*)HEAP_START;
	mm_head->free = 1;
	mm_head->size = HEAP_SIZE - sizeof(mm_block);
	mm_head->next = NULL;
	return 0;
}
	
void* mm_alloc(int size) {
	mm_block* tmp = mm_head;
	if (size <=0) return NULL;
	if (!mm_head) return NULL;
	while(tmp) {
		if (tmp->free && tmp->size >= size) {
			
			if (tmp->size >= size + sizeof(mm_block) + 2) {
				mm_block* nnode =
				(mm_block*)((unsigned char*)(tmp + 1) + size);
				
				nnode->free = 1;
				nnode->size = tmp->size - size - sizeof(mm_block);
				
				nnode->next = tmp->next;
				tmp->next   = nnode;
				tmp->size   = size;
			}
			tmp->free = 0;
			return (void*)(tmp + 1);
		}
		tmp = tmp->next;
	}
	return NULL;
}
void* mm_ralloc(void* ptr, int size) {
	if (!ptr) return mm_alloc(size);
	if (size <= 0) { mm_free(ptr); return NULL;}
	
	mm_block* tmp = (mm_block*)ptr - 1;
	
	if (tmp->size >= size) return ptr;
	
	void* nptr = mm_alloc(size);
	if (!nptr) return NULL;
	mm_cpy(nptr, ptr, tmp->size);
	mm_free(ptr);
	return nptr;
}
void  mm_free(void* ptr) {
	if (!ptr) return;
	mm_block* tmp = (mm_block*)ptr - 1;
	tmp->free = 1;
	while (tmp->next && tmp->next->free) {
		tmp->size += sizeof(mm_block) + tmp->next->size;
		tmp->next = tmp->next->next;
	}
}