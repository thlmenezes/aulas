def concat(s1,s2):
    '''
        Retorna a concatenação das duas listas
    '''
    # se s1 é vazia, é considerado False; logo not False == True
    if not s1:
        return s2
    else:
        return s1[0:1] + concat(s1[1:], s2)

def length(s1):
    if not s1:
        return 0
    else:
        return 1 + length(s1[1:])

def rev(s1):
    if not s1:
        return s1
    else:
        return rev(s1[1:]) + s1[0:1]

def prefix(s1,s2):
    #Documentação do help
    '''
        prefix(s1,s2) => bool
        
        Verifica se s1 é prefixo de s2
    '''
    ''' Comentário da Implementação

        Caso s1 := nil :
            Vazio é prefixo universal
        Senão:
            Caso s2 := a : s2' e a == b (sendo s1 := b : s1') :
                Verifica prefix(s1',s2') sendo a == b
            Caso contrário:
                return False
    
        # Por definição prefixo de nil é nil, ou seja,
        # s1 := a : s1' NÃO é prefixo de s2 := nil
    '''
    if not s1:
        return True
    else:
        if s2 and s1[0] == s2[0]:
            return prefix(s1[1:],s2[1:])
        else:
            return False
        











    
















    
