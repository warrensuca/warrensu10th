#include <iostream>
struct Car {
    std::string model;
    int year;
    std::string color;
};

void printCar(Car &car);
void paintCar(Car &car, std::string color);
int main() {
    Car car1;
    Car car2;

    car1.model = "Mustang";
    car1.year = 2023;
    car1.color = "red";

    printCar(car1);
    paintCar(car1, "gold");
    printCar(car1);
    car2.model = "Corvette";
    car2.year = 2024;
    car2.color = "blue";
}

void printCar(Car &car) {
    std::cout << car.model << '\n';
    std::cout << car.year << '\n';
    std::cout << car.color << '\n';


}

void paintCar(Car &car, std::string color) {
    car.color = color;
}