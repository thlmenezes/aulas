def IsPrimo(num):
    if num == 1: return False
    elif num == 2: return True
    a = 2
    while num%a!=0:
        a=a+1
    return a==num


n=int(input())

for m in range(1, n):
    if not IsPrimo(m*n + 1):
        print(m)
        break
