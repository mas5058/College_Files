import random
import timeit
from nt import lstat

def FindMax(lst):
    max = lst[0]
    for val in lst:
        if val > max:
            max = val
    return max

def FindMin(lst):
    min = lst[0]
    for val in lst:
        if val < min:
            min = val
    return min

def sort(lst):
    newlst = list()
    while len(lst) != 0:
        val = FindMin(lst)
        lst.remove(val)
        newlst.append(val)
    return newlst

def MeanVal(lst):
    sum = 0
    for val in lst:
        sum += val
    return (sum/len(lst))

def randomlcg(a,c,m,X):
    X=(a*X+c)%m
    return X

def pwr(val,exp):
        res = 1
        while exp != 0:
            #print('in loop:', res)
            res = res*val
            exp = exp - 1
        return res

def medianlst(lst):
    #assumes sorted list
    mdpt = len(lst)/2
    #print(mdpt)
    return lst[int(mdpt)]

def gen50ranlcg():
    lst = list()
    b = 0
    X = 1
    print('--------------------------------------------------------------------')
    TotTime = 0
    while b < 1000:
        startimelcg = timeit.default_timer()
        X = randomlcg(23,0,pwr(10,8)+1,X)
        elapsedlcg = (timeit.default_timer() - startimelcg)*1000
        TotTime += elapsedlcg
        lst.append(X%100)
        b+=1
    lst = sort(lst)
    print(lst)
    print('Avg Time: ', TotTime/1000)
    print ('Median: ', medianlst(lst))
    print('Max: ', FindMax(lst))
    print('Min: ', FindMin(lst))
    print('Mean: ', MeanVal(lst))
    print('--------------------------------------------------------------------')
    return lst
    
def main():
    n = 0
    print('Generating numbers using LCG...')
    masterlst = list()
    while n < 50:
        rez = gen50ranlcg()
        for val in rez:
            masterlst.append(val)
        n+=1
    print('Across all numbers:')
    print ('Median: ', medianlst(masterlst))
    print('Max: ', FindMax(masterlst))
    print('Min: ', FindMin(masterlst))
    print('Mean: ', MeanVal(masterlst))
    print('--------------------------------------------------------------------')
    print("Generating numbers using Python's class...")
    pyrandlst = list() 
    n = 0
    b = 0
    print('--------------------------------------------------------------------')
    while n < 50:
        TotTime = 0
        while b < 1000:
            startimepy = timeit.default_timer()
            val = random.randint(0,100)
            elapsedpy = (timeit.default_timer() - startimepy)*1000
            TotTime += elapsedpy
            pyrandlst.append(val)
            pyrandlst = sort(pyrandlst)
            b+=1
        print ('Median: ', medianlst(pyrandlst))
        print('Max: ', FindMax(pyrandlst))
        print('Min: ', FindMin(pyrandlst))
        print('Mean: ', MeanVal(pyrandlst))
        print('Avg Time: ', TotTime/1000)
        print('--------------------------------------------------------------------')
            
        n+=1
        
             
if __name__ == '__main__':
    main()
