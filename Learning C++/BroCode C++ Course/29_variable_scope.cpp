#include <iostream>

int myNum = 2; //global var

void printNum();

int main() {
    int myNum = 1;

    printNum();
    std::cout << myNum; //prioritize local over global
    std::cout << ::myNum; //:: makes the priority global over local

    return 0;
}

void printNum() {

    std::cout << myNum << "\n"; //will use global
}