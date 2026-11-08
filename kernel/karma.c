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
/*                               kernel/karma.c                              */
/*                                                                           */
/*****************************************************************************/

// karma.c
// the name might be misleading
#include "fs.h"
// just loader & executer 
int karma(const char* name, const char* cmd_line) {
	unsigned char* load_addr = (unsigned char*)0xC000;
	
	int fd = fs_open(name, O_READ);
	
	if (fd < 0) {
		int saved_cwd = fs_getcwd();
		if (fs_cd("/") < 0) return -1;
		if (fs_cd("bin") < 0) { fs_setcwd(saved_cwd); return -1; }
		fd = fs_open(name, O_READ);
		fs_setcwd(saved_cwd);		  // restore cwd regardless
		if (fd < 0) return -1;
	}
	
	int i, read = 0, total = 0;
	for (i = 0; i < NDIR; i++) {
		read = fs_read(fd, load_addr + total, BLOCK_SIZE);
		total += read;
		if (read < BLOCK_SIZE) break;
	}

	fs_close(fd);

	load_addr[total] = 0xC3;

	void (*entry)(const char*) = (void(*)(const char*))0xC000;
	entry(cmd_line);
	return 0;
}
