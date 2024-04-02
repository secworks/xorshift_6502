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
// Macro to rotate 64 bit word, bits number of steps.
//
//------------------------------------------------------------------
.macro rol64bits(addr, bits)
{
                        ldy #bits
rol64_1:                lda addr
                        rol
                        rol addr + 7
                        rol addr + 6
                        rol addr + 5
                        rol addr + 4
                        rol addr + 3
                        rol addr + 2
                        rol addr + 1
                        rol addr
                        dey
                        bne rol64_1
}

//------------------------------------------------------------------
// ror64bits(addr, bits)
//
// Macro to rotate a 64 bit word, bits number of steps right.
//------------------------------------------------------------------
.macro ror64bits(addr, bits)
{
                        ldy #bits
ror64_1:                lda addr + 7
                        ror
                        ror addr
                        ror addr + 1
                        ror addr + 2
                        ror addr + 3
                        ror addr + 4
                        ror addr + 5
                        ror addr + 6
                        ror addr + 7
                        dey
                        bne ror64_1
}

//------------------------------------------------------------------
// rol13(addr)
//
// Macro to rotate a 64 bit word, 13 bits left.
// We do this by moving 16 bits left and then 3 bits right.
// TODO: Implement.
//------------------------------------------------------------------
.macro rol13(addr)
{
                        :rol16(addr)
                        :ror64bits(addr, 3)
}

//------------------------------------------------------------------
// rol16(addr)
//
// Macro to rotate a 64 bit word, 16 bits left.
// We do this by moving the bytes two steps.
//------------------------------------------------------------------
.macro rol16(addr)
{
                        lda addr
                        sta tmp
                        lda addr + 1
                        sta tmp + 1

                        ldx #$00
rol16_1:                lda addr + 2, x
                        sta addr, x
                        inx
                        cpx #$07
                        bne rol16_1

                        lda tmp
                        sta addr + 6
                        lda tmp + 1
                        sta addr + 7
}

//------------------------------------------------------------------
// rol17(addr)
//
// Macro to rotate a 64 bit word, 17 bits left.
// We do this by moving 2 bytes left and then rotating 1 bit left.
//------------------------------------------------------------------
.macro rol17(addr)
{
                        :rol16(addr)
                        :rol64bits(addr, 1)
}

//------------------------------------------------------------------
// rol21(addr)
//
// Macro to rotate a 64 bit word, 21 bits left.
// We do this by moving 3 bytes left and rotating 3 bits right.
//------------------------------------------------------------------
.macro rol21(addr)
{
                        // Move three bytes left.
                        // Using tmp
                        ldx #$02
rol21_1:                lda addr, x
                        sta tmp, x
                        dex
                        bpl rol21_1

                        ldx #$00
rol21_2:                lda addr + 3, x
                        sta addr,x
                        inx
                        cpx #$07
                        bne rol21_2

                        ldx #$02
rol21_3:                lda tmp, x
                        sta addr + 5, x
                        dex
                        bpl rol21_3

                        :ror64bits(addr, 3)
}

//------------------------------------------------------------------
// rol32(addr)
//
// Macro to rotate a 64 bit word, 32 bits left.
// We do this by moving 32 bits left via the temp bytes.
//------------------------------------------------------------------
.macro rol32(addr)
{
                        ldx #$03
rol32_1:                lda addr, x
                        sta tmp, x
                        lda addr+4, x
                        sta addr, x
                        lda tmp, x
                        sta addr + 4, x
                        dex
                        bpl rol32_1
}

//------------------------------------------------------------------
// xor64(addr0, addr1)
//
// Macro to rotate 64 bit word bits number of steps.
//------------------------------------------------------------------
.macro xor64(addr0, addr1)
{
                        ldx #$07
xor64_1:                lda addr0, x
                        eor addr1, x
                        sta addr0, x
                        dex
                        bpl xor64_1
}

//------------------------------------------------------------------
// add64(addr0, addr1)
//
// Macro to add two 64 bit words. Results in addr0.
//------------------------------------------------------------------
.macro add64(addr0, addr1)
{
                        ldx #$07
                        clc
add64_1:                lda addr0, x
                        adc addr1, x
                        sta addr0, x
                        dex
                        bpl add64_1
}

//------------------------------------------------------------------
// mov64(addr0, addr1)
//
// Macro to move 64 bit word in addr1 into addr0
//------------------------------------------------------------------
.macro mov64(addr0, addr1)
{
                        ldx #$07
                        clc
mov64_1:                lda addr1, x
                        sta addr0, x
                        dex
                        bpl mov64_1
}

//======================================================================
// EOF mathlib.asm
//======================================================================
