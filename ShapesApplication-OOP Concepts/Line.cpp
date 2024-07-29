#include "Shape.hpp"
#include "Point2D.h"
#include "Line.hpp"
#include <iostream>
#include <math.h>

using namespace std;

Line::Line() : Shape(), other() {}

Line::Line(char *name, Point2D origin, Point2D other) : Shape(name, origin), other(other) {}

Line::Line(const Line &l) : Shape(l), other(l.other) {}

void Line::DisplayInfo()
{
    Shape::DisplayInfo();
    cout << "Coordonatele celuilalt punct: (" << other.GetX() << "," << other.GetY() << ")" << endl;
}

double Line::GetArea()
{
    return 0;
}

double Line::GetPerimeter()
{
    return sqrt(pow(other.GetX() - origin.GetX(), 2) + pow(other.GetY() - origin.GetY(), 2));
}

Line::~Line()
{
    
}
