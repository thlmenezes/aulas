# =================================
#           CONSTANTES
# =================================
.eqv INT 1
.eqv FLOAT 2
.eqv STRING 4
# =================================
#             MACROS
# =================================
# Print Mem
# 	label -> 0
# Imprime no RUN I/O como string a
# partir de label
.macro print_mem(%label)
	li a7, STRING  # Print String
	la a0, %label
	ecall
.end_macro
# Print String
# 	str -> 0
# Imprime no RUN I/O String Literal
.macro print(%str)
.data
texto: .string %str
.text
	li a7, STRING  # Print String
	la a0, texto
	ecall
.end_macro
# Print
.macro print(%op, %reg)
	li a7, %op
	mv a0, %reg
	ecall
.end_macro
# Lê caractere
.macro read_char()
	li a7, 12  # Read Char
	ecall
.end_macro
# Plus Equals +=
.macro pp(%reg,%int)
	addi %reg,%reg,%int
.end_macro
# Plus Plus ++
.macro pp(%reg)
	pp(%reg,1)
.end_macro
# Exit default retornando 0
.macro Exit()
	li a7, 10  # Exit
	ecall
.end_macro
# Exit returnando error code
# 	int -> 0
.macro Exit(%int)
	li a7, 93   # Exit
	li a0, %int # Error Code
	ecall
.end_macro