#include <iostream>

int main() {
    int x1;
    int x2;

    std::cout << "Enter a integer " << '\n';
    std::cout << "Enter another integer: " << '\n';

    std::cin >> x1;
    std::cin >> x2;

    std::cout << x1 << " + " << x2 << " is " << x1 + x2 << ".\n";
    std::cout << x1 << " - " << x2 << " is " << x1 - x2 << ".\n";
    return 0;
}


