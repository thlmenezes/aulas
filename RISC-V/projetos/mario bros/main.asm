##############################################################
# - [x] Puxar cenário de arquivo
# - [ ] Goomba
#     - [ ] Goomba anda
#     - [ ] Goomba mata player: Troca cor do player
#     - [ ] Matar Goomba: Some
#     - [ ] Morre ao sair da tela
# - [ ] Player
#     - [ ] Anda
#     - [ ] Pula
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
#                           MAIN
# ============================================================
.text
main:
	# Abrir Arquivo
	FILE_OPEN(FILE.READ,"./mario bros/assets/original/menu.bin")
	bltz a0, exit  # if a0 < 0 -> ERROR
	mv s0, a0      # backup do file descriptor
	
	# Ler Arquivo
	FILE_READ(s0,BMP_F0_BEGIN,0x12C00) # 320x240
	syscall(INT)  # print int -> nº de leituras bem sucedidas
	
	# Fecha o arquivo
	FILE_CLOSE(s0)
exit:	syscall(EXIT2)