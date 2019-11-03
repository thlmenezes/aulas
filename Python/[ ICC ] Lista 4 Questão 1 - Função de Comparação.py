def compare(a,b):
    '''
    Recebe dois valores e retorna:
        1  -> a > b
        0  -> iguais
        -1 -> a < b
    '''
    if a > b:
        return 1
    elif a == b:
        return 0
    return -1

# Receber dois números
primeiro,segundo = int(input()),int(input())
resultado = compare(primeiro,segundo)

if resultado == 1:
    print('x e maior que y')
elif resultado == 0:
    print('x e igual a y')
else:
    print('x e menor que y')



