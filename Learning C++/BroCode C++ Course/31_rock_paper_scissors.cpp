#include <iostream>

char getUserChoice();
char getComputerChoice();
void showChoice(char choice);
char chooseWinner(char player, char computer);

int main() {
    
    char user;
    char computer;
    char winner;

    std:: cout << "*********** Welcome to Rock, Paper, Scissors **********\n";
    
    user = getUserChoice();
    std:: cout << "You played ";
    showChoice(user);
    computer = getComputerChoice();
    std:: cout << "The Computer played ";
    showChoice(computer);
    winner = chooseWinner(user, computer);

    switch(winner) {
        case 'P': std:: cout << "You, the Player, won!\n";
            break;
        case 'C': std:: cout << "The Computer won!\n";
            break;
        case 'T': std:: cout << "It was a tie";
            break;
    }
    return 0;
}

char getUserChoice( ){
    char choice;
    do{
        std::cout << "What do you pick? (R,P,S) ";
        std::cin >> choice;
    }while(choice != 'R' && choice != 'P' && choice != 'S');

    return choice;

}

char getComputerChoice() {
    srand(time(NULL));
    int num = rand() % 3;

    if(num == 0) {
        return 'R';
    }

    if(num == 1) {
        return 'P';
    }

    else {
        return 'S';
    }
}

void showChoice(char choice) {
    switch(choice) {
        case 'R': std:: cout << "Rock\n";
            break;
        case 'S': std:: cout << "Scissors\n";
            break;
        case 'P': std:: cout << "Paper\n";
            break;
    }
}

char chooseWinner(char player, char computer){
    if(player == 'P' && computer == 'R') {
        return 'P';
    }
    else if(player == 'R' && computer == 'S') {
        return 'P';
    }
    else if(player == 'S' && computer == 'P') {
        return 'P';
    }
    else if(player == 'R' && computer == 'P') {
        return 'C';
    }
    else if(player == 'S' && computer == 'R') {
        return 'C';
    }
    else if(player == 'P' && computer == 'S') {
        return 'C';
    }
    else {
        return 'T';
    }
}