import timeit
#import inspect
import sys
sys.setrecursionlimit(1500)

def iteration(n):
    #counts hands using iteration
    handcount = 0
    while n > 0:
        if n%2 == 1:
            handcount += 3
        elif n%2 == 0:
            handcount += 4
        n -= 1
    return handcount

def recursion(n,handcount):
    #counts hands using recursion
    if n%2 == 1:
        handcount += 3
    elif n%2 == 0:
        if n != 0:
            handcount += 4
    if n != 0:
        handcount = recursion(n-1,handcount)
    return handcount

#add results
def main():
    print('-----------------------------------')
    n = 100
    it_time1= timeit.default_timer()
    print('result for 100: ',iteration(n))
    elapsed_it1 = (timeit.default_timer()-it_time1)*1000
    print('Iteration time for 100: ', elapsed_it1)
    n = 1000
    it_time2= timeit.default_timer()
    print('result for 1000: ',iteration(n))
    elapsed_it2 = (timeit.default_timer()-it_time2)*1000
    print('Iteration time for 1000: ', elapsed_it2)
    print('-----------------------------------')
    n = 100
    re_time1= timeit.default_timer()
    print('result for 100: ', recursion(n,0))
    elapsed_re1 = (timeit.default_timer()-re_time1)*1000
    print('Recursion time for 100: ', elapsed_re1)
    n = 1000
    re_time2= timeit.default_timer()
    print('result for 1000: ', recursion(n,0))
    elapsed_re2 = (timeit.default_timer()-re_time2)*1000
    print('Recursion time for 1000: ', elapsed_re2)
    print('-----------------------------------')
    
if __name__ == '__main__':
    main()
