#include <iostream>

int main() {
    //program is more flexible, especially when taking user input

    int *pNum = NULL;

    char *pGrades = NULL;
    int size;

    std::cout << "How many grades to enter in?: ";
    std::cin >> size;

    pGrades = new char[size];

    pNum = new int;

    for(int i = 0; i < size; i++) {
        std::cout << "Enter grade #" << i+ 1 << ": ";
        std::cin >> pGrades[i];
    }

    *pNum = 21;

    for(int i = 0; i < size; i++) {
        std::cout << pGrades[i] << " ";

    }

    std::cout << "address: " << pNum << '\n';
    std::cout << "value: " << *pNum << '\n';

    delete pNum;
    delete[] pGrades;
    
    return 0;
}