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
/*                               kernel/main.c                               */
/*                                                                           */
/*****************************************************************************/

#include "kernel.h"

#include "mm.h"
#include "fs.h"

#include "drivers.h"
#include "char.h"
#include "block.h"

/*
static unsigned int seed = 314;

unsigned int rand_16() {
	seed = (unsigned int)(seed * 25173 + 13849);
	return seed;
}
*/

void print_result(const char* name, int pass) {
	_puts("[      ] ");
	_puts(name); k_set_x(1);

	sleep_n(40);
	if (pass) { k_char_style(GREEN, BLACK, 0); _puts(" PASS \n"); }
	else      { k_char_style(RED,   BLACK, 0); _puts(" FAIL \n"); }
	k_char_style(WHITE, BLACK, 0);
}

void main(void) { 
	pic_remap(0x20, 0x28);
	time_init(11932);
	
	int err = 0;

	char_init();
	_clrscr();
	
	_puts("Drives ->\n"); k_char_style(BROWN, BLACK, 0);
	int d_no = get_boot_drive();
	for (int i = 0; i < 0x84; ++i) {
		if (drive_exists(i)) { _pformat(" drive 0x~x ~i exists\n", i, i); 
			if (d_no == i) _pformat("\t ^- Boot Drive ~s\n", 
				(d_no < 0x80)? "Floppy": "HDD");
		}
	} k_char_style(WHITE, BLACK, 0);
	
	print_result("Characters Initialized ... ", _puts("\b") == 1);
	print_result("Keyboard Initialized ... ", 1);
	
	
	err = mm_init();
	print_result("Memory Initialized ... ", err == 0);
	
	
	err = block_init(RAM_DISK);
	print_result("Block Initialized ... ", err == 0);
	print_result("block: RAM Disk Ready ... ", type_disk() == RAM_DISK);
	//print_result("block: Physical Disk Ready ... ", type_disk() == PHY_DISK);
	
	
	err = fs_init();
	switch (err) {
		case FS_FORMATTED: _puts(" New File System Formatted\n"); break;
		case FS_MOUNTED  : _puts(" File System Mounted\n"); break;
	}
	print_result("File System Initialized ... ", err != 0);
	
	_puts("Enter to goto shell");
	_getchar();
	
	mini_shell();
	
	print_result("File Synced ...", fs_sync() == 0);
	print_result("Commit_to_HDD_0",	commit_to_disk() == 0);
	
	
	_puts("Enter to Shut Down");
	_getchar();
	_poweroff();
}