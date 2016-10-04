//Person.h
#pragma once
#include <string>
#include <sstream>
#include <iomanip>
#include <fstream>
using namespace std;
//This is the 'bones of the class'
class CPerson
{
private:
	//Stores name and age
	double m_age;
	string m_name;
public:
	//creates methods for person
	CPerson(void);
	CPerson(string name, int age);
	~CPerson(void);
	double getAge(void);
	void setAge(double age);
	string& Name(void);
	string ToString(void);
	void Load(ifstream& device);
	void Save(ofstream& device);
};

