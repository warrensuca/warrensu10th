#include <iostream>
#include <cmath>

int main() {
    int grade = 75; 
    
    grade >= 60 ? std:: cout << "You passed!" : std:: cout << "You failed" << '\n';
    
    int number = 9;
    number % 2 == 1? std:: cout << "Odd" : std:: cout << "Even" << '\n';

    bool hungry = true;

    std:: cout << (hungry ? "You are hungry" : "You are full");

    return 0;
}