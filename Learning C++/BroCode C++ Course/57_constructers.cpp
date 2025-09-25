#include <iostream>

class Car{
    public:
        std::string make;
        std::string model;
        int year;
        std::string color;

        Car(std::string make, std::string model, int year, std::string color) {
            this->make = make;
            this->model = model;
            this->year = year;
            this->color = color;

            //model = x
            //year = y
            //color = z
            //only use this if the names are the same
        }

        void accelerate(){
            std::cout << "You stepped on the gas!\n";
        }

        void brake(){
            std::cout << "You stepped on the brakes!\n";
        }
};

int main() {
    Car f1Car("Honda", "Ferrari", 2020, "red");

    std::cout << f1Car.make << '\n';
    std::cout << f1Car.model << '\n';
    std::cout << f1Car.year << '\n';
    std::cout << f1Car.color << '\n';
    return 0;
}