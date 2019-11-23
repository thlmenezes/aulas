gatilhos = {}

for _ in range(int(input())):
    palavra_gatilho,comportamento = input().split()
    gatilhos[palavra_gatilho] = comportamento

comportamento_resultado = []
for palavra in input().split():
    personalidade = gatilhos.get(palavra)
    comportamento_resultado += [personalidade] if personalidade else []

comportamento_resultado = ' '.join(comportamento_resultado)

print('Tudo Bem!' if not comportamento_resultado else\
      comportamento_resultado)
