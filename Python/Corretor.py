def fail_message(case,output,expected):
    return "\
\n\t[TESTE FALHOU]\
\n\tEntrada  : {}\
\n\tSaída    : {}".format(repr(case),repr(output)) + \
("\n\tEsperava : {}".format(repr(expected)) if expected else '')

def runtests(regexp,tests,results=None):
    results = results or [None]*len(tests)
    from io import StringIO
    for case,expected in zip(tests,results):
        # Preparing Buffers:
        import sys
        # Input
        sys.stdin = StringIO(case)
        # Output
        output = StringIO()
        _backup,sys.stdout = sys.stdout, output
        del sys
        # Run code
        try:
            main()
        except NameError:
            raise NameError("\n\tFunção `main` não\
            encontrada:\n\t\tEscreveste o código no local\
            correto?\n\t\t`def main():\n\t\t\t# Escreva aqui a\
            solução`")
        # Collect output
        output = output.getvalue()
        # Reset standart output
        import sys
        sys.stdout = _backup
        del sys
        # Gives the user current Test output
        print('>>> Input:\n', case, sep='')
        print('>>> Output:')
        print(output,end="\n"*2)
        # Check if output is correct
        output = output.rstrip('\n') #Removing trailing \n
        from re import search as find
        if expected and expected != output or\
                not find(regexp.format(*case.split('\n')),output):
            raise ValueError(fail_message(case,output,expected))
        del find
