.text
# BMDisplay - Imprime Linha
# ============================================================
	BMP_get_address(0,20,BMP_F0_BEGIN)
	li a1, 0x55    # COR
	li a2, 4       # Grossura
	jal BMP_draw_line
	Exit()
# STDIO_repeat_byte
# ============================================================
	li a0, BMP_F0_BEGIN
	li a1, 0x55    # COR
	li a2, 4       # Repeticoes
	jal STDIO_repeat_byte
	Exit()
# BMDisplay - 1 pixel
# ============================================================
	BMP_get_address(110,120,BMP_F0_BEGIN)
	# Endereço no Bitmap
	li t0, 0x55
	sb t0, (a0)
	Exit()
# BMDisplay - Tela Toda
# ============================================================
	li t0, BMP_F0_BEGIN
	li s0, BMP_F0_END
	li t1, 0xc7ffc7ff
loop:
	sw t1, (t0)
	pp(t0,4)
	
	beq t0,s0,exit
	j loop
exit:
	Exit()
# KMMIO Code
# ============================================================
	li s0, MMIO_set     # ready bit MMIO
pool_loop:
	lb t1, (s0)         # Recupera o valor de ready bit
	beqz t1, pool_loop  # Aguarda enquanto ready bit == 0
	li a0, MMIO_add     # data address MMIO
	lw a0, (a0)         # Recupera dado do MMIO
	System(CHAR)        # Print Char
	j pool_loop  # loop infinito
	Exit()
