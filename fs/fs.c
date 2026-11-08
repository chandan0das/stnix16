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
/*                                  fs/fs.c                                  */
/*                                                                           */
/*****************************************************************************/

#include "kernel.h"
#include "block.h"
#include "fs.h"
#include "mm.h"


static inode  _inodes[MAX_INODES];
static int    _i_blks = 0;
static s_blk  _sb;
static int    _cwd = ROOT;

int fs_getcwd() { return _cwd; }
int fs_setcwd(int ino) { _cwd = ino; return 0; }

static FD     _fd_table[MAX_FD];

static void inodes_load() {
	for (int i = 0; i < _i_blks; i++ ) {
		disk_read (INODE_BLOCK+i, (unsigned char*)_inodes + i*BLOCK_SIZE);
	}
}

static void inodes_save() {
	for (int i = 0; i < _i_blks; i++ ) {
		disk_write(INODE_BLOCK+i, (unsigned char*)_inodes + i*BLOCK_SIZE);
	}
}	

static void sb_load() {
	unsigned char buf[BLOCK_SIZE];
	disk_read (INODE_BLOCK-1, buf);
	mm_cpy(&_sb, buf, sizeof(s_blk));
}

static void sb_save() {
	unsigned char buf[BLOCK_SIZE];
	mm_set(buf, 0, BLOCK_SIZE);
	mm_cpy(buf, &_sb, sizeof(s_blk));
	disk_write(INODE_BLOCK-1, buf);
}

static int alloc_block() {
	int i = INODE_BLOCK + _i_blks;
	for (; i < NUM_BLOCKS; i++) {
		if (_sb.bit_map[i] == 0) {
			_sb.bit_map[i] = 1;
			return i;
		}
	}
	return -1;
}

static int alloc_inode() {
	for (int i = 1; i < MAX_INODES; i++) { // skip for root = 0
		if (_inodes[i].type == F_FREE) {
			mm_set(&_inodes[i], 0, sizeof(inode));
			return i;
		}
	}
	return -1;
}

static int alloc_fd() {
	for (int i = 2; i < MAX_FD; i++) {	// 0, 1 reserved for stdin, stdout
		if (_fd_table[i].open == 0) return i;
	}
	return -1;
}


static int dir_find(int dino, const char* name) {
	if (!name || !name[0]) return -1;
	inode* dir = &_inodes[dino];
	unsigned char buf[BLOCK_SIZE];
	
	for (int i = 0; i < NDIR; i++) {
		if (dir->blocks[i] == 0) continue;
		disk_read(dir->blocks[i], buf);
		dirent* de = (dirent*)buf;
		for (int j = 0; j < (BLOCK_SIZE/sizeof(dirent)) ; j++) {
			if (de[j].name[0]) {
				if (mm_strcmp(de[j].name, name) == 0) return de[j].ino;
			}
		}
	}
	return -1;
}

static int dir_add(int dino, const char* name, int ino) {
	if (!name || !name[0]) return -1;
	inode* dir = &_inodes[dino];
	unsigned char buf[BLOCK_SIZE];
	
	for (int i = 0; i < NDIR; i++) {
		if (dir->blocks[i] == 0) { // previous block is not sufficient
			int nb = alloc_block();
			if (nb < 0) return -1;
			mm_set(buf, 0, BLOCK_SIZE);
			disk_write(nb, buf);
			dir->blocks[i] = (unsigned int)nb;
		}
		
		disk_read(dir->blocks[i], buf);
		dirent* de = (dirent*)buf;
		for (int j = 0; j < (BLOCK_SIZE/sizeof(dirent)) ; j++) {
			if (!de[j].name[0]) {
				mm_strncpy(de[j].name, name, MAX_NAME-1);
				de[j].ino = (unsigned int)ino;
				disk_write(dir->blocks[i], buf);
				
				int c_size = (i+1) * BLOCK_SIZE;
				if (c_size > dir->size) dir->size = c_size;
				return 0;
			}
		}
	}
	return -1;
}

static int dir_remove(int dino, const char* name) {
	if (!name || !name[0]) return -1;
	inode* dir = &_inodes[dino];
	unsigned char buf[BLOCK_SIZE];
	
	for (int i = 0; i < NDIR; i++) {
		if (dir->blocks[i] == 0) continue;
		disk_read(dir->blocks[i], buf);
		dirent* de = (dirent*)buf;
		for (int j = 0; j < (BLOCK_SIZE/sizeof(dirent)) ; j++) {
			if (de[j].name[0]) {
				if (mm_strcmp(de[j].name, name) == 0) {
					mm_set(&de[j], 0, sizeof(dirent));
					disk_write(dir->blocks[i], buf);
					return 0;
				}
			}
		}
	}
	return -1;	
}

