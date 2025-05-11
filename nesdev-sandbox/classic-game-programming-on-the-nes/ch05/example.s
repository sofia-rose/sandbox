; ppu registers
PPU_CONTROL = $2000
PPU_MASK = $2001
PPU_STATUS = $2002
PPU_SPRRAM_ADDRESS = $2003
PPU_SPRRAM_IO = $2004
PPU_VRAM_ADDRESS1 = $2005
PPU_VRAM_ADDRESS2 = $2006
PPU_VRAM_IO = $2007
SPRITE_DMA = $4014

; apu registers
APU_DM_CONTROL = $4010
APU_CLOCK = $4015

; gamepad values
GAMEPAD1 = $4016
GAMEPAD2 = $4017

; gamepad bit values
PAD_A = 1 << 7
PAD_B = 1 <<6
PAD_SELECT = 1 << 5
PAD_START = 1 << 4
PAD_U = 1 << 3
PAD_D =  1 << 2
PAD_L = 1 << 1
PAD_R =  1 << 0

.segment "HEADER"
INES_MAPPER = 0 ; 0 = NROM
INES_MIRROR = 0 ; 0 = horizontal mirroring, 1 = vertical mirroring
INES_SRAM = 0 ; 1 = battery backed SRAM at $6000-$7FFF

.byte 'N', 'E', 'S', $1A ; ID
.byte $02 ; 16K PRG bank count
.byte $01 ; 8K CHR bank count
.byte INES_MIRROR | (INES_SRAM << 1) | ((INES_MAPPER & $f) << 4)
.byte (INES_MAPPER & $11110000)
.byte $0, $0, $0, $0, $0, $0, $0, $0

.segment "VECTORS"
.word nmi
.word reset
.word irq

.segment "ZEROPAGE"

nmi_channel: .res 1
gamepads: .res 2
d_x: .res 1
d_y: .res 1

.segment "OAM"
oam: .res 256

.segment "RODATA"
default_palette:
.byte $0F, $15, $26, $37 ; background 0: purple/pink
.byte $0F, $09, $19, $29 ; background 1: green
.byte $0F, $01, $11, $21 ; background 2: blue
.byte $0F, $00, $10, $30 ; background 3: grayscale
.byte $0F, $18, $28, $38 ; sprite 0: yellow
.byte $0F, $14, $24, $34 ; sprite 1: purple
.byte $0F, $1B, $2B, $3B ; sprite 2: teal
.byte $0F, $12, $22, $32 ; sprite 3: marine

welcome_txt:
.byte 'W', 'E', 'L', 'C', 'O', 'M', 'E', 0

.segment "TILES"
.incbin "example.chr"

.segment "BSS"
palette: .res 32

.segment "CODE"
irq:
  rti

.segment "CODE"
.proc reset
sei ; mask interrupts
lda #0
sta PPU_CONTROL ; disable NMI
sta PPU_MASK ; disable rendering
sta APU_DM_CONTROL ; disable DMC IRQ
lda #$40
sta GAMEPAD2 ; disable APU frame IRQ
cld ; disable decimal mode
ldx #$FF
txs ; initialize stack pointer

bit PPU_STATUS ; this is not redundant, on reset vblank status is in unknown state, need to reset vblank status before waiting for vblank again
wait_vblank:
  bit PPU_STATUS
  bpl wait_vblank

lda #0
ldx #0
clear_ram:
  sta $0000,x
  sta $0200,x
  sta $0200,x
  sta $0300,x
  sta $0400,x
  sta $0500,x
  sta $0600,x
  sta $0700,x
  inx
  bne clear_ram

lda #255
ldx #0
clear_oam:
  sta oam, x
  inx
  inx
  inx
  inx
  bne clear_oam

wait_vblank2:
  bit PPU_STATUS
  bpl wait_vblank2

lda #%10001000
sta PPU_CONTROL

jmp main
.endproc

.segment "CODE"
.proc nmi
; save registers (program counter and processor status already pushed to stack)
pha
txa
pha
tya
pha

; nmi_channel == 0: channel is empty, do nothing
; nmi_channel == 1: write to PPU and turn on PPU rendering
; nmi_channel == 2: turn PPU rendering off
; the nmi routine acknowledges command by setting nmi_channel back to 0
lda nmi_channel
bne process_nmi_command
jmp nmi_end

process_nmi_command:
  cmp #2
  bne update_ppu
  lda #%00000000
  sta PPU_MASK ; 0 at bit 4 disables PPU sprite rendering, 0 at bit 4 disables PPU background rendering
  ldx #0
  stx nmi_channel
  jmp nmi_end

