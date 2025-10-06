#include <iostream>
#include <cmath>
class Point2d {
    double m_x;
    double m_y;
    public:
        void print() {
            std::cout << "(" << m_x << "," << m_y << ") \n";
        }
        int distanceTo(Point2d other) {
            return std::sqrt(std::pow(m_x - other.getX(), 2) + std::pow(m_y - other.getY(),2));
        }
        int getX() {
            return m_x;
        }
        int getY() {
            return m_y;
        }
    Point2d() {
        m_x = 0;
        m_y = 0;
    }
    Point2d(double m_x, double m_y) {
        this->m_x = m_x;
        this->m_y = m_y;
    }
};



class Fraction
{
    int numerator{ 0 };
    int denominator{ 1 };
    public: 

        Fraction(int numer, int denom) {
            numerator = numer;
            denom = denom;
        }
        Fraction() {
            numerator = 0;
            denominator = 0;
        }
        Fraction getFraction()
        {
            Fraction temp{};
            std::cout << "Enter a value for numerator: ";
            std::cin >> temp.numerator;
            std::cout << "Enter a value for denominator: ";
            std::cin >> temp.denominator;
            std::cout << '\n';

            return temp;
        }

        Fraction static multiply(const Fraction& f1, const Fraction& f2)
        {
            Fraction out(f1.numerator * f2.numerator, f1.denominator * f2.denominator);
            return  out;
        }

        void printFraction(const Fraction& f)
        {
            std::cout << f.numerator << '/' << f.denominator << '\n';
        }


    };

int main()
{
    Point2d first;
    Point2d second( 3.0, 4.0 );

    // Point2d third{ 4.0 }; // should error if uncommented

    first.print();
    second.print();
    std:: cout << first.distanceTo(second) << '\n';

    Fraction f1(3,4);
    Fraction f2(5,2);
    f1.getFraction() ;
    f2.getFraction() ;

    std::cout << "Your fractions multiplied together: ";

    f1.printFraction(Fraction::multiply(f1, f2));

    return 0;

    return 0;
}