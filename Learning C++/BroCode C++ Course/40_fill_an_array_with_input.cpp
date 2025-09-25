#include <iostream>

int main() {
    std:: string foods[5];
    std::string temp;
    int size = std::size(foods);

    for(int i = 0; i < size; i++) {
        std::cout << "Enter a food you like or 'q' to quit " << i + 1 << " : ";
        
        std::getline(std::cin, temp);
        
        if(temp == "q") {
            break;
        }

        foods[i] = temp;
    }

    std::cout << "You like the following food: \n";

    for(int i = 0; !foods[i].empty(); i++) {
        std:: cout << foods[i] << '\n';
    }
}