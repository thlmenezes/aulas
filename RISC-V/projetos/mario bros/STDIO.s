# ============================================================
#                         CONSTANTES
# ============================================================
# Boolean
.eqv TRUE 1
.eqv FALSE 0
# Ecall Codes
.eqv INT 1
.eqv FLOAT 2
.eqv STRING 4
.eqv CHAR 11
.eqv EXIT1 10
.eqv EXIT2 93
.eqv OPEN_FILE 1024
.eqv READ_FILE 63
.eqv CLOSE_FILE 57
# ============================================================
#                           MACROS
# ============================================================
# ===========================
# 	System Call
#
# ARGUMENTOS
#
# %op -: int
# system operation code
#
# ===========================
.macro syscall(%op)
	li a7, %op
	ecall
.end_macro
# ===========================
# 	Print Registrador
# Imprime o conteúdo da
# memória apontada em reg
# como string
#
# ARGUMENTOS
#
# %reg -: reg
# endereço da string
# 
# ===========================
.macro print(%reg)
	syscall(STRING,%reg)
.end_macro
# ===========================
# 	Plus Equals +=
# ===========================
.macro ppr(%reg1,%reg2)
	add %reg1,%reg1,%reg2
.end_macro
# ===========================
# 	Minus Equals -=
# ===========================
.macro mmr(%reg1,%reg2)
	sub %reg1,%reg1,%reg2
.end_macro
# ===========================
# 	Plus Plus ++
# ===========================
.macro pp(%reg)
	pp(%reg,1)
.end_macro
.macro pp(%reg,%int)
	addi %reg,%reg,%int
.end_macro
# ===========================
# 	Minus Minus --
# ===========================
.macro mm(%reg)
	pp(%reg,-1)
.end_macro
.macro mm(%reg,%int)
	pp(%reg,-%int)
.end_macro
# ===========================
# 	Exit Default
# Encerra o programa com
# a0 = 0
# ===========================
.macro Exit()
	syscall(EXIT1)
.end_macro
# ===========================
# 	Exit 2
# Encerra o programa com um
# código de erro
# a0 = %error_code
#
# ARGUMENTOS
#
# %error_code -: int
# código de erro
#
# ===========================
.macro Exit(%error_code)
	li a0, %error_code
	syscall(EXIT2)
.end_macro
# ============================================================
#                         FUNÇÕES
# ============================================================
# ===========================
# 	Repeat Byte
#
# WARNING: unsafe
# Não checa se vai avançar
# memória indevida
#
# ARGUMENTOS
# 	a0 -: dest
# 	a1 -: byte
#       a2 -: vezes
# RETORNA
# 	VOID
# ===========================
STDIO_repeat_byte:
	blez a2, srb_out  # if vezes <= 0 => Return
		sb a1,(a0)       # dest[0] = a1
		pp(a0)		 # dest++
		mm(a2)           # vezes--
	j STDIO_repeat_byte # Enquanto vezes > 0 => Escreve Byte
srb_out:
	ret
