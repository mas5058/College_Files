//CPET-231 Computational Problem Solving II
//Title: Enhanced Person Class Array
//Platform: win32 console Visual Studio 2015
#include <iostream>
#include <fstream>
#include "Person.h"

using namespace std;

int main()
{
	//Creates a CPerson object named person1, sets person1's age as 21,
	//sets person1's name as 'Joe Smith', prints out person1's 
	//stored name and age, and then exports person1 in string format
	CPerson person1;
	person1.setAge(21);
	person1.Name() = "Joe Smith";
	cout << "Name: " << person1.Name() << endl;
	cout << "Age: " << person1.getAge() << endl;
	cout << person1.ToString() << endl;


	//Uses a different CPerson constructor where name and age are
	//declared when person2 is instantiated
	CPerson person2("Mary Jones",19);
	cout << person2.ToString() << endl;

	//Creates an array of CPersons and fills them with the previously
	//created CPersons as well as a newly created CPerson
	//Then indirectly sets the third person's name by calling Name()
	//on thn third element of the array 
	const int NumberOfPeople = 3;
	CPerson persons[NumberOfPeople];
	persons[0] = person1;
	persons[1] = person2;
	persons[2].Name() = "Jeff Williams";
	persons[2].setAge(22);
	cout << endl;

	//Iterates through persons array, printing each one
	for (int i = 0; i < NumberOfPeople; i++)
	{
		cout << persons[i].ToString() << endl;
	}
	cout << endl;


	//Overwrites person2's age
	person2.setAge(20);
	cout << person2.ToString() << endl;
	cout << endl;

	//Iterates through persons array, printing each one
	for (int i = 0; i < NumberOfPeople; i++)
	{
		cout << persons[i].ToString() << endl;
	}
	cout << endl;

	//Outputs the persons array to a file using Save() with error handling
	ofstream outfile("NameList1.txt");
	//Error handling
	if (outfile.fail())
	{
		cout << "\nError:main():Failed to open file: \"NameList1.txt\"";
	}
	else
	{
		for (int i = 0; i < NumberOfPeople; i++)
		{
			persons[i].Save(outfile);
		}
		outfile.close();
	}

	//Tries to read in a file full of pre-written people using Load()
	CPerson list[500];
	int count = 0;
	ifstream infile("Namelist1.txt");
	//Error handling if file not found
	if (infile.fail())
	{
		cout << "\nError:main():Failed to open file \"Namelist1.txt\"" << endl;
	}
	else
	{
		//Read file until eof reached
		while(!infile.eof())
		{
			list[count++].Load(infile);
		}
		infile.close();

		for (int i = 0; i < count-1; i++)
		{
			cout << list[i].ToString() << endl;
		}
	}

	cout << endl;
	system("Pause");
	return 0;
}