//======================================================================
//
// xorshift.asm
// ----------
// Implementation of the PRNG xorshift in 6502 assembler.
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

#import "mathlib.asm"

//------------------------------------------------------------------
// Include KickAssembler Basic uppstart code.
//------------------------------------------------------------------
.pc =$0801 "Basic Upstart Program"
:BasicUpstart($4000)

//------------------------------------------------------------------
// XORSHIFTS Test
//------------------------------------------------------------------
.pc = $4000 "XORSHIFT Test"
		jsr xorshift

		lda #$05
		sta $d020
        	rts


xorshift:
		// state = state xor (state << 13)
		:cpy32(state, tmp1)
		:rol32bits(tmp1, 13)
		:xor32(state, tmp1)

		// state = state xor (state >> 17)
		:cpy32(state, tmp1)
		:ror32bits(tmp1, 17)
		:xor32(state, tmp1)

		// state = state xor (state << 5)
		:cpy32(state, tmp1)
		:rol32bits(tmp1, 5)
		:xor32(state, tmp1)
		rts


//------------------------------------------------------------------
// State registers and data fields.
//------------------------------------------------------------------
.pc = $5000
state:	      .byte $de, $ad, $be, $ef, $00, $00, $00, $0
tmp1:	      .byte $de, $ad, $be, $ef, $00, $00, $00, $0

.pc = $6000
t1:          .byte $de, $ad, $be, $ef, $00, $00, $00, $00

.pc = $6010
t2:          .byte $de, $ad, $be, $ef, $00, $00, $00, $00

.pc = $6020
t3:          .byte $de, $ad, $be, $ef, $00, $00, $00, $00

.pc = $6030
t4:          .byte $de, $ad, $be, $ef, $00, $00, $00, $00

.pc = $6040
t5:          .byte $de, $ad, $be, $ef, $00, $00, $00, $00

.pc = $6050
t6:          .byte $de, $ad, $be, $ef, $00, $00, $00, $00

.pc = $6060
t7:          .byte $de, $ad, $be, $ef, $00, $00, $00, $00

.pc = $6070
t8:          .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

//======================================================================
// EOF xorshift.asm
//======================================================================
