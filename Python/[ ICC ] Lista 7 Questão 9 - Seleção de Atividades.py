def time(texto:str):
    '''
        Converte representação HH:MM para um único inteiro
        em segundos
    '''
    index = texto.find(':')
    return int(texto[:index])*60+int(texto[index+1:])

# Recebemos todas as tarefas possíveis para o dia; e
tarefas = {}
for _ in range(int(input())):
    *nome,inicio,fim = input().split()
    tarefas[' '.join(nome)] = {'inicio':time(inicio),'fim':time(fim)}

inicial = sorted(tarefas,key=lambda chave: tarefas[chave]['fim'])
# Ordenamos as tarefas por seus horários de término.
if inicial:
    # O dia ideal começa com a tarefa que acaba mais cedo; e
    ideal   = [inicial[0]]
    last    = inicial[0]
    # para todas as atividades restantes:
    for atividade in inicial[1:]:
        # Avaliamos se a atividade começa depois da última ter terminado;
        if tarefas[atividade]['inicio'] >= tarefas[last]['fim']:
            # Caso aconteça: inserimos ao nosso dia ideal e
            ideal.append(atividade)
            last = atividade
            # atualizamos o nome da última atividade.
    print(len(ideal))
    print(*ideal,sep='\n')
else:
    print(0)
