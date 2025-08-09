#include <iostream>

int main() {
    srand(time(NULL));

    int num1 = (rand()+1) % 6;
    int num2 = (rand()+1) % 6;
    int num3 = (rand()+1) % 6;


    std::cout << num1 << '\n';
    std::cout << num2 << '\n';
    std::cout << num3 << '\n';
    return 0;
}