#include <iostream>
#include <cmath>
class Animal{
    public:
        bool alive = true;
    void eat() {
        std::cout << "This animal is eating\n";
    }
};

class Dog: public Animal{
    public:
        void bark() {
            std::cout << "The dog goes woof\n";
        }
};

class Cat: public Animal{
    public:
        void meow() {
            std::cout << "The cat goes meow\n";
        }
};


class Shape{
    public:
        double area;
        double volume;

};

class Cube : public Shape{
    public:
        double side;

    Cube(double side) {
        this->side = side;
        this->area = side*side*6;
        this->volume = pow(side,3);
    }

};
class Sphere : public Shape {
    public:
        double radius;
    Sphere(double radius) {
        this->radius = radius;
        this->area = 4*3.141592653 * pow(radius,2);
        this->volume = (4/3.0) * 3.141592653 * pow(radius,3);
    }
};

int main() {
    Dog dog;
    Cat cat;

    Cube cube(10);
    Sphere sphere(5);
    
    std::cout << dog.alive << '\n';
    dog.eat();
    cat.meow();

    std::cout << cube.volume << '\n';
    std::cout << sphere.area << '\n';
    return 0;
}