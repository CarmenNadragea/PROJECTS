#include <iostream>
#include <cstring>
#include "Point2D.h"
#include "Shape.hpp"
#include "Line.hpp"
using namespace std;

Shape::Shape()
{
    _name = nullptr;
    origin.SetX(0);
    origin.SetY(0);
}

Shape::Shape(char *name, Point2D p)
{
    _name = new char[strlen(name) + 1];
    strcpy(_name, name);

    origin.SetX(p.GetX());
    origin.SetY(p.GetY());
}

Shape::Shape(const Shape &s)
{
    _name = new char[strlen(s._name) + 1];
    strcpy(_name, s._name);

    origin = s.origin;
}

void Shape::DisplayInfo()
{
    if (_name != 0)
        cout << "Numele figurei:" << _name << endl;
    else
        cout << "Nicio figura atribuita";

    cout << "Un punct al figurei: (" << origin.GetX() << "," << origin.GetY() << ")" << endl;
}

double Shape::GetArea()
{
    return 0;
}

double Shape::GetPerimeter()
{
    return 0;
}

Shape::~Shape()
{
    delete[] _name; // Eliberarea memoriei pentru nume
}
