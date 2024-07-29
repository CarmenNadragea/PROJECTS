#include <iostream>
#include "Point2D.h"
#include "Shape.hpp"
#include "Circle.hpp"
#include "Line.hpp"
#include "Triangle.hpp"
#include "Square.hpp"
#include "Rectangle.hpp"
using namespace std;

void ProcessShape(Shape *obj)
{
    obj->DisplayInfo();
    //...altele
}

int main()
{
    Point2D p1(2, 3);
    Point2D p2(4, 5);
    Point2D p3(1, 0);
    // Shape s("Cerc", p1);
    /*Circle c("Circle",p1,2.14);
    Circle c2("Circle",p1, 3);
    Circle c3(c2);
    c3.DisplayInfo();
    cout<<endl;
    cout<<c3.GetPerimeter()<<endl;*/
    /*
    Line l("linie",p1,p2);
    l.DisplayInfo();
    cout<<l.GetPerimeter()<<endl;
    cout<<l.GetArea()<<endl;*/
    // s.DisplayInfo();
    /*
    Triangle t("Triunghi",p1,p2,p3);
    t.DisplayInfo();
    cout<<t.GetArea();
    cout<<t.GetPerimeter();
    */
    
    Square s("patrat",p1,3);
    s.DisplayInfo();
    cout<<s.GetArea()<<endl;
    cout<<s.GetPerimeter();
    
    Circle cerc2("Cerc", p1, 3);
    Circle cerc1(cerc2);

    /*
    Rectangle r("Dreptunghi", p1, p2);
    r.DisplayInfo();
    cout << r.GetArea() << endl;
    cout << r.GetPerimeter() << endl;*/
    return 0;
}
