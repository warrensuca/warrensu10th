#include <iostream>

int main() {
    int temp;

    bool sunny = false;

    std:: cout << "Enter the temperature: ";
    std:: cin >> temp;

    if(temp > 0 && temp < 30) {
        std:: cout << "The tempurate is good";
    }
    else {
        std:: cout << "The temperature is bad";
    }

    if(sunny) {
        std::cout << "It is cloudy outside!";
    }
    else {
        std::cout << "It is sunny outside";
    }
    return 0;
}