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
# ============================================================
#                           MACROS
# ============================================================
# system call
.macro System(%op)
	li a7, %op
	ecall
.end_macro
#.macro System(%op, %reg)
#	li a7, %op
#	mv a0, %reg
#	ecall
#.end_macro
.macro print(%reg)
	System(STRING,%reg)
.end_macro
# Plus Equals +=
.macro ppr(%reg1,%reg2)
	add %reg1,%reg1,%reg2
.end_macro
# Minus Equals -=
.macro mmr(%reg1,%reg2)
	sub %reg1,%reg1,%reg2
.end_macro
# Plus Plus ++
.macro pp(%reg)
	pp(%reg,1)
.end_macro
.macro pp(%reg,%int)
	addi %reg,%reg,%int
.end_macro
# Minus Minus --
.macro mm(%reg)
	pp(%reg,-1)
.end_macro
.macro mm(%reg,%int)
	pp(%reg,-%int)
.end_macro
# Exit default retornando 0
.macro Exit()
	System(10)  # Exit
.end_macro
# Exit returnando error code
# 	int -> 0
.macro Exit(%int)
	li a0, %int # Error Code
	System(93) # Exit
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
