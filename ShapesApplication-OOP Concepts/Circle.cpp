#include <iostream>
#include "Circle.hpp"
#include "Shape.hpp"
#include <cmath>
using namespace std;

Circle::Circle() : Shape()
{
    _radius = 0;
}

Circle::Circle(char *name, Point2D &origin, double radius) : Shape(name, origin)
{
    _radius = radius;
}

Circle::Circle(const Circle &c) : Shape(c)
{
    _radius = c._radius;
}

void Circle::DisplayInfo()
{
    Shape::DisplayInfo();
    cout << "Radius:" << _radius;
}

double Circle::GetArea()
{
    return M_PI * _radius * _radius;
}

double Circle::GetPerimeter()
{
    return 2 * M_PI * _radius;
}

Circle::~Circle(){
    
}
