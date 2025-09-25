#include <iostream>

int main() {
    char unit;

    double origionalValue;
    double output;
    std:: cout << "What is your starting unit? (f/d) ";
    std:: cin >> unit;

    std:: cout << "What is you origional value? ";
    std:: cin >> origionalValue;

    switch(unit) {
        case 'f':
            output = (origionalValue-32)*5/9;
            break;

        case 'd':
            output = (origionalValue*9/5)+32;
            break;

        default:
            std:: cout << "Please enter either 'f' or 'd' for the starting unit";
    }

    std:: cout << output << (unit == 'f' ? " degrees" : " fahrenheit");
    return 0;
}