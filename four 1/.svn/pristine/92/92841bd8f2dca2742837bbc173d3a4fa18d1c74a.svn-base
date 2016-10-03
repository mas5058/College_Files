# TestPerson.py
# CPET-321 Computational Problem Solving II Fall 2016
# Title: Array of Objects
# Platform: Python 2.7 PyCharm

from __future__ import print_function
from CPerson import CPerson


def main():
    # Creates a CPerson object named person1, sets person1's age as 21,
    # sets person1's name as 'Joe Smith', prints out person1's
    # stored name and age, and then exports person1 in string format
    person_1 = CPerson()
    person_1.set_age(age=21)
    person_1.set_name("Joe Smith")  # Python has no reference variables as in C++
    print("Name: ", person_1.get_name())
    print("Age: ", person_1.get_age())
    print(person_1.to_string())

    person_2 = CPerson("Mary Jones", 19)
    print(person_2.to_string())
    print()

    # Creates an array of CPersons and fills them with the previously
    # created CPersons as well as a newly created CPerson
    # Then directly sets the third person's name by creating an object
    # on the third element of the list
    # This implementation is different from C++ as Python does not support
    # reference objects
    persons = [person_1, person_2, CPerson("Jeff Williams", 22)]
    # Iterates through persons array, printing each one
    for person in persons:
        print(person.to_string())
    print()

    # Overwrites person2's age
    person_2.set_age(20)
    print(person_2.to_string())
    print()

    # Iterates through persons array, printing each one
    for person in persons:
        print(person.to_string())
    print()

    # Outputs the persons array to a file using Save() with error handling
    file_name = "NameList1.txt"
    try:
        with open(file_name, "wb") as fw:
            for person in persons:
                person.save_object(fw)
    except:
        print("\nError:main():Failed to open file: \'NameList1.txt\'")
    finally:
        fw.close()

    persons = [CPerson(x) for x in range(501)]
    line = 0
    try:
        with open(file_name, "rb") as fr:
            for data in fr:
                persons[line].load_object(data)
                line += 1
    except:
        print("\nError:main():Failed to open file \"Namelist1.txt\"")
    finally:
        fr.close()

    for i in range(0, line):
        print(persons[i].to_string())


if __name__ == '__main__':
    main()
