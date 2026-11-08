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
/*                                include/fs.h                               */
/*                                                                           */
/*****************************************************************************/

#ifndef FS_H
#define FS_H

#include "errors.h"

#define BLOCK_SIZE  512
#define NUM_BLOCKS  128   // change of this depends of ram_disk module
#define FMT_MAGIC   0xCAFE

#define MAX_INODES  64    // note: make it multiple of 32 
#define NDIR        16
#define MAX_NAME    30

#define ROOT        0

#define F_FREE      0
#define F_FILE      1
#define F_DIR       2

#define INODE_BLOCK 32


typedef struct _i_nd {
	unsigned char  type;
	unsigned char  is_exe;
	unsigned int   size;
	unsigned int   nlink;
	unsigned int   blocks[NDIR];
} inode;

typedef struct _dir_ent {
	char name[MAX_NAME];
	unsigned int ino;
} dirent;

typedef struct _s_blk{
    unsigned short magic;
    unsigned char  bit_map[NUM_BLOCKS];
} s_blk;

#define FS_MOUNTED   1
#define FS_FORMATTED 2
int  fs_init();
int  fs_sync();

int fs_getcwd();
int fs_setcwd(int ino);


typedef struct _dir_info {
	char name[MAX_NAME];
	unsigned int ino;
	unsigned char  type;
	unsigned char  is_exe;
	unsigned int   size;
	unsigned int   nlink;	
} dirent_info;

#define  DIR_NALLOC    FS_N_ALLOC
#define  DIR_EXIST     FS__EXISTS
#define  DIR_INVAL     FS_INVALID
#define  DIR_ADDED     FS_SUCCESS
int     fs_mkdir(const char* name);
int     fs_list(dirent_info* buf, int max_ent);
int     fs_cd(const char* name);

#define  DEL_NEMPTY    FS_N_EMPTY
#define  DEL_NFOUND    FS_N_FOUND
#define  DEL_INVAL     FS_INVALID
#define  DEL_DELETE    FS_SUCCESS
int     fs_delete(const char* name);



typedef struct _f_des {
	unsigned char open;
	unsigned char mode;
	unsigned int  ino;
	unsigned int  pos;
} FD;

#define  MAX_FD  8

#define  O_CREATE    1
#define  O_READ      2
#define  O_WRITE     4


#define  FILE_NO_FD    FS_NO_FDES
#define  FILE_NALLOC   FS_N_ALLOC
#define  FILE_NFOUND   FS_N_FOUND
#define  FILE_INVAL    FS_INVALID
int  fs_open (const char* name, unsigned char mode);
int  fs_close(int fdes);

int  fs_write(int fdes, const void* buf, unsigned int len);
int  fs_read (int fdes, void* buf, unsigned int len);

int  fs_seek (int fdes, unsigned int pos);
int  fs_tell (int fdes);
int  fs_size (int fdes);


			 
#endif