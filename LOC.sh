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
# *                                   LOC.sh                                  *
# *                                                                           *
# ***************************************************************************

find . -type f \( -name "*.c" -o -name "*.h" -o -name "*.asm" -o -name "*.sh" -o -name "Makefile" \) \
-not -name "LOC.sh" -not -path "./user/*" -exec awk '
NF > 0 {
    ext = (FILENAME ~ /\.c$/) ? "C" : (FILENAME ~ /\.h$/) ? "Header" : (FILENAME ~ /\.asm$/) ? "ASM" : (FILENAME ~ /\.sh$/) ? "Shell" : "Makefile";
    file_counts[FILENAME]++; type_totals[ext]++; grand_total++; f_type[FILENAME] = ext;
}
END {
    n = split("C Header ASM Shell Makefile", cats, " ");
    for (i = 1; i <= n; i++) {
        c = cats[i]; if (type_totals[c] > 0) {
            printf "--- %s Files ---\n", c;
            for (f in file_counts) if (f_type[f] == c) printf "%-40s %6d\n", f, file_counts[f];
            printf "\n";
        }
    }
    print "=================================\nSUMMARY (Non-Empty Lines)\n=================================";
    for (i = 1; i <= n; i++) {
        c = cats[i]; if (type_totals[c] > 0) printf "%-10s %6d\n", c, type_totals[c];
    }
    printf "---------------------------------\n%-10s %6d\n", "TOTAL", grand_total;
}' {} +