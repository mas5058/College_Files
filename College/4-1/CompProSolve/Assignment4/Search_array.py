# Title: Search.py 04 Solution - search operations
# CPET-321 Computational Problem Solving II Fall 2016
# Platform: Python 2.7 PyCharm


import timeit


def brute_force(arr, size, elem_2_find):
    for i in range(0, size):
        if arr[i] == elem_2_find:
            print ("found")
            return

    print ("Not found")

# Implement binary search approach and calculate the time
def binarySearch(alist, item):
    first = 0
    last = len(alist)-1
    found = False

    while first<=last and not found:
        midpoint = (first+last)//2
        if alist[midpoint]==item:
            found = True
        else:
            if item < alist[midpoint]:
                last = midpoint-1
            else:
                first = midpoint+1
    return found

def main():

    array_size = int(input("Enter array size\n"))
    arr = []

    while True:
        elem_2_find = int(input("Enter element < size to find\n"))
        if elem_2_find < array_size:
            break

    for i in range(0, array_size):
        arr.append(i)

    start_time_plus = timeit.default_timer()
    brute_force(arr, len(arr), elem_2_find)
    elapsed_plus = (timeit.default_timer() - start_time_plus)*1000
    print ("Time to search by using brute force approach", elapsed_plus)

    bintimestart = timeit.default_timer()
    binarySearch(arr, elem_2_find)
    elapsed_plus_bin = (timeit.default_timer() - bintimestart)*1000
    print ("Time to search by using binary search approach", elapsed_plus_bin)

if __name__ == '__main__':
    main()
