
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
    virtual double GetArea();      
    virtual double GetPerimeter(); 
    virtual ~Shape();
    
private:
    char *_name;   
    Point2D origin; 
};

#endif
