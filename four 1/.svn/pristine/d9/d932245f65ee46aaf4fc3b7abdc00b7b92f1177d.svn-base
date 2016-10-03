//Title: Lab02 Solution - Fraction Operations.  
//CPET-321 Computational Problem Solving II Fall 2016
//Platform: C++ Win32 Console Visual Studio

#include <iostream>
#include <string>
#define _USE_MATH_DEFINES
#include <math.h>
#include <chrono>

using namespace std;
using namespace std::chrono;

void printAsFraction(int numerator, int denominator) {
	cout << numerator << "/" << denominator << endl;
}

void printAsDecimal(int numerator, int denominator) {
	cout << (numerator / (float)denominator) << endl;
}

string convertFractionToRational(double fraction) {
	int newNumerator = 1;
	int oldNumerator = 0;
	int newDenominator = 0;
	int oldDenominator = 1;
	double inverseFractionResult = fraction;
	double precision = 0.000001;
	
	do {
		int integralPart = floor(inverseFractionResult);
		int aux = newNumerator;
		newNumerator = integralPart * newNumerator + oldNumerator;
		oldNumerator = aux;
		aux = newDenominator;
		newDenominator = integralPart * newDenominator + oldDenominator;
		oldDenominator = aux;
		if (inverseFractionResult != integralPart) {
			inverseFractionResult = 1 / (inverseFractionResult - integralPart);
		}		
	} while (abs(fraction - double(newNumerator) / newDenominator) > fraction * precision);
	
	return to_string(newNumerator) + "/" + to_string(newDenominator);
}

void addIntegers() {
	int intSum = 0;
	int i = 0;
	while (i <= 10000000) {
		intSum += i*i;
		++i;
	}
}

void addFloat() {
	float floatSum = 0.0;
	float i = 0.0;
	while (i <= 10000000.0) {
		floatSum += i*i;
		++i;
	}
}

void floatComparison() {
	float x = 3.3;
	float y = 2.0;
	float xy = x * y;
	cout << "x * y = " << xy << endl;
	float p = 2.2;
	float q = 3.0;
	float pq = p * q;
	cout<< "p * q = " << pq << endl;

	if (xy == pq) {
		cout << "x * y and p * q are equal" << endl;
	}
	else {
		cout << "x * y and p * q are not equal" << endl;
	}
}

/*add methods for the following functionalities.
1. Rounding up a real number
2. Rounding down a real number
3. Calculating the integer power of a real number.*/


int main(int argc, char** argv) {
	int m_numerator = 0;
	int m_denominator = 0;
	cout << "Enter numerator value" << endl;
	cin >> m_numerator;
	
	while (!m_denominator) {
		cout << "Enter denominator value other than zero" << endl;
		cin >> m_denominator;
	}

	cout << "Fraction is " << endl;
	printAsFraction(m_numerator, m_denominator);

	cout << "Decimal value is " << endl;
	printAsDecimal(m_numerator, m_denominator);

	cout << "Convert Fraction to rational" <<endl<<convertFractionToRational(1.5)<<endl;
	double x = M_PI;
	cout << "Convert Fraction to rational" << endl << convertFractionToRational(x) << endl;

	high_resolution_clock::time_point startInt = high_resolution_clock::now();
	addIntegers();
	high_resolution_clock::time_point endInt = high_resolution_clock::now();
	auto durationInt = duration_cast<microseconds>(endInt - startInt).count();
	cout << "Integer Addition Operation took " << durationInt << endl;

	high_resolution_clock::time_point startFloat = high_resolution_clock::now();
	addFloat();
	high_resolution_clock::time_point endFloat = high_resolution_clock::now();
	auto durationFloat = duration_cast<microseconds>(endFloat - startFloat).count();
	cout << "Float Addition Operation took " << durationFloat << endl;

	floatComparison();

	system("pause");

}