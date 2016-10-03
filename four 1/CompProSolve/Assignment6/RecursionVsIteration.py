# Title: RecursionVsIteration.py 04 Solution - Recursion vs Iteration comparison
# CPET-321 Computational Problem Solving II Fall 2016
# Platform: Python 2.7 PyCharm

import timeit
import inspect


bos = 0


def fib_it(n):
    global bos
    f_1 = 0
    f_2 = 1
    f_3 = 0

    for i in range(2, n+1):
        f_3 = f_1 + f_2
        f_1 = f_2
        f_2 = f_3
    bos += inspect.stack()[1][0].__sizeof__()
    return f_3


def fib_r(n):
    global bos
    bos += inspect.stack()[1][0].__sizeof__()
    if n < 2:
        return n
    return fib_r(n - 1) + fib_r(n - 2)


def fib_opt(n, f_1=0, f_2=1):
    global bos
    bos += inspect.stack()[1][0].__sizeof__()
    if n == 0:
        return f_1
    if n == 1:
        return f_2
    return fib_opt(n - 1, f_2, f_2 + f_1)


def main():
    global bos

    # increase the n value and test the program.
    # the program takes too long as the n value increases
    # comment the fib_r invocation block below and try increasing n values
    n = 15

    start_time_it = timeit.default_timer()
    tos = inspect.stack()[1][0].__sizeof__()
    print ("result:", fib_it(n))
    elapsed_it = (timeit.default_timer() - start_time_it)*1000
    print ("time:", elapsed_it)
    print ("memory:", bos - tos)
    bos = 0
    print ('-----------------------------------')

    start_time_r = timeit.default_timer()
    tos = inspect.stack()[1][0].__sizeof__()
    print ("result:", fib_r(n))
    elapsed_r = (timeit.default_timer() - start_time_r)*1000
    print ("time:", elapsed_r)
    print ("memory:", bos - tos)
    bos = 0
    print ('-----------------------------------')

    start_time_opt = timeit.default_timer()
    tos = inspect.stack()[1][0].__sizeof__()
    print ("result:", fib_opt(n))
    elapsed_opt = (timeit.default_timer() - start_time_opt)*1000
    print ("time:", elapsed_opt)
    print ("memory:", bos - tos)


if __name__ == '__main__':
    main()
