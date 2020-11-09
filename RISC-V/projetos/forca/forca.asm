# =================================
# 1. [x] Menu
# 2. [x] Palavra oculta
# 3. [x] Apresentar letras certas
# 4. [x] input().lower()
# 5. [x] ENDGAME
# 6. [X] 2 opções no menu
# 7. [ ] Usuário configura oculta 
# =================================
# Bem vindo à forca
#  Pressione Enter
#
# _ _ _ _ _ _
# a
# _ a _ a _ a
# z
# Errou, 3 vidas faltando
# _ a _ a _ a
# =================================
.include "./macros_forca.asm"
# =================================
#             MAIN
# =================================
.data
REALOFICIAL: .string "ABCDE"
PONTEIRO: .word REALOFICIAL
palavra: .word   6
	 .string "banana"
oculta:  .byte '_':6 # <valor a ser repetido> : <nº de repetições>
         .byte '\0'  # Fim da string Oculta
.text
main:	
	print("Bem vindo à forca\n Pressione enter para jogar\n 1 para configs")
loop:	read_char()       # Chute do usuário
	li t0, '\n'
	beq t0, a0, setup   # while readchar() não enter
	li t0, '1'
	beq t0, a0, config  #
	j loop
config:
	# DESAFIO
	j loop
setup:	# Game SETUP

	li s0, 5         # VIDAS DO JOGADOR
	la s1, palavra
	lw s1, palavra   # Tamanho da palavra == Nº de underlines

	# Game START

	print("\n")
	print_mem(oculta) # Imprime palavra oculta _______
	print("\n")

denovo:	read_char()       # Chute do usuário
	jal checa_input
	beqz a1, denovo   # while readchar() não for uma letra
	jal char_lower
	# a0 contém resultado minúsculo
	la a1, palavra
	pp(a1,4)          # inicio da string palavra
	la a2, oculta
	jal valida_chute  # Libera letras que usuário acertou

	print("\n")
	print_mem(oculta)
	print("\n")
	
	# ACERTOU? Conta o número de underlines
	la a0, oculta
	li a1, '_'
	jal conta_caracteres
	blt a0,s1,acertou  # se tem menos underlines agora do que antes, acertou
	pp(s0,-1)          # VIDAS--
	print("Errou - ")
	print(INT,s0)
	print("vidas restantes\n")
	bgtz s0, denovo   # VIDAS > 0
	print("Caixão e vela preta\nYouLose")
	Exit(2)
acertou:
	mv s1, a0         # atualiza nº de underlines
	beqz s1, exit     # if s1 == 0: jogo acabou
	j denovo
exit:
	print("Congratulations")
	Exit(0)

.include "./funcoes_forca.asm"
