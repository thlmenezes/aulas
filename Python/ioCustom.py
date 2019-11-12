# https://github.com/magmax/python-readchar
class _Getch:
    '''Gets a single character from standard input.
       Does not echo to the screen.
       DOESN'T WORK IN IDLE
    '''
    def __init__(self):
        import sys
        if sys.platform.startswith('linux'):
            self.impl = _GetchUnix()
        elif sys.platform in ('win32', 'cygwin'):
            self.impl = _GetchWindows()
        else:
            raise NotImplemented('The platform {} is not supported yet'.format(sys.platform))
        del sys

    def __call__(self): return self.impl()

class _GetchUnix:
    def __init__(self): return

    def __call__(self):
        import tty, sys, termios
        fd = sys.stdin.fileno()
        old_settings = termios.tcgetattr(fd)
        try:
            tty.setraw(sys.stdin.fileno())
            ch = sys.stdin.read(1)
        finally:
            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
        return ch


class _GetchWindows:
    def __init__(self): return

    def __call__(self):
        import msvcrt
        return msvcrt.getch()


inputchar = _Getch()
