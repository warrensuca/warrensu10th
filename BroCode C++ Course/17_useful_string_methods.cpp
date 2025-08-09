#include <iostream>

int main() {
    std::string name;
    std::string lastName;

    std::cout << "Enter your name: ";
    std::getline(std::cin, name);
    
    std:: cout << "Enter your last name ";
    std::getline(std::cin, lastName);

    name.append(lastName);

    name.insert(0, "@");


    std:: cout << name.find('W');
    std:: cout << name.at(0);

    
    if(name.length()> 12) {
        std::cout << "Your name can't be over 12 characters";
    }
    else if(name.empty()) {
        std:: cout << "You didn't enter your name";
    }
    else {
        std:: cout << "Welcome " << name;
    }
    name.erase(0,2);
    std:: cout << name;
    return 0;
}