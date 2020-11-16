##############################################################
# - [x] Display Mapa from File
# - [ ] Player
#     - [x] Aparece
#     - [x] Pula
#     - [ ] Anda
# - [ ] Goomba
#     - [ ] Goomba anda
#     - [ ] Goomba mata player: Troca cor do player
#     - [ ] Matar Goomba: Some
#     - [ ] Morre ao sair da tela
# - [ ] Display Menu from File
# - [ ] Som
#     - [ ] Seleciona opção no Menu
#     - [ ] Morreu
#     - [ ] Vitória Chegou no topo da escada
##############################################################
.globl main
# ============================================================
#                         INCLUDES
# ============================================================
.include "./KMMIO_MACROS.s"
.include "./STDIO.s"
.include "./BMPDISPLAY.s"
.include "./FILEIO.s"
# ============================================================
#                         CONSTANTES
# ============================================================
# Big Endian (876543210) Little Endian (012345678)
# RISC-V é Little Endian
# bbgggrrr
# 00111000
.eqv COLOR_BACKGROUND 0x0
.eqv COLOR_MARIO 0x38
.eqv SIZE_MARIO 24
# ============================================================
#                           MAIN
# ============================================================
.macro draw_mario(%add,%color)
	li a0, %add
	li a1, %color
	jal draw_mario
.end_macro
.macro draw_mario(%add)
	draw_mario(%add,-1)
.end_macro
.macro ppa(%add,%imm)
	la t1,%add
	lw t0,0(t1)
	pp(t0,%imm)
	sw t0,0(t1)
.end_macro
.macro mma(%add,%imm)
	la t1,%add
	lw t0,0(t1)
	mm(t0,%imm)
	sw t0,0(t1)
.end_macro
# LOAD WORD from ADDRESS
.macro lwa(%reg,%add)
	la %reg, %add
	lw %reg, (%reg)
.end_macro
.eqv SLEEP 32
.macro sleep(%time)
	li a0, %time
	syscall(SLEEP)
.end_macro
.data
MARIO:
	MARIO_STATE:.word COLOR_MARIO
	MARIO_X:    .word 0
	MARIO_Y:    .word 138
.text
main:
	jal print_mapa
bp:	draw_mario(BMP_F0_BEGIN)
	# GAME START
	jal jump_mario
	Exit()
# JUMP
jump_mario:
	mm(sp,4)
	sw ra, (sp)
	
	# ERASE DOWN MARIO
	draw_mario(BMP_F0_BEGIN,COLOR_BACKGROUND)
	# Y -= SIZE_MARIO
	mma(MARIO_Y,SIZE_MARIO)
	# DRAW UP MARIO
	draw_mario(BMP_F0_BEGIN)
	sleep(1000)
	# ERASE UP MARIO
	draw_mario(BMP_F0_BEGIN,COLOR_BACKGROUND)
	# Y += SIZE_MARIO
	ppa(MARIO_Y,SIZE_MARIO)
	# DRAW DOWN MARIO
	draw_mario(BMP_F0_BEGIN)
	
	lw ra, (sp)
	pp(sp,4)
jm_out:
	ret
# END JUMP

# a0 -: endereço frame
# a1 -: cor
#  BMP_get_address(%x,%y,%imm)
draw_mario:
	# MARIO_STATE if a1 < 0 else a1
	bgez a1, dm_if
	lwa(a1,MARIO_STATE)
dm_if:
	mm(sp,12) # Aloca 3 word na pilha
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a1, 8(sp)
	
	lwa(a0,MARIO_X)
	lwa(a1,MARIO_Y)
	jal BMP_xy_to_ind
	lw a1, 4(sp) # get frame address
	ppr(a0,a1)   # a0 = frame address + ind
# 	a0 -: Endereço Inicial
	lw a1, 8(sp) # COR
	li a2, SIZE_MARIO
	li a3, SIZE_MARIO
	jal BMP_draw_square

	lw ra, 0(sp)
	pp(sp,12) # Libera 3 word na pilha
dm_out:
	ret

print_mapa:
	# Abrir Arquivo
	FILE_OPEN(FILE.READ,"./mario bros/assets/original/mapa.bin")
	bltz a0, pm_err # if a0 < 0 -> ERROR
	
	mv t0, a0       # backup do file descriptor
	# Ler Arquivo
	FILE_READ(t0,BMP_F0_BEGIN,0x12C00) # 320x240
	bltz a0, pm_err # if a0 < 0 -> ERROR
	
	# Fecha o arquivo
	FILE_CLOSE(t0)
pm_out:
	ret
pm_err:
	syscall(EXIT2)