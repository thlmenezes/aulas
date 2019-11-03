def capitalizeOnly(texto):
    '''
        Recebe um texto e transforma para maiúscula
        a primeira letra após o ponto.
    '''
    resultante = ''
    passeiPorPonto = True # Sinaliza quando devemos capitalizar
    for letra in texto:
    '''-> Representando o operador `and`
        if passeiPorPonto:
            if letra != ' ':'''
        if passeiPorPonto and letra not in ' .':
            letra = letra.upper()
            passeiPorPonto = False
        elif letra == '.':
            passeiPorPonto = True
        resultante += letra
    return resultante

'''
1º partiocionar nos '.' a string -> substring
2º encontrar para cada elemento a primeira letra não nula -> index
3º resultante += '.' + substring[:index] + string[index].upper() + string[index:]
4º resultante[1:]

str.split
str.partition !
'''