update_ppu:
  ldx #0
  stx PPU_SPRRAM_ADDRESS
  lda #>oam
  sta SPRITE_DMA

  lda #%10001000
  sta PPU_CONTROL
  lda PPU_STATUS ; read PPU_STATUS to reset PPU_VRAM_ADDRESS2 back to first write
  ; set PPU address to $3F00
  lda #$3F
  sta PPU_VRAM_ADDRESS2
  ; x is already 0
  stx PPU_VRAM_ADDRESS2

loop: ; transfers 32 bytes of palette to VRAM
  lda palette, x
  sta PPU_VRAM_IO
  inx
  cpx #32
  bcc loop

  ; bit 4: 1 enables sprite rendering
  ; bit 3: 1 enables background rendering
  ; bit 2: 1 shows sprites in leftmost 8 pixels of screen
  ; bit 1: 1 shows background in leftmost 8 pixels of screen
  lda #%00011110
  sta PPU_MASK

  ; signal that nmi processed the command in the channel
  ldx #0
  stx nmi_channel

nmi_end:
  pla
  tay
  pla
  tax
  pla
  rti
.endproc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; render_on_and_wait_on_frame:
;   description:
;     Turn PPU rendering on and then wait for next NMI to complete.
;   caller save registers: A
;   stack clearance: 2 bytes
;   memory effects: 1 byte at address "nmi_channel"
;   IO effects: none
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"
.proc render_on_and_wait_on_frame
  lda #1
  sta nmi_channel

  loop:
    lda nmi_channel
    bne loop

  rts
.endproc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; render_off_and_wait_on_frame:
;   description:
;     Turn PPU rendering off and then wait for next NMI to complete.
;   caller save registers: A
;   stack clearance: 2 bytes
;   memory effects: 1 byte at address "nmi_channel"
;   IO effects: none
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"
.proc render_off_and_wait_on_frame
  lda #2
  sta nmi_channel

  loop:
    lda nmi_channel
    bne loop

  rts
.endproc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; clear_nametable
;   description:
;     Set entire nametable to tile index 0 and clear the 16x16 attribute table.
;   caller save registers: A, X, Y
;   stack clearance: 2 bytes
;   memory effects: none
;   IO effects: PPU nametable, PPU attribute table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"
.proc clear_nametable
  lda PPU_STATUS ; read PPU_STATUS to reset PPU_VRAM_ADDRESS2 back to first write
  lda #$20 ; sets PPU address to $2000
  sta PPU_VRAM_ADDRESS2
  lda #$00
  sta PPU_VRAM_ADDRESS2

  ; write 30 rows of 32 columns to clear background
  ; tile 0 was purposely setup as an "empty" tile for "clearing"
  lda #0
  ldy #30
  rowloop:
    ldx #2
    columnloop:
      sta PPU_VRAM_IO
      dex
      bne columnloop
    dey
    bne rowloop

  ; clear the 64 byte attribute table
  lda PPU_STATUS ; read PPU_STATUS to reset PPU_VRAM_ADDRESS2 back to first write
  lda #$23 ; sets PPU address to $23C0, the beginning of nametable0's attribute table
  sta PPU_VRAM_ADDRESS2
  lda #$C0
  sta PPU_VRAM_ADDRESS2
  lda #%10101010
  ldx #64
  loop:
    sta PPU_VRAM_IO
    dex
    bne loop

  rts
.endproc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; read_gamepads
;   description: tbd
;   caller save registers: A, X
;   stack clearance: 2 bytes
;   memory effects: updates 2 bytes at address "gamepads"
;   IO effects: strobes gamepads and reads status of each gamepad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"
read_gamepads:
  ldx #$00
  jsr read_gamepad ; X=0: read controller 1
  inx
  ; fall through to read_gamepad, X=1: read controller 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; read_gamepad
;   description: tbd
;   inputs: X register, X=0: controller 1, X=1: controller 2
;   caller save registers: A
;   stack clearance: 2 bytes
;   memory effects: updates byte at address "gamepads" + X
;   IO effects: strobes gamepad and reads status of gamepad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
read_gamepad:
  lda #$01
  sta GAMEPAD1 ; whle strobe bit is set, button status will be continuously reloaded
  sta gamepads, x ; initialize LSB of gamepad byte to 1
  lsr a ; A=0 after shifting
  sta GAMEPAD1 ; strobe bit is cleared, and the button status reloading stops
loop:
  lda GAMEPAD1, x ; X=0: controller 1, X=1: controller 2
  and #%00000011 ; ignore bits other than controller (bit 0: standard controller, bit 1: famicom expansion port controller)
  cmp #$01 ; set carry if nonzero
  rol gamepads, x ; carry -> bit 0, bit 7 -> carry
  bcc loop ; loop until the initial LSB (set to 1 above) rotates into carry flag
  rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; main
