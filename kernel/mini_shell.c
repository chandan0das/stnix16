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
/*                            kernel/mini_shell.c                            */
/*                                                                           */
/*****************************************************************************/

#include "char.h"
#include "block.h"
#include "time.h"

#include "fs.h"
#include "mm.h"

#include "syscall.h"

#ifndef NULL
 #define NULL (void*)0
#endif

int color_tx = LIGHT_GREEN, color_bg = BLACK, color_bl = 0;

int karma(const char* name, const char* cmd_line);
void _show_banner(void)
{
	if (karma("face", NULL) == -1) print_commands();
}

void _perrors(int num) {
	switch(num) {
		case  FS_SUCCESS  : _puts(" success\n"); break;
		case  FS_INVALID  : _puts(" invalid\n"); break;
		case  FS_N_FOUND  : _puts(" not exists\n"); break;
		case  FS__EXISTS  : _puts(" already exists\n"); break;
		case  FS_N_ALLOC  : _puts(" not sufficient storage\n"); break;
		case  FS_NO_FDES  : _puts(" too many open files\n"); break;
		case  FS_N_EMPTY  : _puts(" non-empty directory\n"); break;
	}
}

void print_commands(void);

int mini_shell(char* name) {
	char buffer[128];
	char args[4][32];
	_clrscr();
	_show_banner();
	
	fs_mkdir("bin"); fs_mkdir("home"); fs_mkdir("games");

	while (1) {
		k_char_style(color_tx, color_bg, color_bl);
		_pformat("[]> ",name);
		
		if (_gets(buffer) == NULL) break;
		
		int k = 0;
		for (int i = 0; i < 4; i++) {
			while (buffer[k] == ' ') k++;
			int j = 0;
			while (j < 31 && buffer[k] != '\0' && buffer[k] != ' ') {
				args[i][j++] = buffer[k++];
			}
			args[i][j] = '\0'; 
		}
		
		
			 if (mm_strcmp(args[0], "exit") == 0) { _puts("Goodbye!\n"); break;
		}
		else if (mm_strcmp(args[0], "sleep") == 0) { 
			int sec = _atoi(args[1]);
			while (sec-- > 0) sleep_n(100);
		}
		else if (mm_strcmp(args[0], "help") == 0) { print_commands();
		}
		else if (mm_strcmp(args[0], "clear") == 0) { _clrscr();
		}
		else if (mm_strcmp(args[0], "color") == 0) {
			color_tx = _atoi(args[1]);
			color_bg = _atoi(args[2]);
			color_bl = _atoi(args[3]);
		}
		else if (mm_strcmp(args[0], "ls") == 0) {
			dirent_info list[16];
			int count = fs_list(list, 16);
			int l = mm_strchr(args[1],'l'), s = mm_strchr(args[1],'s'),
				a = mm_strchr(args[1],'a'), in = mm_strchr(args[1],'i');
			for (int i = (!a ? 2 : 0); i < count; i++) {
				if (in) _pformat(" ~i\t", list[i].ino);
				if (s && !l) _pformat(" ~i\t", list[i].size);
				if (l) {
					_pformat(" ~crw~c\t ~i\t ~i\t",
						list[i].type == F_DIR ? 'd' : '-',
						list[i].is_exe ? 'x' : '-',
						list[i].nlink, list[i].size);
				}
				_pformat(" ~s\t", list[i].name);
				if (args[1][0]) _putchar('\n');
			}
			if (!args[1][0]) _putchar('\n');
		}
		else if (mm_strcmp(args[0], "mkdir") == 0) {
			int no = fs_mkdir(args[1]);
			_pformat("mkdir : '~s'", args[1]);
			_perrors(no);
		}
		else if (mm_strcmp(args[0], "cd") == 0) {
			if (fs_cd(args[1]) == -1) {
				_pformat("cd : '~s' not exists\n", args[1]);
			}
		}
		else if (mm_strcmp(args[0], "del") == 0) {
			int no = fs_delete(args[1]);
			_pformat("del : '~s'", args[1]);
			_perrors(no);
		}
		else if (mm_strcmp(args[0], "emit") == 0) {
			int fd = fs_open(args[1], O_CREATE | O_WRITE);
			_pformat("emit : '~s'", args[1]);
			if (fd > 0) {
				_puts(" success\n");
				fs_write(fd, 0xE000, _atoi(args[2]));
			}
			else _perrors(fd);
			fs_close(fd);
		}
		else if (mm_strcmp(args[0], "append") == 0) {
			int fd = fs_open(args[1], O_WRITE);
			char *_buf = buffer;
			if (fd > 0) {
				fs_seek(fd, _atoi(args[2]));
				while (1) {
					_puts("> ");
					mm_set(_buf, 0, sizeof(buffer));
					_gets(_buf);
					if (mm_strcmp(_buf, "+++") == 0) break;
					fs_write(fd, _buf, mm_strlen(_buf));
					fs_write(fd, "\n", 1);
				}
			}
			_pformat("append : '~s'", args[1]);
			if (fd > 0) _puts(" success\n");
			else _perrors(fd);
			fs_close(fd);
		}
		else if (mm_strcmp(args[0], "read") == 0) {
			char *dump_loc = 0xE000;
			int fd = fs_open(args[1], O_READ);
			char *_buf = buffer;
			int count;
			if (fd > 0) {
				fs_seek(fd, _atoi(args[2]));
				while (fs_read(fd, _buf, 32) == 32) {
					mm_strncpy(dump_loc, _buf, 32);
					_puts(_buf);
					if (k_get_y() == VGA_HEIGHT-1)
						if (_getchar() == 'q') break;
					dump_loc += 32;
				}
			}
			else {
				_pformat("read : '~s'", args[1]);
				_perrors(fd);
			}
			fs_close(fd);
		}
		else if (mm_strcmp(args[0], "dump") == 0) {
			if (dump_disk(_atoi(args[1])) != 0) _puts("Dump Failed!\n");
		}
		else if (buffer[0] != '\0' && buffer[0] != '\n') {
			if (karma(args[0], buffer) == -1) {			
				_pformat("Unknown command: '~s'", args[0]);
				_puts("\nType 'help'\n");
			}
		}
	}

	return 0;
}

