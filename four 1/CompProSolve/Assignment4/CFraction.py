from __future__ import print_function
import sys
#import decimal *
#import math *

class CFraction:
    m_numerator = 0
    m_denominator = 0

    def __init__(self, numerator=0, denominator=1):
        self.assign(numerator, denominator)

    def assign(self, numerator, denominator):
        #assigns a value to your numerator and denominator
        self.m_numerator = numerator
        if denominator != 0:
            self.m_denominator = denominator

            if numerator < 0 and denominator < 0:
                self.m_denominator = abs(denominator)
                self.m_numerator = abs(numerator)

            elif denominator < 0:
                self.m_denominator = -self.m_denominator
                self.m_numerator = -self.m_numerator

        else:
            print('Error: CFraction denominator must not be zero', file=sys.stderr)

    def to_double(self):
        #converts to double
        return float(self.m_numerator) / self.m_denominator

    def invert(self):
        self.m_numerator, self.m_denominator = self.m_denominator, self.m_numerator
        if self.m_denominator < 0:
            self.m_denominator = -self.m_denominator
            self.m_numerator = -self.m_numerator

    def to_string(self):
        #converts to string
        return "{0} / {1}\n".format(str(self.m_numerator), str(self.m_denominator))

    def simplify(self):
        d = self.__gcd(self.m_numerator, self.m_denominator)
        self.m_numerator /= d
        self.m_denominator /= d

    def __gcd(self, numerator, denominator):
        big = abs(numerator)
        small = abs(denominator)
        remainder = big % small
        while remainder != 0:
            big = small
            small = remainder
            remainder = big % small
        return small

        # different algorithm using recursion
        # def __gcd(self, numerator, denominator):
        #     if numerator == denominator:

    #     return numerator
    #     if numerator < denominator:
    #     return self.__gcd(denominator, numerator)
    #     return self.__gcd(denominator,numerator-denominator)

    # yet another recursion algorithm
    # def __gcd(self, numerator, denominator):
    #     if numerator % denominator == 0:
    #         return denominator
    #     return self.__gcd(denominator, numerator % denominator)

    def negate(self):
        #negates the number
        self.m_numerator = -self.m_numerator

    def __add__(self, rhs):
        result = CFraction()
        result.m_denominator = self.m_denominator * rhs.m_denominator
        result.m_numerator = self.m_numerator * rhs.m_denominator + \
                             rhs.m_numerator * self.m_denominator
        result.simplify()
        return result

    def __sub__(self, rhs):
        result = CFraction()
        result.m_denominator = self.m_denominator * rhs.m_denominator
        result.m_numerator = self.m_numerator * rhs.m_denominator - \
                             rhs.m_numerator * self.m_denominator

        result.simplify()
        return result

    def __mul__(self, rhs):
        result = CFraction()
        result.m_numerator = self.m_numerator * rhs.m_numerator
        result.m_denominator = self.m_denominator * rhs.m_denominator

        result.simplify()
        return result

    def __div__(self, rhs):
        result = CFraction()
        result.m_numerator = self.m_numerator * rhs.m_denominator
        result.m_denominator = self.m_denominator * rhs.m_numerator

        result.simplify()
        return result

    def to_fraction(self, value):
        self.m_numerator = int(value * 1000000)
        self.m_denominator = 1000000
        self.simplify()

    def rounding(self, direct):
        #make val decimal
        val = CFraction.to_double(self)
        #int (rez)
        if direct == 'up':
            rez = int(val) + 1
        elif direct == 'down':
            rez = int(val)
        else:
            rez = str('not valid direction')
        return rez

    def power(self,exp):
        res = 1
        frac = CFraction.to_double(self)
        while exp != 0:
            #print('in loop:', res)
            res = res*frac
            exp = exp - 1
        return res

    def read(self, filename):
        numbers = list()
        file = open(filename, 'r')
        for line in file:
            templine = line.split()
            numbers.append(CFraction(int(templine[0]),int(templine[1])))
        for fraction in numbers:
            print(fraction.to_string())
        file.close()
        return numbers

    def maxfrac(self,lst):
        maxf = CFraction()
        for frac in lst:
            if (frac.to_double() > maxf.to_double()):
                maxf = frac
        return maxf
            
if __name__ == '__main__':
    pass
