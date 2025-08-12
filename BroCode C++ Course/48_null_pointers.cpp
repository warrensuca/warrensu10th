#include <iostream>

int main() {
    //null value = special value that means something has no value, not pointing to anything
    //nullptr = keyword that represents a null pointer literal
    //nullptrs help determine if an address was successfully assigned to a pointer

    int *pointer = nullptr;
    int x = 123;

    if(pointer == nullptr) {
        std::cout << "address was not assigned \n";
    }
    else{
        std:: cout << "address was assigned! \n";
    }
}