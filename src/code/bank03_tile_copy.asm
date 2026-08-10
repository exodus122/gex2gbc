call_03_6efd_VRAM_Copy32Bytes:
; Unrolled copy of exactly 32 bytes from HL to DE - the first 16 here, then falling into
; call_03_6f2d_VRAM_Copy16Bytes for the rest. (The old comment said it fell into
; VRAM_Copy32Bytes, i.e. itself.)
;
; 32 bytes is TWO 8x8 tiles, not one. A GB 2bpp tile is 16 bytes total - two bytes per row,
; eight rows - and that does not change on GBC, which adds a second VRAM bank for attributes
; rather than doubling tile size. The old "16 bytes per plane x 2 for GBC" was wrong on both
; counts.
;
; Note the join: this half ends on `inc DE` rather than `inc E`, so the pair carries correctly
; across a page boundary between the two tiles
    ld   A, [HL+]                                      ;; 03:6efd $2a
    ld   [DE], A                                       ;; 03:6efe $12
    inc  E                                             ;; 03:6eff $1c
    ld   A, [HL+]                                      ;; 03:6f00 $2a
    ld   [DE], A                                       ;; 03:6f01 $12
    inc  E                                             ;; 03:6f02 $1c
    ld   A, [HL+]                                      ;; 03:6f03 $2a
    ld   [DE], A                                       ;; 03:6f04 $12
    inc  E                                             ;; 03:6f05 $1c
    ld   A, [HL+]                                      ;; 03:6f06 $2a
    ld   [DE], A                                       ;; 03:6f07 $12
    inc  E                                             ;; 03:6f08 $1c
    ld   A, [HL+]                                      ;; 03:6f09 $2a
    ld   [DE], A                                       ;; 03:6f0a $12
    inc  E                                             ;; 03:6f0b $1c
    ld   A, [HL+]                                      ;; 03:6f0c $2a
    ld   [DE], A                                       ;; 03:6f0d $12
    inc  E                                             ;; 03:6f0e $1c
    ld   A, [HL+]                                      ;; 03:6f0f $2a
    ld   [DE], A                                       ;; 03:6f10 $12
    inc  E                                             ;; 03:6f11 $1c
    ld   A, [HL+]                                      ;; 03:6f12 $2a
    ld   [DE], A                                       ;; 03:6f13 $12
    inc  E                                             ;; 03:6f14 $1c
    ld   A, [HL+]                                      ;; 03:6f15 $2a
    ld   [DE], A                                       ;; 03:6f16 $12
    inc  E                                             ;; 03:6f17 $1c
    ld   A, [HL+]                                      ;; 03:6f18 $2a
    ld   [DE], A                                       ;; 03:6f19 $12
    inc  E                                             ;; 03:6f1a $1c
    ld   A, [HL+]                                      ;; 03:6f1b $2a
    ld   [DE], A                                       ;; 03:6f1c $12
    inc  E                                             ;; 03:6f1d $1c
    ld   A, [HL+]                                      ;; 03:6f1e $2a
    ld   [DE], A                                       ;; 03:6f1f $12
    inc  E                                             ;; 03:6f20 $1c
    ld   A, [HL+]                                      ;; 03:6f21 $2a
    ld   [DE], A                                       ;; 03:6f22 $12
    inc  E                                             ;; 03:6f23 $1c
    ld   A, [HL+]                                      ;; 03:6f24 $2a
    ld   [DE], A                                       ;; 03:6f25 $12
    inc  E                                             ;; 03:6f26 $1c
    ld   A, [HL+]                                      ;; 03:6f27 $2a
    ld   [DE], A                                       ;; 03:6f28 $12
    inc  E                                             ;; 03:6f29 $1c
    ld   A, [HL+]                                      ;; 03:6f2a $2a
    ld   [DE], A                                       ;; 03:6f2b $12
    inc  DE                                            ;; 03:6f2c $13
call_03_6f2d_VRAM_Copy16Bytes:
; Unrolled copy of exactly 16 bytes - one 8x8 2bpp tile - from HL to DE. The fundamental
; tile-write primitive, used throughout the HUD system.
;
; Fifteen `inc E` and then a final `inc DE`, so D is held fixed across the tile but does
; carry on the last byte, leaving DE pointing at the next tile even across a page boundary.
; The old comment claimed D stays fixed throughout, which misses that last increment
    ld   A, [HL+]                                      ;; 03:6f2d $2a
    ld   [DE], A                                       ;; 03:6f2e $12
    inc  E                                             ;; 03:6f2f $1c
    ld   A, [HL+]                                      ;; 03:6f30 $2a
    ld   [DE], A                                       ;; 03:6f31 $12
    inc  E                                             ;; 03:6f32 $1c
    ld   A, [HL+]                                      ;; 03:6f33 $2a
    ld   [DE], A                                       ;; 03:6f34 $12
    inc  E                                             ;; 03:6f35 $1c
    ld   A, [HL+]                                      ;; 03:6f36 $2a
    ld   [DE], A                                       ;; 03:6f37 $12
    inc  E                                             ;; 03:6f38 $1c
    ld   A, [HL+]                                      ;; 03:6f39 $2a
    ld   [DE], A                                       ;; 03:6f3a $12
    inc  E                                             ;; 03:6f3b $1c
    ld   A, [HL+]                                      ;; 03:6f3c $2a
    ld   [DE], A                                       ;; 03:6f3d $12
    inc  E                                             ;; 03:6f3e $1c
    ld   A, [HL+]                                      ;; 03:6f3f $2a
    ld   [DE], A                                       ;; 03:6f40 $12
    inc  E                                             ;; 03:6f41 $1c
    ld   A, [HL+]                                      ;; 03:6f42 $2a
    ld   [DE], A                                       ;; 03:6f43 $12
    inc  E                                             ;; 03:6f44 $1c
    ld   A, [HL+]                                      ;; 03:6f45 $2a
    ld   [DE], A                                       ;; 03:6f46 $12
    inc  E                                             ;; 03:6f47 $1c
    ld   A, [HL+]                                      ;; 03:6f48 $2a
    ld   [DE], A                                       ;; 03:6f49 $12
    inc  E                                             ;; 03:6f4a $1c
    ld   A, [HL+]                                      ;; 03:6f4b $2a
    ld   [DE], A                                       ;; 03:6f4c $12
    inc  E                                             ;; 03:6f4d $1c
    ld   A, [HL+]                                      ;; 03:6f4e $2a
    ld   [DE], A                                       ;; 03:6f4f $12
    inc  E                                             ;; 03:6f50 $1c
    ld   A, [HL+]                                      ;; 03:6f51 $2a
    ld   [DE], A                                       ;; 03:6f52 $12
    inc  E                                             ;; 03:6f53 $1c
    ld   A, [HL+]                                      ;; 03:6f54 $2a
    ld   [DE], A                                       ;; 03:6f55 $12
    inc  E                                             ;; 03:6f56 $1c
    ld   A, [HL+]                                      ;; 03:6f57 $2a
    ld   [DE], A                                       ;; 03:6f58 $12
    inc  E                                             ;; 03:6f59 $1c
    ld   A, [HL+]                                      ;; 03:6f5a $2a
    ld   [DE], A                                       ;; 03:6f5b $12
    inc  DE                                            ;; 03:6f5c $13
    ret                                                ;; 03:6f5d $c9
