from array import array
size = 4

def check(row,col, A):
    if col<0:
        #print(row)
        print(row,col)
        if row < 0:
            #print('true')
            return True
        else:
            print('reseting')
            row-=1
            col=size
            return check(row,col,A)
    elif A[row-1][col-1]==A[col-1][row-1]:
        #print(col)
        return check(row,col-1, A)
    else:
        #print('false')
        return False
    

def main():
    w, h = 4,4 
    lst = [[0 for x in range(w)] for y in range(h)]
    col,row = 0,0
    i = 0
    q = 32
    while(col < 2):
        while (row < 2):
            while i <= 3:
                lst[row][col] = i
                lst[col][row] = q
                col+=1
                row+=1
                i+=1
##                print('row is ', row)
##                print('col is ', col)
    col, row = 4,4
    lst2=[[1, 2, 3, 4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]
    print(lst)
    print(check(row, col,lst))
    print('fail check: ', check(row,col,lst2))
    #val = bool()
    #print(rez)
##    if rez == 1:
##        val = True
##    elif rez == 0:
##        val = False
    #print(val)
    #print('made it!')
    
if __name__ == '__main__':
    main()

    
