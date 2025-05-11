;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; neslib.s: NES Library
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PPU Registers
; Reference: https://www.nesdev.org/wiki/PPU_registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PPUCTRL = $2000
; Bits: VPHB SINN
; Writeable only
; V: NMI enable (0: off, 1: on)
; P: PPU master/slave (0: read backdrop from EXT pins, 1: output color on EXT pins; never set, it could damage PPU)
; H: Sprite size (0: 8x8 pixels, 1: 8x16 pixels)
; B: Background pattern table address (0: $0000, 1: $1000)
; S: Sprite pattern table address for 8x8 sprites (0: $0000, 1: $1000; ignored in 8x16 mode)
; I: VRAM address increment per PCU read/write of PPUDATA (0: add 1, 1: add 32)
; NN: Base nametable address (0: $2000, 1: $2400, 2: $2800, 3: $2C00)

PPUMASK = $2001
; Bits: BGRs bMmG
; Writeable only
; B: Emphasize blue
; G: Emphasize green (read on PAL/Dendy)
; R: Emphasize red (green on PAL/Dendy)
; s: Sprite rendering enable (0: off, 1: on)
; b: Background rendering enable (0: off, 1: on)
; M: 0: Sprites are hidden in leftmost 8 pixels of screen, 1: Sprites are shown
; m: 0: Background is hidden in leftmost 8 pixels of screen, 1: Background is shown
; G: 0: normal color, 1: grayscale

PPUSTATUS = $2002
; Bits: VSO- ----
; Readable only
; V: Vblank flag, cleared on read
; S: Sprint 0 hit flag
; O: Sprite overflow flag
; -: PPU open bus or 2C05 arcade PPU identifiter

OAMADDR = $2003
; Bits: AAAA AAAA
; Writeable only
; The adress of the PPU's OAM to read/write
; Most games just write $00 here and then use OAMDMA

OAMDATA = $2004
; Bits: DDDD DDDD
; Readable and writeable
; Write to or read from the PPU's OAM at address OAMADDR
; Writes will increment OAMADDR after the write, reads will not
; Not as common as using OAMDMA

PPUSCROLL = $2005
; Bits: XXXX XXXX  YYYY YYYY
; Writeable: 2 writes, X scroll then Y scroll
; Controls which pixel of the nametable selectiong through PPUCTRL should be
;   at the top left corner of the rendered screen
; The PPU scroll registers share internal state with the PPU address registers,
;   so PPUSCROLL and the nametable bits in PPUCTRL should be written after any
;   writes to PPUADDR
; Horizontal offsets range from 0 to 255
; Vertical offsets range from 0 to 239

PPUADDR = $2006
; Bits: ..AA AAAA  AAAA AAAA
; Writeable: 2 writes, MSB then LSB
; Controls the address of the VRAM to read/write
; Reset the address byte that will be updated back to MSB by reading PPUSTATUS
;   before writing to PPUADDR

PPUDATA = $2007
; Bits: DDDD DDDD
; Readable and writeable
; Write to or read from the PPU's VRAM at address PPUADDR
; Accesses will increment the PPUADDR value by 1 or 32 after each read/write
;   (controlled by PPUCTRL[2])

OAMDMA = $4014
; Bits: AAAA AAAA
; Writeable
; Writign to this register sets the high byte of the CPU's source memory
;   address and then immediately copies 256 bytes to the PPU's OAM
