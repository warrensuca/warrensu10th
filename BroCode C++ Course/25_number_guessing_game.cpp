#include <iostream>
#include <ctime>

int main() {

    srand(time(NULL));
    int randNum = rand() % 100;

    int guess;
    int tries = 0;
    std::cout << " ****** NUMBER GUESSING GAME ****** \n";
    do{
        std::cout << "What is your guess? ";
        std:: cin >> guess;

        tries += 1;
        if(randNum > guess) {
            std:: cout << "Too low \n";
        }
        else if(randNum < guess) {
            std:: cout << "Too High \n";
        }
        else {
            std:: cout << "You did it! The number was " << randNum << " And it took you " << tries << (tries == 1 ? " try" : " tries");
        }
      
    }while(guess != randNum);

    std:: cout << "************************";
}