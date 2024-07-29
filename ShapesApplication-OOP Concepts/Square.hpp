
#ifndef Square_hpp
#define Square_hpp
#include "Point2D.h"
#include "Shape.hpp"

class Square : public Shape
{
public:
    Square();
    Square(char *, Point2D, double);
    Square(const Square &);

    void DisplayInfo() override;
    double GetArea() override;
    double GetPerimeter() override;
    ~Square();

private:
    char *_name;
    Point2D origin;
    double length;
};

#endif
