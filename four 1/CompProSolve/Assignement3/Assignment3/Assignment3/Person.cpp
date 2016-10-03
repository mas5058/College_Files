//Person.cpp
#include "Person.h"


//Defines the getter and setter methods for the CPerson object
//This is what the person class does
CPerson::CPerson(void)
	: m_age(0)
{
}

CPerson::CPerson(string name, int age)
	:m_name(name),
	m_age(age)
{
}

CPerson::~CPerson(void)
{
}

double CPerson::getAge(void)
//gets age
{
	return m_age;
}

void CPerson::setAge(double age)
//sets the age to a number given
{
	m_age = age;
}

string& CPerson::Name(void)
//gets name
{
	return m_name;
}

//Outputs the pertinent fields of the CPerson in string format
string CPerson::ToString(void)
{
	stringstream result;
	result << "Name: " << left << setw(17) << m_name;
	result << "Age: " << m_age;
	return result.str();
}

//Reads and creates a CPerson object created by Save() in the expected syntax
//The device parameter is infile which tells it where to load from
void CPerson::Load(ifstream& device)
{
	if (!device.eof())
	{
		getline(device,m_name);	
	}
	if (!device.eof())
	{
		string age;
		getline(device,age);
		m_age = stoi(age);
	}
}

//Exports the CPerson
void CPerson::Save(ofstream& device)
{
	device << m_name << endl;
	device << m_age << endl;
}
