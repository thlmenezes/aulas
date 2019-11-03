filhos=int(input())
mensalidade=0
desconto = 0
for _ in range(filhos):
    periodo = int(input())
    custo   = 500 if periodo == 1 else 1000
    mensalidade += custo
    mensalidadeComDesconto += custo - desconto
    if desconto < 300:
        desconto += 100
    
print('{} {}'.format([mensalidade,mensalidadeComDesconto]))
#print('3500.00 2600.00')
