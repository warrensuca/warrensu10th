#include <iostream>
#include <ctime>


void happyBirthday(std::string birthdayBoi, int age) {
    std::cout << "Happy Birthday to " << birthdayBoi << '\n';
    std::cout << "Happy Birthday to " << birthdayBoi << "\n";
    std::cout << "Happy Birthday dear " << birthdayBoi << "\n";
    std::cout << "Happy Birthday to " << birthdayBoi << "\n";
    std::cout << "You are " << age << "\n";
}

int main() {

    std::string name = "Bro";
    int age = 21;
    happyBirthday(name, age);

    return 0;
}