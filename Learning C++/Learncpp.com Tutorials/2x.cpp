#include <iostream>
#include "readAnswer.h"

void writeAnswer(int n1, int n2) {
    
    std::cout << "Answer: " << n1 + n2 << "\n";
}


int main() {
    int n1 = readNumber();
    
    int n2 = readNumber();
    
    writeAnswer(n1, n2);
    return 0;
}

