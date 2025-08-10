#include <iostream>
int main() {
    std:: string students[] = {"Spongebob", "Patrick" "Squidward"};

    for(int i = 0; i < sizeof(students)/sizeof(std:: string); i++) {
        std:: cout << students[i]; 
    }

    for(std:: string student : students) {
        std:: cout << student << '\n';
    }

    int grades[] = {65, 72, 81, 93};
    for(int i = 0; i < sizeof(grades)/sizeof(int);  i++) {
        std:: cout << grades[i] << '\n';
    }
    
    return 0;
}