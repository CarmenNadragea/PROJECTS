#include "Point2D.h"
#include "Shape.hpp"
#include "Square.hpp"
#include <iostream>

using namespace std;

Square::Square() : Shape(), length() {}

Square::Square(char *name, Point2D origin, double length) : Shape(name, origin), length(length) {}

Square::Square(const Square &s) : Shape(s._name, s.origin), length(s.length) {}

void Square::DisplayInfo()
{
Shape:
    Shape::DisplayInfo();
    cout << "Lungimea unei laturi este de:" << length << endl;
}

double Square::GetArea()
{
    return length * length;
}

double Square::GetPerimeter()
{
    return 4 * length;
}

Square::~Square(){
    
}
