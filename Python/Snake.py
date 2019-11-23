'''
Modificações:

    ALTURA e LARGURA
    troca imprimir     para matriz_repr
    troca imprimirTela para geraTela
    def movimenta
    uso de lista de coordenadas
'''
""" COPY PASTE 14.11.19
def matriz_repr(matriz:list): return ''.join([ ''.join(linha)+'\n' for linha in matriz ])
def geraTela(tela:list):\
    return matriz_repr([list('.'+LARGURA*'_'+'.')] + \
                       [ ['|'] + linha + ['|'] for linha in tela] + \
                       [list('|'+LARGURA*'_'+'|')])

# Inicialização da tela e cobra
ALTURA = LARGURA = 10
tela = [  list(LARGURA*' ') for _ in range(ALTURA) ]
cobra = [(LARGURA//2,ALTURA//2)]
tela[ALTURA//2][LARGURA//2] = 'o'

# Menu inicial básico
input('Aperte Enter')

# Tela de jogo
print("Para sair pressione ESC",geraTela(tela),sep='\n',end='')

# Gameloop
from ioCustom import kbhit,getch,clear
# TODO: pygame
while True:
    clear()
    if kbhit():
        move = getch()
        cobra_x,cobra_y = cobra[-1]
        if move.lower() == 'w':
            cobra_y -= 1
    print("Para sair pressione ESC",geraTela(tela),sep='\n',end='')
"""
ALTURA = LARGURA = 10
tela = [  list(LARGURA*' ') for _ in range(ALTURA) ]
# Matriz tela
# NOTE: Resolução será 320*240
# Ficou confuso como criei essa lista?
#     Observe os próximos comentários
def matriz_repr(matriz:list): return ''.join([ ''.join(linha)+'\n' for linha in matriz ])
''' matriz_repr -> Gera uma representação de uma matriz qualquer '''
'''
[DEPRECATED] imprimir
imprimir = lambda tela : print( *[ ''.join(linha)+'\n' for linha in tela ], sep='',end='')

Definindo uma função em uma única linha,
utilizando definição anônima de função;
equivalente à:

def imprimir(tela):
    for linha in tela:
        print( ''.join(linha) )

Observações:
    -> lambda
        Definir funções sem dar nomes,
        chamamos assim porque foi criado com base no cálculo lambda
        leia sobre em https://pt.wikipedia.org/wiki/Cálculo_lambda
        saiba mais em https://docs.python.org/3/reference/expressions.html#lambda
    -> *
        Operador de conjuntos iteráveis ();
        comportamento semelhante à "extrair aqui"
        de arquivos compactados (.zip,.rar,...)
        saiba mais em https://docs.python.org/3/reference/expressions.html#expression-lists
    -> [ _ for linha in tela]
        Comportamento semelhante à iterar em uma lista;
        entretanto estamos gerando uma nova lista com o
        resultado das operações realizadas ali
        saiba mais em https://docs.python.org/3/tutorial/datastructures.html#list-comprehensions
    -> S.join(conjuntoIterável)
        Une todas as strings do conjuntoIterável utilizando
        como separador a string S
        saiba mais em https://docs.python.org/3/library/stdtypes.html#str.join
    -> '\n'
        Caractere Nova Linha (Newline), responsável por "descer uma linha"
        leia sobre em https://pt.wikipedia.org/wiki/Nova_linha
'''
cobra = [(LARGURA//2,ALTURA//2)]
tela[ALTURA//2][LARGURA//2] = 'o'
'''
A cobrinha será representando como um
encadeamento de suas "partes", conforme
ela cresce ela vai ocupando mais espaço
na tela; armazenamos uma lista de todos
os pontos, com as coordenadas X e Y, que
ela ocupa na tela

A cobrinha tem, no inicio, um corpo de
tamanho 1 no canto superior esquerdo
da tela, representado por 'o'

Falando um pouco mais sobre sintaxe:

tela[0] corresponde à primeira linha da tela
que por sua vez é uma lista, portanto permite
acesso posicional usando []; logo tela[0][0]
representa o 1º elemento da 1ª linha.
tela[ALTURA//2][LARGURA//2] é +- meio da tela.
'''
input('Aperte Enter')
# Menu inicial básico
def geraTela(tela:list):\
    return matriz_repr([list('.'+LARGURA*'_'+'.')] + \
                       [ ['|'] + linha + ['|'] for linha in tela] + \
                       [list('|'+LARGURA*'_'+'|')])
print("Para sair pressione ESC",geraTela(tela),sep='\n',end='')
# Imprime o estado do jogo
def movimenta(matriz: list, atual: tuple, nova: tuple):\
    matriz[atual[1]][atual[0]],matriz[nova[1]][nova[0]] = ' ','o'
# Apaga de uma posição e imprime em outra
from ioCustom import kbhit,getch,clear
while True:
    clear()
    if kbhit():
        move = getch()
        cobra_x,cobra_y = cobra[-1]
        # Movimentação será usando WASD
        if move.lower()=="w":
            cobra_y -= 0 if cobra_y - 1 < 0         else 1
        elif move.lower()=="s":
            cobra_y += 0 if cobra_y + 1 > ALTURA-1  else 1
        elif move.lower()=="a":
            cobra_x -= 0 if cobra_x - 1 < 0         else 1
        elif move.lower()=="d":
            cobra_x += 0 if cobra_x + 1 > LARGURA-1 else 1
        elif move == chr(27):# == '\x1b' == escape
            break
        # mover em tela de ATUAL para NOVA
        movimenta(tela,cobra[-1],(cobra_x,cobra_y))
        cobra.pop()
        cobra.append((cobra_x,cobra_y))
    print("Para sair pressione ESC",geraTela(tela),sep='\n',end='')
'''
TODOs:
- Movimentação
- Cobrinha morre se tentar sair da tela
'''
