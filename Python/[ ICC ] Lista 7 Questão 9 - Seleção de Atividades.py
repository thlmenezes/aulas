def time(tempoEmTexto:str):
    '''
        Converte representação HH:MM
        para um único inteiro SS
    '''
    horas,minutos = tempoEmTexto.split(':')
    return int(horas)*60+int(minutos)

# Recebemos todas as tarefas possíveis para o dia; e
afazeres = {}
for _ in range(int(input())):
    *nome,inicio,fim = input().split()
    afazeres[' '.join(nome)] = \
    {'inicio':time(inicio),'fim':time(fim)}

diaIdeal= []## lista de atividades do dia
fimDia  = 0 ## horário de encerramento do dia
# Ordenamos as tarefas por seus horários de término.
for atividade in sorted(afazeres,\
                 key=lambda chave: tarefas[chave]['fim']):
    # Para toda atividade:
    #     Avaliamos se começa depois da última atividade
    #     do dia ter terminado;
    if tarefas[atividade]['inicio'] >= fimDia:
        # Caso aconteça:
        #     inserimos ao nosso dia ideal e
        diaIdeal.append(atividade)
        fimDia = afazeres[atividade]['fim']
        #     atualizamos o fim do dia.
print(len(diaIdeal),*diaIdeal,sep='\n')
