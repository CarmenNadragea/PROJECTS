
#ifndef Shape_hpp
#define Shape_hpp
#include "Point2D.h"

// clasa de baza
class Shape
{
public:
    Shape();
    Shape(char *, Point2D);
    Shape(const Shape &);

    virtual void DisplayInfo();
    virtual double GetArea();      // calculeaza aria
    virtual double GetPerimeter(); // calculeaza perimteru
    virtual ~Shape();
    // virtual ~Shape();//virtual
private:
    char *_name;    // numele
    Point2D origin; // originea
};

#endif
