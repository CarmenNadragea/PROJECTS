#include <iostream>
#include "Point2D.h"
#include <math.h>

using namespace std;

Point2D::Point2D(int x, int y)
{
    _x=x;
    _y=y;
}

Point2D::Point2D(const Point2D& p)
{
    _x=p._x;
    _y=p._y;
}

int Point2D::GetX()
{
    return _x;
}

int Point2D::GetY()
{
    return _y;
}

void Point2D::SetX(int x)
{
    _x=x;
}

void Point2D::SetY(int y)
{
    _y=y;
}

double Point2D::DistanceTo(Point2D p)
{
    return sqrt(pow(p._x-_x, 2)+pow(p._y-_y, 2));
}
