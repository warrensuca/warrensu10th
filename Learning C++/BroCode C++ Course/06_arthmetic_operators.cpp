#include <iostream>

int main() {
    int students = 20;

    students ++;
    students += 2;

    students --;
    students -= 2;


    students *= 2;

    students /= 2;


    int remainder = students % 5;

    
    std:: cout << "There are " << students << "total. There are " << remainder << "without groups";
    return 0;
}