#define NUM_COMMAND 14
void print_commands(void)
{
	int pos_y = k_get_y();
	
	if (pos_y >= VGA_HEIGHT-NUM_COMMAND ) pos_y = VGA_HEIGHT-NUM_COMMAND;
	//k_set_y(pos_y);
	k_char_style(LIGHT_CYAN, BLACK, 0);
	_puts(  "\t\t\t\t Write to file \n"
			"\t\t\t\t Change Directory \n"
			"\t\t\t\t Clear Screen \n"
			"\t\t\t\t Change text, background color \n"
			"\t\t\t\t Delete Directory/File \n"
			"\t\t\t\t Dump <disk> to 0xE000 \n"
			"\t\t\t\t Copy 0xE000 to file \n"
			"\t\t\t\t Exit OS \n"
			"\t\t\t\t Show This Help \n"
			"\t\t\t\t List Directory \n"
			"\t\t\t\t Make Directory \n"
			"\t\t\t\t Read/Dump file\n"
			"\t\t\t\t Sleep for <num> seconds \n"
			"\t\t\t\t Run the Program \n"
	);
	
	k_set_y(pos_y);
	k_char_style(BROWN, BLACK, 0);
	_puts(	"\t <name> <offset>\n"
			"\t <name> \n"
			"\n"
			"\t <txt> <bg> <blink> \n"
			"\t <name> \n"
			"\t <disk> \n"
			"\t <name> <byte> \n"
			"\n"
			"\n"
			"\t [lsai] \n"
			"\t <name> \n"
			"\t <name> <offset>\n"
			"\t <num> \n"
			" <name> \n"
	);
	
	k_set_y(pos_y);
	k_char_style(RED, BLACK, 0);
	_puts(	" append \n"
			" cd \n"
			" clear \n"
			" color \n"
			" del \n"
			" dump \n"
			" emit \n"
			" exit \n"
			" help \n"
			" ls \n"
			" mkdir \n"
			" read \n"
			" sleep \n\n"
	);
}