int  fs_init() {
	_i_blks = (MAX_INODES * sizeof(inode) + BLOCK_SIZE-1) / BLOCK_SIZE;
	sb_load();
	
	if (_sb.magic != FMT_MAGIC) {
		
		mm_set(&_sb, 0, sizeof(_sb)); 
		_sb.magic = FMT_MAGIC;
		
		mm_set(_inodes, 0, sizeof(_inodes));
		
		int db = alloc_block();

		_inodes[ROOT].type	  = F_DIR;
		_inodes[ROOT].size	  = BLOCK_SIZE;
		_inodes[ROOT].nlink	 = 2; // both .  ..
		_inodes[ROOT].blocks[0] = (unsigned int)db;
		
		unsigned char buf[BLOCK_SIZE];
		mm_set(buf, 0, BLOCK_SIZE);
		dirent* de = (dirent*)buf;
		
		mm_strcpy(de[0].name, ".");  de[0].ino = ROOT;
		mm_strcpy(de[1].name, ".."); de[1].ino = ROOT;
		disk_write(db, buf);
		
		sb_save();
		inodes_save();
		return FS_FORMATTED;
	}
	else {
		inodes_load();
		return FS_MOUNTED;
	}
	return 0;
}

int  fs_sync() {
	inodes_save();
	sb_save();
	return 0;
}


int  fs_mkdir(const char* name) {
	if (!name || !name[0]) return DIR_INVAL;
	if (dir_find(_cwd, name) >= 0) return DIR_EXIST; 
	
	int ino = alloc_inode();
	if (ino < 0) return DIR_NALLOC;
	
	int db  = alloc_block();
	if (db < 0) {
		_inodes[ino].type = F_FREE;
		return DIR_NALLOC;
	}
	
	_inodes[ino].type	  = F_DIR;
	_inodes[ino].size	  = BLOCK_SIZE;
	_inodes[ino].nlink	 = 2;  // parent + . 
	_inodes[ino].blocks[0] = (unsigned int)db;
	
	unsigned char buf[BLOCK_SIZE];
	mm_set(buf, 0, BLOCK_SIZE);
	dirent* de = (dirent*)buf;
		
	mm_strcpy(de[0].name, ".");  de[0].ino = (unsigned int)ino;
	mm_strcpy(de[1].name, ".."); de[1].ino = (unsigned int)_cwd;
	disk_write(db, buf);
	
	if (dir_add(_cwd, name, ino) < 0) {
		_inodes[ino].type = F_FREE;
		_sb.bit_map[db] = 0;
		return DIR_NALLOC;
	}
	_inodes[_cwd].nlink++;
	inodes_save();
	sb_save();
	return DIR_ADDED;
}

int  fs_list(dirent_info* list, int max_ent) {
	int count = 0;
	
	inode* dir = &_inodes[_cwd];
	unsigned char buf[BLOCK_SIZE];
	
	for (int i = 0; i < NDIR; i++) {
		if (count >= max_ent) return count;
		if (dir->blocks[i] == 0) continue;
		
		disk_read(dir->blocks[i], buf);
		dirent* de = (dirent*)buf;
		for (int j = 0; j < (BLOCK_SIZE/sizeof(dirent)) ; j++) {
			if (de[j].name[0] == 0) continue;
			
			inode* entry = &_inodes[de[j].ino];
			
			mm_strncpy(list[count].name, de[j].name, MAX_NAME-1);
			list[count].ino	= de[j].ino;
			list[count].type   = entry->type;
			list[count].is_exe = entry->is_exe;
			list[count].size   = entry->size;
			list[count].nlink  = entry->nlink;
			
			count++;
		}
	}
	return count;
}

int  fs_cd(const char* name) {
	if (mm_strcmp(name, "/") == 0) { _cwd = ROOT; return 0; }
	int ino = dir_find(_cwd, name);
	if (ino >=0) {
		if (_inodes[ino].type == F_DIR) {
			_cwd = ino;
			return 0;
		}
	}
	return -1;
}

int is_dir_empty(inode* ip) {
	unsigned char buf[BLOCK_SIZE];
	for (int i = 0; i < NDIR; i++) {
		if (ip->blocks[i] == 0) continue;
		disk_read(ip->blocks[i], buf);
		dirent* de = (dirent*)buf;

		for (int j = 0; j < BLOCK_SIZE/sizeof(dirent); j++) {
			if (de[j].name[0] == 0) continue;
			if (mm_strcmp(de[j].name, ".") == 0) continue;
			if (mm_strcmp(de[j].name, "..") == 0) continue;
			return 0; // found something else
		}
	}
	return 1; // only . and .. remain
}


int  fs_delete(const char* name) {
	if (!name || !name[0]) return DEL_INVAL;
	if (mm_strcmp(name, ".") == 0 || mm_strcmp(name, "..") == 0) {
		return DEL_INVAL;
	}
	int ino = dir_find(_cwd, name);
	if (ino <= 0) return DEL_NFOUND;
	
	inode* ip = &_inodes[ino];
	if (ip->type == F_DIR) { // as only . and .. remain
		if (ip->nlink > 2) {
			return DEL_NEMPTY;
		}
	}
	if (ip->type == F_DIR) {
		if (!is_dir_empty(ip)) {
			return DEL_NEMPTY;
		}
	}
	
	for (int i = 0; i < NDIR; i++) {
		if (ip->blocks[i] != 0) {	
			_sb.bit_map[ip->blocks[i]] = 0;
			ip->blocks[i] = 0;
		}
	}

	if (ip->type == F_DIR) { // as .. point to parent
		_inodes[_cwd].nlink--;
	}
	
	ip->type = F_FREE;
	dir_remove(_cwd, name);
	inodes_save();
	sb_save();
	return DEL_DELETE;
}


