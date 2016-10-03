// Title: Lab01 Solution - Swap Numbers.  
// CPET-321 Computational Problem Solving II Fall 2016
// Platform: C++ Win32 Console Visual Studio
#include <iostream>
#include <string>

using namespace std;

/* Different ways of defining main function
 1. int main()
 2. int main(int argc, char* argv[])
 3. int main(int argc, char** argv)
 */

int main(int argc, char** argv) {
	int x;
	int y;
	cout << "Enter 1st value" << endl;
	cin >> x;
	cout << "Enter 2nd value" << endl;
	cin >> y;
	cout << "Values before swapping are" << endl;
	cout << "x: " << x << " y: " << y << endl;

	// swapping using third variable
	int temp = x;
	x = y;
	y = temp;
	cout << "Values after swapping are" << endl;
	cout << "x: " << x << " y: " << y << endl;

	// swapping without third variable
	x = x + y;
	y = x - y;
	x = x - y;
	cout << "Values after swapping are" << endl;
	cout << "x: " << x << " y: " << y << endl;

	// 1. Implement one more way without using third variable.
	// 2. Add code for swapping other numeric data types other than integers such as float, double.
	// 3. Add Error checking (try, catch and finally)
	// 4. Make the program read input from file and write output to file.
	system("pause");
}