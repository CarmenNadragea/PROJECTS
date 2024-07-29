
#ifndef Point2D_h
#define Point2D_h

// Point2D
class Point2D
{
public:
    Point2D(int = 0, int = 0);
    Point2D(const Point2D &);

    void SetX(int);
    void SetY(int);

    int GetX();
    int GetY();

    double DistanceTo(Point2D);

private:
    int _x;
    int _y;
};

#endif
