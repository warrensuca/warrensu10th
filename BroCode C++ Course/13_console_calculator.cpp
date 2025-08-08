#include <iostream>
#include <cmath>

int main() {
    char op;
    double num1;
    double num2;
    double result;
    
    std::cout << "Operator? (+, -, /, *, ^) ";
    std::cin >> op;

    std:: cout << "Enter number 1: ";
    std:: cin >> num1;

    std:: cout << "Enter number 2: ";
    std:: cin >> num2;

    switch(op) {
        case '+':
            std::cout << num1 + num2;
            break;
        case '-':
            std::cout << num1 - num2;
            break;
        case '/':
            std::cout << num1/num2;
            break;
        case '*':
            std::cout << num1*num2;
            break;

        case '^':
            std::cout << pow(num1, num2);
            break;

        default:
            std::cout << "Please enter an operator from (+, -, /, *, ^)";
    }

    
    return 0;
}