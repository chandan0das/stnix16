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
# *                               user/Makefile                               *
# *                                                                           *
# ***************************************************************************

MAKEFLAGS += -r

# Makefile for my 16-bit programs
# Written by Chandan

ASM    = nasm
CC16   = smlrc -seg16 -I include/
LD     = ld
LDFLAGS = -m elf_i386 -nostdlib --nmagic --oformat binary \
			-T lib/linker.ld 

TARGET  = prog.hdd
BINARY  = prog.bin


# Source files
ASM_SRC = lib/start.asm
LIBAPIO = lib/apio.c
C_SRC   = $(LIBAPIO) lib/prog_start.c \
			\
			progs/face/main.c
			     # ^ this is the program directory name that is going to be install
APIO ?= 0
ifeq ($(APIO),1)
C_SRC +=lib/apio.c
endif


CASM    = $(C_SRC:.c=.asm)
COBJ    = $(C_SRC:.c=.o)
OBJS    = $(ASM_SRC:.asm=.o) $(COBJ)

all: $(TARGET)

$(TARGET): $(BINARY)
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=$< of=$@ conv=notrunc

$(BINARY): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

%.asm: %.c
	#gcc -Wall -Wextra -pedantic -fsyntax-only -I ./include/ $<
	$(CC16) $< $@

%.o: %.asm
	$(ASM) -f elf32 $< -o $@

.PRECIOUS: %.asm

clean:
	rm -f $(OBJS)

.PHONY: all clean