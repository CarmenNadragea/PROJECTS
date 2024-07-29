
#ifndef Triangle_hpp
#define Triangle_hpp
#include <stdio.h>
#include "Point2D.h"
#include "Shape.hpp"

class Triangle : public Shape
{
public:
  Triangle();
  Triangle(char *, Point2D, Point2D, Point2D);
  Triangle(const Triangle &);

  void DisplayInfo() override;
  double GetArea();
  double GetPerimeter();
    ~Triangle();

private:
  Point2D point1;
  Point2D point2;
  Point2D point3;
  char *_name;
};

#endif
