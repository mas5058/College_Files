# Title: Lab01 Solution - Swap Numbers.
# CPET-321 Computational Problem Solving II Fall 2016
# Platform: Python 2.7 PyCharm
from decimal import Decimal

def main():
    x = Decimal(input("Enter 1st value\n"))
    xo = x
    y = Decimal(input("Enter 2nd value\n"))
    yo = y
    print ('Values before swapping are')
    print ("x:", x, "y:", y)

    # swapping using third variable
    print('Here is method using a third variable')
    temp = x
    x = y
    y = temp
    if((y == xo) and (x == yo)):
       print('Succuded at swap!')
    else:
       print('Failure! Check code.')
    print ('Values after swapping are')
    print ("x:", x, "y:", y)

    # the Pythonic way of doing the above operation is
    # x, y = y, x
    # print 'Values after swapping are'
    # print "x:", x, "y:", y

    # swapping without third variable
    #print('Here is method without a third variable')
    x = x + y
    #print('here is x after adding:' , x)
    y = x - y
    #print('here is y after subtracting:' , y)
    x = x - y
    #print('here is x after subtracting:' , x)
    if((y == (yo)) and ((x) == (xo))):
       print('Succuded at swap!')
    else:
       print('Failure! check code.')
    print ('Values after swapping are')
    print ("x:", x, "y:", y)
    
    # 1. Implement one more way without using third variable. XX
    # 2. Add code for swapping other numeric data types other than integers such as float, double.
    # 3. Add Error checking (try, catch and finally) XX
    # 4. Make the program read input from file and write output to file.

    #attempt at third way
    print('third way')
    x,y = y,x
    if(((y) == (xo)) and ((x) == (yo))):
       print('Succuded at swap!')
    else:
       print('Failure! check code.')
    print ('Values after swapping are')
    print ("x:", x, "y:", y)
    ans = input('would you like to read and write to a file? (type y or n)')
    if ans == y:
        readwrite()
    else:
        exit()
        
def readwrite():
    file = input('What file would you like to open?')
    swappyswap = list()
    for i in file.readlines():
        for number in line.split(','): 
            swappyswap.append(number)
    print(l)
    file.write(swappyswap[1:0])
    
    
    
    
    

if __name__ == '__main__':
    main()
