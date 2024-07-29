
#include "Triangle.hpp"
#include "Shape.hpp"
#include "Point2D.h"
#include <iostream>

using namespace std;

Triangle::Triangle() : Shape(), point1(), point2(), point3() {}

Triangle::Triangle(char *name, Point2D point1, Point2D point2, Point2D point3) : Shape(name, point1), point1(point1), point2(point2), point3(point3) {}

Triangle::Triangle(const Triangle &t) : Shape(t._name, t.point1), point1(t.point1), point2(t.point2), point3(t.point3) {}

void Triangle::DisplayInfo()
{
    Shape::DisplayInfo();

    cout << "Punctul 2: (" << point2.GetX() << "," << point2.GetY() << ")" << endl;
    cout << "Punctul 3: (" << point3.GetX() << "," << point3.GetY() << ")" << endl;
}

double Triangle::GetArea()
{
    double a = point1.DistanceTo(point2);
    double b = point2.DistanceTo(point3);
    double c = point1.DistanceTo(point3);

    double s = (a + b + c) / 2.0;

    double area = sqrt(s * (s - a) * (s - b) * (s - c));

    return area;
}

double Triangle::GetPerimeter()
{
    double a = point1.DistanceTo(point2);
    double b = point2.DistanceTo(point3);
    double c = point1.DistanceTo(point3);

    return a + b + c;
}

Triangle::~Triangle()
{
    
}
