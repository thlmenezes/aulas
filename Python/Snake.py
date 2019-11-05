tela = [  list(10*' ') for _ in range(10) ]
imprimir = lambda tela : print(*[''.join(linha)+'\n' for linha in tela])
#imprimir(tela)
tela[0][0]="o"
from msvcrt import getwche
#print('Aperte Enter')
a = getwche()
imprimir(tela)
move=str(input())
cobra = [(0,0)]
