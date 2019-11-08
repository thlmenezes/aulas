def runtests(tests,regexp,results=None):
    '''
        Executa uma sequência de testes, comparando o
        resultado de acordo com uma expressão regular
        ou com uma sequência de outputs experados.
        
        Argumentos:
            testes:  Sequência de inputs de teste
            regexp:  Expressão regular para conferir resultado
            results: Sequência de outputs esperados, se informado
    '''
    results = results or [None]*len(tests)
    for case,expected in zip(tests,results):
        # Preparing Standard Buffers (Input & Output)
        # Modificando Buffers de Entrada e Saída
        from io import StringIO
        import sys
        sys.stdin, output = StringIO(case), StringIO()
        _backup, sys.stdout = sys.stdout, output
        del sys, StringIO
        # Run code
        # Executando código
        try:
            main()
        except NameError:
            raise NameError("\n\tFunção `main` não encontrada:\n" +\
            "\t\tEscreveste o código no local correto?\n" +\
            "\t\t`def main():\n" +\
            "\t\t\t# Escreva aqui a solução`")
        # Collect output state
        # Coletando Status Buffer Saída
        output = output.getvalue()
        # Reset standart output
        # Restaurando Buffer Saída
        import sys
        sys.stdout = _backup
        del sys
        # Prompt test status
        # Imprime o status do test
        print('>>> Input:\n', case, sep='')
        print('>>> Output:')
        print(output,end="\n"*2)
        # Validate output
        # Valida a saída
        output = output.rstrip('\n')
        # Remove trailing \n
        # Remove '\n's ao final da linha
        from re import search as find
        if expected and expected != output or not find(
           regexp.format(*case.split('\n')),output
        ):
            # Fail message template
            # Template de mensagem de falha
            fail_message = lambda case,output,expected : '''
    [TESTE FALHOU]
    Entrada  : {}
    Saída    : {}'''.format(repr(case),repr(output)) + ('''
    Esperava : {}'''.format(repr(expected)) if expected else '')
            raise ValueError(fail_message(case,output,expected))
        del find
