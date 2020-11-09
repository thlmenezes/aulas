# ============================================================
#                         CONSTANTES
# ============================================================
# Keyboard MMIO - Receiver Info
.eqv MMIO_add 0xff200004 # Data (ASCII value)
.eqv MMIO_set 0xff200000 # Control (Boolean)
# O bit de controle é automaticamente restaurado quando o
# programa lê os dados de MMIO_ADD usando a instrução 'lw'