# Copyright (c) 2026, Chandan Das
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ***************************************************************************
# *                                                                           *
# *                                  STNIX 16                                 *
# *                                                                           *
# *                A 16-bit monolithic operating system for x86               *
# *                                                                           *
# *                                  Makefile                                 *
# *                                                                           *
# ***************************************************************************

MAKEFLAGS += -r
# Makefile for my 16-bit real-mode OS
# Written by Chandan

ASM 	= nasm
CC16	= smlrc -seg16 -I include/
LD  	= ld
LDFLAGS	= -m elf_i386 -T kernel/linker.ld -nostdlib --nmagic --oformat binary

TARGET	= os.img
BINARY	= os.bin


KERNEL	=	kernel/kernel.asm
CPROGS  =	kernel/main.c\
			kernel/syscall.c\
			kernel/karma.c\
			kernel/mini_shell.c\
			drivers/char.c\
			drivers/keyboard.c\
			drivers/time.c\
			drivers/block.c\
			mm/mm.c\
			fs/fs.c

# for me to understand how assembly works
CASM	= $(CPROGS:.c=.asm)	
COBJ	= $(CPROGS:.c=.o)
OBJS	= $(KERNEL:.asm=.o) $(COBJ)

all: $(TARGET)
$(TARGET): $(BINARY)
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=$< of=$@ conv=notrunc

$(BINARY): boot.bin kernel.bin
	cat $^ > $@

boot.bin: boot.asm
	$(ASM) -f bin $< -o $@
kernel.bin: $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

compile: $(CASM)
%.asm: %.c
	$(CC16) $< $@
%.o: %.asm
	$(ASM) -f elf32 $< -o $@	
	

run: $(TARGET)
	qemu-system-i386 -fda $(TARGET) -boot a\
    -drive file=disk.hdd,format=raw,index=0,if=ide \
	-drive file=./user/prog.hdd,format=raw,index=1,if=ide
	# -display sdl -full-screen
run_hdd:
	qemu-system-i386 \
    -drive file=disk.hdd,format=raw,index=0,if=ide \
	-drive file=./user/prog.hdd,format=raw,index=1,if=ide \
	#-display sdl -full-screen

run_term: $(TARGET)
	qemu-system-i386 -fda $(TARGET) -boot a\
    -drive file=disk.hdd,format=raw,index=0,if=ide \
	-drive file=./user/prog.hdd,format=raw,index=1,if=ide \
	-display curses

run_hdd_term:
	qemu-system-i386 \
    -drive file=disk.hdd,format=raw,index=0,if=ide \
	-drive file=./user/prog.hdd,format=raw,index=1,if=ide \
	-display curses
	
clean:
	rm -f *.bin *.o $(OBJS) $(CASM) $(BINARY)

.PHONY: all clean run