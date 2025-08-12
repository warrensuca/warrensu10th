#include <iostream>

void walk(int steps);
int factorial(int num);
int main() {
    walk(100);

    std:: cout << factorial(6);
    return 0;
}

void walk(int steps) {
    if(steps > 0) {
        std::cout << "You have taken a step!\n";
        walk(steps-1);
    }
    
}
int factorial(int num){
    if(num == 1) {
        return num;
    }
    else {
        return num * factorial(num-1);
    }
}
