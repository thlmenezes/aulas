# https://github.com/magmax/python-readchar
class _Getch:
    '''Captura um caractere do Input Padrão,
       sem ecoar na tela.
       NOTA: Gera interrupção da execução.
       NÃO FUNCIONA NO IDLE
    '''
    def __init__(self):
        import sys
        if sys.platform.startswith('linux'):
            def getch():
                import tty, sys, termios
                fd = sys.stdin.fileno()
                old_settings = termios.tcgetattr(fd)
                try:
                    tty.setraw(sys.stdin.fileno())
                    ch = sys.stdin.read(1)
                finally:
                    termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
                return ch
        elif sys.platform in ('win32', 'cygwin'):
            from msvcrt import getch
        else:
            raise TypeError('NotImplemented: The platform {} is not supported yet'.format(sys.platform))
        self.impl = getch

    def __call__(self): return self.impl()

class _Kbhit:
    '''True se o teclado foi clicado, Falso caso contrário.
       True if keyboard was hit, False otherwise.
       NÃO FUNCIONA NO IDLE
    '''
    def __init__(self):
        import sys
        if sys.platform.startswith('linux'):
            import termios, atexit
            fd = sys.stdin.fileno()
            # save the terminal settings
            old_settings = termios.tcgetattr(fd)
            # switch to normal terminal when finished
            atexit.register(lambda : termios.tcsetattr(fd, termios.TCSAFLUSH, old_settings))
            new_term  = termios.tcgetattr(fd)
            # new terminal setting unbuffered
            new_term[3] = (new_term[3] & ~termios.ICANON & ~termios.ECHO)
            # switch to unbuffered terminal
            termios.tcsetattr(fd, termios.TCSAFLUSH, new_term)
            def kbhit():
                import sys
                from select import select
                return select([sys.stdin], [], [], 0)[0] != []
        elif sys.platform in ('win32', 'cygwin'):
            from msvcrt import kbhit
        else:
            raise TypeError('NotImplemented: The platform {} is not supported yet'.format(sys.platform))
        self.impl = kbhit

    def __call__(self): return self.impl()

def clear():
    '''
        Limpa a tela do terminal
    '''
    import os
    os.system('cls' if os.name == 'nt' else 'clear')
    #print(chr(27) + '[2J')

class Up:
    '''
        Ajuda na limpeza da tela do IDLE
    '''
    def __init__(self, size = None):
        self.size = size or 21
    def __call__(self, size = 0):
        print('\n'*(size or self.size),end='')
    def __repr__(self):
        return '\n'*self.size

def getch():
    '''
        Captura um caractere do Input Padrão,
        NOTA: caso já exista buffer,
              não gera interrupção.
    '''
    import sys
    return sys.stdin.read(1)

up = Up()
inputchar = _Getch()
kbhit = _Kbhit()