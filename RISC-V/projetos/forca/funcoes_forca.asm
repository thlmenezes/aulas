# =================================
#            FUNÇÕES
# =================================

# Conta Caracteres
#        a0 -> endereço
#        a1 -> char
# return nº de underlines
conta_caracteres:
	li t2, 0
cc_loop:
	lb t0, (a0)            # Carrega uma letra de oculta
	li t1, '\0'
	beq t0,t1,cc_fora_func # if t0 != '\0' -> string não vazia
	bne t0,a1,cc_fora_cond # if t0 == a1 -> Encontrei mais uma letra
		pp(t2)         # t2++
cc_fora_cond:
	pp(a0)                 # a0++
	j cc_loop
cc_fora_func:
	mv a0,t2
	ret

# Char Lower
#	 char -> char
# retorna letras minúsculas
# 
# a0 contém input original ou versão
# minuscula
char_lower:
	li t0, 'A'
	blt a0, t0, cl_fora_func
	li t0, 'Z', 
	bgt a0, t0, cl_fora_func
	# if 'A' <= a0 <= 'Z': é uma letra maiúscula
	li t0, 0x20
	sub a0,a0,t0 # 'A' - 0x20 = 'a'
cl_fora_func:
	ret

# Valida Input
# 	a0 -> char
# return a1
# 	0  -> se não for letra
#       1  -> se for minuscula
#       2  -> se for maiuscula
checa_input:
	li t0, 'a'
	blt a0, t0, ci_falhou
	li t0, 'z',
	bgt a0, t0, ci_eh_maius
	# if 'a' <= a0 <= 'z': é uma letra minúscula
	li a1, 1
	j ci_fora_func
ci_eh_maius:
	li t0, 'A'
	blt a0, t0, ci_falhou
	li t0, 'Z', 
	bgt a0, t0, ci_falhou
	# if 'A' <= a0 <= 'Z': é uma letra maiúscula
	li a1, 2
	j ci_fora_func
ci_falhou:
	li a1, 0
ci_fora_func:
	ret

# Valida Chute
# 	a0 -> char
#	a1 -> string
#	a2 -> string
# Substitui todas os '_' em a2,
# conforme a0 acerta a resposta
valida_chute:
	lb t0, (a2)            # Carrega uma letra de oculta
	li t1, '\0'
	beq t0,t1,vc_fora_func # if t0 != '\0' -> string não vazia
	li t1, '_'
	bne t0,t1,vc_fora_cond # if t0 == '_' -> Ainda não acertou essa letra
		lb t0, (a1) 		 # Carrega uma letra de palavra
		bne t0, a0, vc_fora_cond # if t0 == a0 -> Acertou o chute
		sb a0, (a2)              # Escreve a0 em oculta
vc_fora_cond:
	pp(a1) # a1++
	pp(a2) # a2++
	j valida_chute
vc_fora_func:
	ret