;   description:
;     main game logic
;
;   caller save registers: N/A
;   stack clearance: N/A
;   memory effects: N/A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"
.proc main
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; load palette into RAM
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ldx #0
  paletteloop:
    lda default_palette, x
    sta palette, x
    inx
    cpx #32
    bcc paletteloop

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; clear screen background
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  jsr clear_nametable

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; draw text on screen
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  lda PPU_STATUS ; reset PPU address latch

  ; Set PPU address to $208A
  ; nametable address = base address + 32*row + column
  ; row = 4, column = 10: $2000 + 32*4 + 10 = $2000 + $80 + $A
  lda #$20
  sta PPU_VRAM_ADDRESS2
  lda #$8A
  sta PPU_VRAM_ADDRESS2

  ldx #0
  textloop:
    lda welcome_txt, x
    cmp #0
    beq end_textloop
    sta PPU_VRAM_IO
    inx
    jmp textloop
  end_textloop:

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; Sprite definition
  ; byte 0:
  ;   Y coordinate of top-left corner of 8x8 pixel sprite. If Y coordinate is
  ;   between 239 and 255, it will not be visible on the screen
  ; byte 1:
  ;   Index into the sprite tile pattern table
  ; byte 2:
  ;   Bits 0-1: Sprite palette index
  ;   Bits 2-4: Reserved/Unused?
  ;   Bit 5:
  ;     0: sprite is drawn in front of the background
  ;     1: sprite is drawn behind the background
  ;   Bit 6: If set to 1, flip the sprite pattern horizontally
  ;   Bit 7: If set to 1, flip the sprite pattern vertically
  ; byte 3:
  ;   X coordinate of the top-left corner of the sprite
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; place bat sprite on screen (sprite 0)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  lda #180 ; Y position
  sta oam

  lda #120 ; X position
  sta oam + 3

  lda #1 ; index into sprite tile pattern table
  sta oam + 1

  lda #%000000001 ; 1 sprite palette index, in front of background, not flipped
  sta oam + 2

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; place ball sprite on screen (sprite 1)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  lda #124 ; Y and X position
  sta oam + (1 * 4)
  sta oam + (1 * 4) + 3

  lda #2 ; index into sprite tile pattern table
  sta oam + (1 * 4) + 1

  lda #%00000010 ; 0 sprite palette index, in front of background, not flipped
  sta oam + (1 * 4) + 2

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; initialize ball velocity
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  lda #1
  sta d_x
  sta d_y

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; turn PPU rendering on
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  jsr render_on_and_wait_on_frame

  mainloop:
    lda nmi_channel
    cmp #0
    bne mainloop ; loop if waiting on NMI routine to process command

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; move bat left and right based on gamepad input
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    jsr read_gamepads

    lda gamepads
    and #PAD_L
    beq NOT_GAMEPAD_LEFT
      ; left was pressed:
      lda oam + 3
      cmp #0
      beq NOT_GAMEPAD_LEFT ; cannot move left if X position is already 0
      sec
      sbc #1
      sta oam + 3 ; move X position 1 pixel left

    NOT_GAMEPAD_LEFT:
      lda gamepads
      and #PAD_R
      beq NOT_GAMEPAD_RIGHT
        ; right was pressed:
        lda oam + 3
        cmp #248
        beq NOT_GAMEPAD_RIGHT ; cannot move right if X position is already 248
        clc
        adc #1
        sta oam + 3 ; move X position 1 pixel right

    NOT_GAMEPAD_RIGHT:

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; move ball based on its velocity and hitting screen boundaries
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      lda oam + (1 * 4) + 0 ; load Y position
      clc
      adc d_y
      sta oam + (1 * 4) + 0
      cmp #0 ; check if hit top border
      bne NOT_HITTOP
        ; hit top, must reverse velocity
        ; assumes previous velocity was -1
        lda #1
        sta d_y

      NOT_HITTOP:
        lda oam + (1 * 4) + 0 ; reload Y position
        cmp #210 ; check if hit bottom border
        bne NOT_HITBOTTOM
          ; hit bottom, must reverse velocity
          ; assumes previous velocity was 1
          lda #$FF
          sta d_y

      NOT_HITBOTTOM:
        lda oam + (1 * 4) + 3 ; load X position
        clc
        adc d_x
        sta oam + (1 * 4) + 3
        cmp #0 ; check if hit left border
        bne NOT_HITLEFT
          ; hit left border, must reverse velocity
          ; assumes previous velocity was -1
          lda #1
          sta d_x

      NOT_HITLEFT:
        lda oam + (1 * 4) + 3 ; reload X position
        cmp #248 ; check if hit left border
        bne NOT_HITRIGHT
          ; hit right border, must reverse velocity
          ; assumes previous velocity was 1
          lda #$FF
          sta d_x

      NOT_HITRIGHT:

        ; tell NMI routine to render screen
        lda #1
        sta nmi_channel
        jmp mainloop
.endproc