static int  is_valid_fd(int fdes) {
	if (fdes < 0) return -1;
	if (fdes >= MAX_FD) return -1;
	if (_fd_table[fdes].open == 0) return -1;
	return 0;
}

int  fs_open (const char* name, unsigned char mode) {
	if (!name || !name[0]) return FILE_INVAL;
	
	int fdes = alloc_fd();
	if (fdes < 0) return  FILE_NO_FD;
	
	int ino = dir_find(_cwd, name);
	if (ino < 0) {
		if (mode & O_CREATE) {
			ino = alloc_inode();
			if (ino < 0) return FILE_NALLOC;
			_inodes[ino].type  = F_FILE;
			_inodes[ino].nlink = 1;
			if (dir_add(_cwd, name, ino) < 0) {
				_inodes[ino].type = F_FREE;
				return FILE_NALLOC;
			}
			inodes_save();
			sb_save();
		}
		else {
			return FILE_NFOUND;
		}
	}
	
	if (_inodes[ino].type == F_DIR) return FILE_INVAL;
	
	_fd_table[fdes].open = 1;
	_fd_table[fdes].mode = mode;
	_fd_table[fdes].ino  = (unsigned int)ino;
	_fd_table[fdes].pos  = 0;
	
	return fdes;
}

int  fs_close(int fdes) {
	if (is_valid_fd(fdes) < 0) return -1;
	_fd_table[fdes].open = 0;
	_fd_table[fdes].pos  = 0;
	return 0;
}

int  fs_write(int fdes, const void* buf, unsigned int len) {
	if (is_valid_fd(fdes) < 0) return -1;
	if (!(_fd_table[fdes].mode & O_WRITE)) return -1;
	
	FD*	f  = &_fd_table[fdes];
	inode* ip = &_inodes[f->ino];
	
	unsigned int  written = 0;
	unsigned char blk_buf[BLOCK_SIZE];
	
	while (written < len) {
		unsigned int blk_i = (f->pos + written) / BLOCK_SIZE;
		unsigned int blk_o = (f->pos + written) % BLOCK_SIZE;
		
		if (blk_i >= NDIR) break;
		
		if (ip->blocks[blk_i] == 0) { // previous block is not sufficient
			int nb = alloc_block();
			if (nb < 0) break;
			ip->blocks[blk_i] = (unsigned int)nb;
			mm_set(blk_buf, 0, BLOCK_SIZE);
		} else {
			disk_read(ip->blocks[blk_i], blk_buf);
		}
		
		unsigned int b_rem = BLOCK_SIZE - blk_o;
		unsigned int w_rem = len - written;
		unsigned int chunk = (b_rem > w_rem)?  w_rem : b_rem;
		
		mm_cpy(blk_buf + blk_o, (unsigned char*)buf + written, chunk);
		disk_write(ip->blocks[blk_i], blk_buf);
		written += chunk;
		
	}
	
	f->pos += written;
	if (f->pos > ip->size) ip->size = f->pos;
	
	inodes_save();
	sb_save();
	return 0;
}

int  fs_read (int fdes, void* buf, unsigned int len) {
	if (is_valid_fd(fdes) < 0) return -1;
	if (!(_fd_table[fdes].mode & O_READ)) return -1;
	
	FD*	f  = &_fd_table[fdes];
	inode* ip = &_inodes[f->ino];
	
	unsigned int  red = 0;
	unsigned char blk_buf[BLOCK_SIZE];
	
	while (red < len) {
		unsigned int blk_i = (f->pos + red) / BLOCK_SIZE;
		unsigned int blk_o = (f->pos + red) % BLOCK_SIZE;
		
		if (blk_i >= NDIR) break;
		if (ip->blocks[blk_i] == 0) break;
		
		disk_read(ip->blocks[blk_i], blk_buf);
		
		unsigned int b_rem = BLOCK_SIZE - blk_o;
		unsigned int r_rem = len - red;
		unsigned int chunk = (b_rem > r_rem)?  r_rem : b_rem;
		
		mm_cpy((unsigned char*)buf + red, blk_buf + blk_o, chunk);
		red += chunk;
	}
	
	f->pos += red;
	return (int)red;
}

int  fs_seek (int fdes, unsigned int pos) {
	if (is_valid_fd(fdes) < 0) return -1;
	_fd_table[fdes].pos = pos;
	return 0;
}

int  fs_tell (int fdes) {
	if (is_valid_fd(fdes) < 0) return -1;
	return (int)_fd_table[fdes].pos;
}

int  fs_size (int fdes) {
	if (is_valid_fd(fdes) < 0) return -1;
	return (int)_inodes[_fd_table[fdes].ino].size;
}