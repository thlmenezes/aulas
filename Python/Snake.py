tela = [  list(10*' ') for _ in range(10) ]
# Matriz tela
# NOTE: Resolução será 320*240
# Ficou confuso como criei essa lista?
#     Observe o próximo comentário

imprimir = lambda tela : print( *[ ''.join(linha)+'\n' for linha in tela ], sep='',end='')
'''
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
cobra_x = cobra_y = 0
tela[cobra_x][cobra_y] = "o"
'''
A cobrinha tem, no inicio, um corpo de
tamanho 1 no canto superior esquerdo
da tela, representado por 'o'

Falando um pouco mais sobre sintaxe:

tela[0] corresponde à primeira linha da tela
que por sua vez é uma lista, portanto permite
acesso posicional usando []; logo tela[0][0]
representa o 1º elemento da 1ª linha.
'''

input('Aperte Enter')
# Menu inicial básico

imprimirTela = lambda tela : imprimir([list('.'+10*'_'+'.')] + [ ['|'] + linha + ['|'] for linha in tela] + [list('|'+10*'_'+'|')])
imprimirTela(tela)
# Imprime o estado do jogo

move = input()
# Movimentação será usando WASD
if move.lower()=="w":
    cobra_y -= 1

cobra = [(0,0)]
'''
A cobrinha será representando como um
encadeamento de suas "partes", conforme
ela cresce ela vai ocupando mais espaço
na tela; armazenamos uma lista de todos
os pontos, com as coordenadas X e Y, que
ela ocupa na tela
'''

'''
TODOs:
- Movimentação
- Cobrinha morre se tentar sair da tela
'''
