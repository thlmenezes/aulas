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
# ============================================================
#                           MAIN
# ============================================================
.text
main:
	li a0, BMP_F0_BEGIN
	li a1, 0x55    # COR
	li a2, 40      # Comprimento
	li a3, 40      # Altura
	jal BMP_draw_square
	Exit()





