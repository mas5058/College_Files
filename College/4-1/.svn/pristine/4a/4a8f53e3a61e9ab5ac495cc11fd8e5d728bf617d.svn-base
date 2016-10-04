# TestFraction.py
# CPET-321 Computational Problem Solving II Fall 2016
# Title: Fraction Operations
# Platform: Python 2.7 PyCharm

from __future__ import print_function
from CFraction import CFraction
import timeit

#from decimal import Decimal


def main():
    x = CFraction(1,2)
    print('Regular assignment test:')
    print('\tx = ', x.to_string())

    print('Invalid assignment test:')
    x.assign(1,0)

    print('Negative value assignment test:')
    x.assign(1,-2)
    print('\tx = ', x.to_string())

    print('Convert to decimal test:')
    print('\tx = ', x.to_double())

    print('Inversion test:')
    x.invert()
    print('\tx = ', x.to_string())

    x.negate()

    print('Addition test:')
    y = CFraction(10, 3)
    print('\tx = ', x.to_string())
    print('\ty = ', y.to_string())
    z = x + y
    print('\tx + y = ', z.to_string())

    print('Subtraction test:')
    print('\tx = ', x.to_string())
    print('\ty = ', y.to_string())
    z = x - y
    print('\tx - y = ', z.to_string())

    print('Multiplication test:')
    print('\tx = ', x.to_string())
    print('\ty = ', y.to_string())
    z = x * y;
    print('\tx * y = ', z.to_string())

    print('Division test:')
    print('\tx = ', x.to_string())
    print('\ty = ', y.to_string())
    z = x.to_double() / y.to_double();
    print('\tx / y = ', str(z))

    print('Simplification test:')
    x.assign(8,10)
    print('\tx = ', x.to_string())
    x.simplify()
    print('\t->', x.to_string())

    print('GCD test:')
    print('\tUndoable because gcd() was declared as private')

    print('Negation test:')
    print('\tx = ', x.to_string())
    x.negate()
    print('\tx = ', x.to_string())

    print('Decimal to fraction conversion test:')
    x.to_fraction(0.2)
    print('\t0.2 = ', x.to_string())

    print('rounding up')
    print('x: ', x.rounding('up'))
    print('y: ', y.rounding('up'))
    print('rounding down')
    print('x: ', x.rounding('down'))
    print('y: ', y.rounding('down'))
    
    intpow = float(input('What value would you like to use to test power? :'))
    
    print('x power test:', x.power(intpow))
    print('y power test:', y.power(intpow))
##
##    print('file reading')
##    tlist = x.read("testfile.txt")
##    print('max fraction is', x.maxfrac(tlist).to_string())

#for assignment 4, just make up numbers for int reals and all that and just time them
    #all out down here

    start = timeit.default_timer()
    a = 3.5525252
    b = 2.24601

    plusfloat = timeit.default_timer()
    i = 1
    while i <= 100:
        c = a + b
        i += 1
    
    elapsedplusfloat = ((timeit.default_timer() - plusfloat)*1000)/100
    #print('result: ', c)
    print('avearge time to add float: ', elapsedplusfloat)
       
    i = 1
    c = 2
    d = 3
    plusint = timeit.default_timer()
    while i <= 100:
        e = a + b
        i += 1
    elapsedplusint = ((timeit.default_timer() - plusint)*1000)/100
    #print('result: ', c)
    print('average time to add int: ', elapsedplusint)
    i = 1
    #print('adding fractions')
    plusfrac = timeit.default_timer()
    while i <= 100:
        z = x + y
        i+=1
    elapsedplusfrac = (timeit.default_timer() - plusfrac)*1000
    #print('result: ', z.to_string())
    print('average time to add fractions: ', elapsedplusfrac/100)

    multifloat = timeit.default_timer()
    i = 1
    while i <= 100:
        c = a * b
        i += 1
    elapsedmultifloat = ((timeit.default_timer() - multifloat)*1000)/100
    print('avearge time to multiply float: ', elapsedmultifloat)

    i = 1
    c = 2
    d = 3
    mutliint = timeit.default_timer()
    while i <= 100:
        e = c * d
        i += 1
    elapsedmultyint = ((timeit.default_timer() -  mutliint)*1000)/100
    #print('result: ', c)
    print('average time to multiply int: ', elapsedmultyint)

    multifrac = timeit.default_timer()
    while i <= 100:
        z = x * y
        i+=1
    elapsedmultifrac = (timeit.default_timer() - multifrac)*1000
    #print('result: ', z.to_string())
    print('average time to multiply fractions: ', elapsedmultifrac/100)
    
    subfloat = timeit.default_timer()
    i = 1
    while i <= 100:
        c = a - b
        i += 1
    
    elapsedsubfloat = ((timeit.default_timer() - subfloat)*1000)/100
    #print('result: ', c)
    print('avearge time to subtract float: ', elapsedsubfloat)
    
    subint = timeit.default_timer()
    i = 1
    while i <= 100:
        e = c - d
        i += 1
    
    elapsedsubint = ((timeit.default_timer() - subint)*1000)/100
    #print('result: ', c)
    print('avearge time to subtract int: ', elapsedsubint)

    subfrac = timeit.default_timer()
    while i <= 100:
        z = x - y
        i+=1
    elapsedsubfrac = (timeit.default_timer() - subfrac)*1000
    #print('result: ', z.to_string())
    print('average time to subtract fractions: ', elapsedsubfrac/100)

    divfloat = timeit.default_timer()
    i = 1
    while i <= 100:
        c = a/b
        i += 1
    elapseddivfloat = ((timeit.default_timer() - divfloat)*1000)/100
    #print('result: ', c)
    print('avearge time to divide float: ', elapseddivfloat)
    
    divint = timeit.default_timer()
    i = 1
    while i <= 100:
        e = c / d
        i += 1
    
    elapseddivint = ((timeit.default_timer() - divint)*1000)/100
    #print('result: ', c)
    print('avearge time to divide int: ', elapseddivint)

    divfrac = timeit.default_timer()
    i = 1
    while i <= 100:
        z = x.to_double() / y.to_double();
        i += 1
    
    elapseddivfrac = ((timeit.default_timer() - divfrac)*1000)/100
    #print('result: ', c)
    print('avearge time to divide fraction: ', elapseddivfrac)
    
# add methods for the following functionalities.
# 1. Rounding up a real number
# 2. Rounding down a real number
# 3. Calculating the integer power of a real number.
# 4. Create a list of fractions objects.
# 5. Read a file with fractions into list (each line has to have two integers, i.e. numerator & denominator)
# 6. Find the maximum fraction among the inputs read from the file.

if __name__ == '__main__':
    main()
