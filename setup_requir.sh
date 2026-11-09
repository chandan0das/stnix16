#!/usr/bin/env bash
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
# *                              setup_requir.sh                              *
# *                                                                           *
# ***************************************************************************

set -e

# 1. packages
if   command -v apt-get >/dev/null; then sudo apt-get update && sudo apt-get install -y build-essential git nasm binutils qemu-system-x86
elif command -v dnf     >/dev/null; then sudo dnf install -y make gcc git nasm binutils qemu-system-x86
elif command -v pacman  >/dev/null; then sudo pacman -S --needed --noconfirm base-devel git nasm binutils qemu-system-x86
else echo "Unsupported package manager, install make gcc git nasm binutils qemu manually"; exit 1
fi

# 2. clone and build smlrc (version from before 2026)
TMP=$(mktemp -d)
git clone https://github.com/alexfru/SmallerC.git "$TMP/SmallerC"
# use the last commit made before 2026
git -C "$TMP/SmallerC" checkout -q "$(git -C "$TMP/SmallerC" rev-list -1 --before=2026-01-01 HEAD)"
gcc -O2 -o "$TMP/SmallerC/v0100/smlrc" "$TMP/SmallerC/v0100/smlrc.c"
sudo install -m 755 "$TMP/SmallerC/v0100/smlrc" /usr/local/bin/smlrc
rm -rf "$TMP"

# 3. blank disk images used by 'make run'
mkdir -p user
[ -f disk.hdd ]      || dd if=/dev/zero of=disk.hdd      bs=512 count=2880 status=none
[ -f user/prog.hdd ] || dd if=/dev/zero of=user/prog.hdd bs=512 count=2880 status=none

echo "Done. Run: make && make run"