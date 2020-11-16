# AVISO: depende de STDIO.s
# ============================================================
#                         CONSTANTES
# ============================================================
# FLAGS
.eqv FILE.READ 0
.eqv FILE.WRITE 1
.eqv FILE.APPEND 9
# ============================================================
#                           MACROS
# ============================================================
# ===========================
# 	Abrir Arquivo
# 
# WARNING:
# o caminho do arquivo deve
# ser considerado à partir
# do diretório do RARS.jar
# 
# ARGUMENTOS
#
# %flags -: READ,WRITE,APPEND
# modo de abertura do arquivo
# 
# %path_to_file -: string
# caminho até o arquivo
#
# RETORNA
# 	a0 -: file descriptor
# 	-1 em caso de ERRO
# ===========================
.macro FILE_OPEN(%flag,%path_to_file)
.data
FILE_PATH: .string %path_to_file
.text
	la a0, FILE_PATH
	li a1, %flag
	syscall(OPEN_FILE)
.end_macro
# ===========================
# 	Ler Arquivo
# 
# ARGUMENTOS
#
# %regfile_descriptor -: reg
# registrador contendo
# file descriptor
# 
# %path_to_file -: string
# caminho até o arquivo
#
# RETORNA
# 	a0 -: nº bytes lidos
# 	-1 em caso de ERRO
# ===========================
.macro FILE_READ(%regfile_descriptor,%buffer_add,%max_length)
	mv a0, %regfile_descriptor
	li a1, %buffer_add
	li a2, %max_length
	syscall(READ_FILE)    # Ler arquivo
.end_macro
# ===========================
# 	Fechar Arquivo
# 
# ARGUMENTOS
#
# %regfile_descriptor -: reg
# registrador file descriptor
#
# RETORNA
# 	N/A
# ===========================
.macro FILE_CLOSE(%regfile_descriptor)
	mv a0, %regfile_descriptor
	syscall(CLOSE_FILE)   # Fecha Arquivo
.end_macro