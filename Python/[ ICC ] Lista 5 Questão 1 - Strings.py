'''
    String -> str -> Fio/linha/sequência* de caracteres
    Strings são imutáveis
    [::] splice -> substring | subconjunto da string toda
    [] acessos posicionais
    len() -> |string|
    help(str.join)
'''

frase = input().split()
resultado = ''
for palavra in frase:
    resultado += palavra[2]

print(resultado) # pula uma linha
