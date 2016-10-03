# TestFraction.py
# CPET-321 Computational Problem Solving II Fall 2016
# Title: Fraction Operations
# Platform: Python 2.7 PyCharm

from __future__ import print_function
from CFraction import CFraction
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

    print('file reading')
    tlist = x.read("testfile.txt")
    print('max fraction is', x.maxfrac(tlist).to_string())

# add methods for the following functionalities.
# 1. Rounding up a real number
# 2. Rounding down a real number
# 3. Calculating the integer power of a real number.
# 4. Create a list of fractions objects.
# 5. Read a file with fractions into list (each line has to have two integers, i.e. numerator & denominator)
# 6. Find the maximum fraction among the inputs read from the file.

if __name__ == '__main__':
    main()
