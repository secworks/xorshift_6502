//======================================================================
//
// mathlib.asm
// -----------
// Library providing 32-bit integer operations as needed by xorshift.
//
//
// Copyright (c) 2024, Joachim Strömbergson
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or
// without modification, are permitted provided that the following
// conditions are met:
//
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in
//    the documentation and/or other materials provided with the
//    distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
// COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//======================================================================

#importonce

//------------------------------------------------------------------
// rol64bits(addr, bits)
//
// Macro to rotate 32 bit word, bits number of steps.
//------------------------------------------------------------------
.macro rol32bits(addr, bits)
{
                        ldy #bits
rol32_1:                lda addr
                        rol
                        rol addr + 3
                        rol addr + 2
                        rol addr + 1
                        rol addr
                        dey
                        bne rol32_1
}


//------------------------------------------------------------------
// ror32bits(addr, bits)
//
// Macro to rotate a 32 bit word, bits number of steps right.
//------------------------------------------------------------------
.macro ror64bits(addr, bits)
{
                        ldy #bits
ror32_1:                lda addr + 3
                        ror
                        ror addr
                        ror addr + 1
                        ror addr + 2
                        ror addr + 3
                        dey
                        bne ror64_1
}

//------------------------------------------------------------------
// xor32(addr0, addr1)
//
// Macro to xor two words together. The result ends up in addr0
//------------------------------------------------------------------
.macro xor32(addr0, addr1)
{
                        ldx #$03
xor32_1:                lda addr0, x
                        eor addr1, x
                        sta addr0, x
                        dex
                        bpl xor32_1
}

//======================================================================
// EOF mathlib.asm
//======================================================================
