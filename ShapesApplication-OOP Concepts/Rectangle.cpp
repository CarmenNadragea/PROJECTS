#include "Point2D.h"
#include "Shape.hpp"
#include "Rectangle.hpp"
#include <iostream>
#include <math.h>
using namespace std;

Rectangle::Rectangle() : Shape(), other() {}

Rectangle::Rectangle(char *name, Point2D point1, Point2D other) : Shape(name, point1), other(other) {}

Rectangle::Rectangle(const Rectangle &r) : Shape(r._name, r.point1), other(r.other) {}

void Rectangle::DisplayInfo()
{
Shape:
    Shape::DisplayInfo();
    cout << "Celalalt punct este: (" << other.GetX() << "," << other.GetY() << ")" << endl;
}

double Rectangle::GetArea()
{
    double height = abs(other.GetY() - point1.GetY());
    double width = abs(other.GetX() - point1.GetX());

    return height * width;
}

double Rectangle::GetPerimeter()
{
    double height = abs(other.GetY() - point1.GetY());
    double width = abs(other.GetX() - point1.GetX());

    return 2 * (height + width);
}

Rectangle::~Rectangle(){
}

