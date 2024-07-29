
#ifndef Circle_hpp
#define Circle_hpp
#include "Shape.hpp"
#include "Point2D.h"

class Circle : public Shape
{
public:
    Circle();
    Circle(char *, Point2D &, double);
    Circle(const Circle &);

    void DisplayInfo() override;
    double GetArea() override;
    double GetPerimeter() override;
    ~Circle();
private:
    double _radius;
    char *_name;
    Point2D origin;
};

#endif
