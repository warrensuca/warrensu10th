#include <iostream>
#include <cmath>

int main() {
    int month; 
    
    char grade;
    
    std::cout << "What letter grade?: ";
    std::cin >> grade;

    std:: cout << "Enter the month " ;
    std:: cin >> month;

    switch(grade) {
        case 'A':
            std::cout << "You did great" << '\n';
            break;
        case 'B':
            std::cout << "You did good" << '\n';
            break;
        case 'C':
            std::cout << "You did okay" << '\n';
            break;
        case 'D':
            std::cout << "You did not do good" << '\n';
            break;

        case 'F':
            std::cout << "YOU FAILED" << '\n';
            break;

        default:
            std::cout << "Please enter in a letter grade (A-F)" << '\n';
    }

    switch(month) {
        case 1:
            std::cout << "It is January";
            break;
        case 2:
            std::cout << "It is February";
            break;
        case 3:
            std::cout << "It is March";
            break;
        case 4:
            std::cout << "It is April";
            break;

        case 5:
            std::cout << "It is May";
            break;

        case 6:
            std::cout << "It is June";
            break;

        case 7:
            std::cout << "It is July";
            break;

        case 8:
            std::cout << "It is August";
            break;

        case 9:
            std::cout << "It is September";
            break;

        case 10:
            std::cout << "It is October";
            break;

        case 11:
            std::cout << "It is November";
            break;

        case 12:
            std::cout << "It is December";
            break;
        default:
            std::cout << "Please enter numbers (1-12)";
            break;
    }
    return 0;
}