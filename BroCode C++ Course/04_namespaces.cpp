#include <iostream>

namespace first {
    int x = 1;
}


namespace second {
    int x = 2;
}


int main() {
    int x = 0;

    using namespace second;

    std::cout << first:: x; //output 2

    return 0;
}