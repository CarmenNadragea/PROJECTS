
#ifndef Rectangle_hpp
#define Rectangle_hpp
#include "Point2D.h"
#include "Shape.hpp"

class Rectangle : public Shape
{
public:
    Rectangle();
    Rectangle(char *, Point2D, Point2D);
    Rectangle(const Rectangle &);

    void DisplayInfo() override;
    double GetArea() override;
    double GetPerimeter() override;
    ~Rectangle();

private:
    Point2D other;
    char *_name;
    Point2D point1;
};

#endif
