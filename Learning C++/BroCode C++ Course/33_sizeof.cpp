#include <iostream>

int main() {
    std:: string name = "Bro Code";
    double gpa = 2.5;
    char grade = 'F';
    bool student = true;
    char grades[] = {'A', 'B', 'C', 'D', 'F'};

    std:: string students[] = {"Spongebob", "Patrick", "Squidard", "Sandy"};

    std:: cout << sizeof(students)/sizeof(std::string) << " elements\n";
    return 0;   
}