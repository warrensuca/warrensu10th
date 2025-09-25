#include <iostream>

int main() {
    int size = 100;
    std:: string foods[size];

    fill(foods, foods + (size/3), "pizza");
    fill(foods + (size/3), foods + (size/3)*2, "hamburger");
    fill(foods + (size/3)*2, foods + size, "hotdogs");

    for(std::string food: foods) {
        std::cout << food << '\n';
    }

    return 0;
}