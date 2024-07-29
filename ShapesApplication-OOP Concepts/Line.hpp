
#ifndef Line_hpp
#define Line_hpp
#include "Shape.hpp"
#include "Point2D.h"

class Line : public Shape
{
public:
    Line();
    Line(char *, Point2D, Point2D);
    Line(const Line &);

    // redefinire metode mostenite
    void DisplayInfo() override;
    double GetArea() override;      // calculeaza aria
    double GetPerimeter() override; // calculeaza perimteru
    ~Line();
    
private:
    Point2D other;
    char *_name;
    Point2D origin;
};

#endif
