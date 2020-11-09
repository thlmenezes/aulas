# AVISO: depende de STD_MACROS.s
# ============================================================
#                         CONSTANTES
# ============================================================
.eqv BMP_F0_BEGIN   0xff000000
.eqv BMP_F0_END     0xff012C00
.eqv BMP_F1_BEGIN   0xff100000
.eqv BMP_F1_END     0xff112C00
.eqv BMP_SET_FRAME  0xff200604
.eqv BMP_WIDTH      320
.eqv BMP_HEIGHT     240
.eqv BMP_BLANK_BYTE 0xc7
# ============================================================
#                           MACROS
# ============================================================
.macro BMP_get_address(%x,%y,%imm)
	li a0,%x
	li a1,%y
	jal BMP_xy_to_ind
	li t0, %imm
	ppr(a0,t0)
.end_macro
# ============================================================
#                         FUNÇÕES
# ============================================================
# Error Code begins in 200 => BMP_FUNCOES.s
# ===========================
# 	XY to Index
# ARGUMENTOS
# 	a0 -: x
# 	a1 -: y
# RETORNA
# 	a0 -: Indice do vetor
# 	de pixels
# ===========================
BMP_xy_to_ind:
# Validação dos Argumentos
	bltz a0, bxti_error
	bltz a1, bxti_error
	# if x < 0 or y < 0
	li t0, BMP_HEIGHT
	bge a1, t0, bxti_error
        # if y >= BMP_HEIGHT  => Exit Error 223
	li t0, BMP_WIDTH
	bge a0, t0, bxti_error
        # if x >= BMP_WIDTH   => Exit Error 223
# Corpo da função
	mul a1, a1, t0   #   Y*BMP_WIDTH
	add a0, a0, a1   # + X
	                 # ---------------
			 # Índice de (x,y)
bxti_out:
	ret
bxti_error:
	Exit(223)
# ===========================
# 	Index to XY
# ARGUMENTOS
# 	a0 -: index
# RETORNA
# 	a0 -: x
# 	a1 -: y
# ===========================
BMP_ind_to_xy:
# Validação dos Argumentos
	bltz a0, bitx_error
	# if ind < 0 => Exit Error 232
	li t0, BMP_WIDTH
	li t1, BMP_HEIGHT
	mul t1, t1, t0   # WIDTH*HEIGHT = nº pixels
	bgt a0, t1, bitx_error
        # if ind > nº pixels => (Index Out Of Range) Exit Error 232
# Corpo da função
	div a1, a0, t0   # Y = index // BMP_WIDTH
	rem a0, a0, t0   # X = index % BMP_WIDTH
bitx_out:
	ret
bitx_error:
	Exit(232)
# ===========================
# 	Draw Line
#
# WARNING: unsafe
# Não checa se vai avançar
# memória indevida
#
# ARGUMENTOS
# 	a0 -: Endereço Inicial
# 	a1 -: Cor (byte)
#       a2 -: Grossura
# RETORNA
# 	VOID
# ===========================
BMP_draw_line:
	mm(sp,4)    # Aloca 1 word na pilha
	sw ra, (sp) # Guarda endereço de retorno

	li t0, BMP_WIDTH
	mul a2, a2, t0  # nº de bytes == vezes/repeticoes
	jal STDIO_repeat_byte

bdl_out:
	lw ra, (sp) # Recupera da pilha endereço de retorno
	pp(sp,4)    # Libera 1 word na pilha
	ret
# ===========================
# 	Draw Square
#
# WARNING: unsafe
# Não checa se vai avançar
# memória indevida
#
# ARGUMENTOS
# 	a0 -: Endereço Inicial
# 	a1 -: Cor (byte)
#       a2 -: Comprimento
#       a3 -: Altura
# RETORNA
# 	VOID
# ===========================
BMP_draw_square:
	mm(sp,20)     # Aloca 5 word na pilha
	sw ra,  0(sp) # Guarda endereço de retorno
bds_loop:
	blez a3, bds_out # Enquanto altura > 0
		# Guarda todos os argumentos da função atual
		sw a0,  4(sp)    # Endereço
		sw a1,  8(sp)    # COR (byte)
		sw a2, 12(sp)    # Comprimento
		sw a3, 16(sp)    # Altura
	
		# Imprime Linha de tamanho Comprimento
		# a0, a1 e a2 são os mesmos argumentos
		jal STDIO_repeat_byte

		# Recupera todos os argumentos da função atual
		lw a0,  4(sp)    # Endereço
		lw a1,  8(sp)    # COR (byte)
		lw a2, 12(sp)    # Comprimento
		lw a3, 16(sp)    # Altura
	
		pp(a0,BMP_WIDTH) # Desce uma linha
		# Cor e Comprimento se mantém
		mm(a3)           # Altura--
	j bds_loop
bds_out:
	lw ra, (sp) # Recupera da pilha endereço de retorno
	pp(sp,20)   # Libera 5 word na pilha
	ret