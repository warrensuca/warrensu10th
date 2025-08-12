#include <iostream>
#include <ctime>
void drawBoard(char *spaces);
void playerMove(char *spaces, char player);
void computerMove(char *spaces, char computer);
bool checkWinner(char *spaces, char player, char computer);
bool checkTie(char *spaces);


int main() {
    char spaces[9] = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '};
    char player = 'X';
    char computer = 'O';
    bool running = true;

    drawBoard(spaces);
    while(running) {
        playerMove(spaces, player);
        drawBoard(spaces);
        if(checkWinner(spaces, player, computer)) {
            running = false;
            break;
        }
        else if(checkTie(spaces)){
            running = false;
            break;
        }
        std:: cout << "************************\n";
        computerMove(spaces, computer);
        drawBoard(spaces);
        if(checkWinner(spaces, player, computer)) {
            running = false;
            break;
        }
        else if(checkTie(spaces)){
            running = false;
            break;
        }
    }
    std::cout << "Thanks for playing!";
    return 0;
}

void drawBoard(char *spaces) {
    std::cout << "     |     |     \n";
    std::cout << "  " << spaces[0] << "  |  " << spaces[1] << "  |  " << spaces[2] << "  \n";
    std::cout << "_____|_____|_____\n";
    std::cout << "     |     |     \n";
    std::cout << "  " << spaces[3] << "  |  " << spaces[4] << "  |  " << spaces[5] << "  \n";
    std::cout << "_____|_____|_____\n";
    std::cout << "     |     |     \n";
    std::cout << "  " << spaces[6] << "  |  " << spaces[7] << "  |  " << spaces[8] << "  \n";
    std::cout << "     |     |     \n";
}
void playerMove(char *spaces, char player) {
    int number;
    bool go = true;
    while(go){
        std::cout << "Enter a spot to place a marker (1-9) ";
        std::cin >> number;


        number--;
        if(spaces[number] == ' ') {
            spaces[number] = player;
        }
        if(number > -1 && number < 9) {

            go = false;
        }
    }
}
void computerMove(char *spaces, char computer) {
    int number;
    srand(time(0));

    while(true) {
        number = rand() % 9;
        if(spaces[number] == ' '){
            spaces[number] = computer;
            break;
        }
    }
}
bool checkWinner(char *spaces, char player, char computer) {
    if((spaces[0] != ' ') && spaces[0] == spaces[1] && (spaces[1] == spaces[2])) {
        std::cout << (spaces[0] == player ? "YOU WIN!\n" : "YOU LOSE\n");
    }
    else if((spaces[3] != ' ') && spaces[3] == spaces[4] && (spaces[4] == spaces[5])) {
        std::cout << (spaces[3] == player ? "YOU WIN!\n" : "YOU LOSE\n");
    }
    else if((spaces[6] != ' ') && spaces[6] == spaces[7] && (spaces[7] == spaces[8])) {
        std::cout << (spaces[6] == player ? "YOU WIN!\n" : "YOU LOSE\n");
    }
    else if((spaces[0] != ' ') && spaces[0] == spaces[3] && (spaces[3] == spaces[6])) {
        std::cout << (spaces[0] == player ? "YOU WIN!\n" : "YOU LOSE\n");
    }
    else if((spaces[1] != ' ') && spaces[1] == spaces[4] && (spaces[4] == spaces[7])) {
        std::cout << (spaces[1] == player ? "YOU WIN!\n" : "YOU LOSE\n");
    }
    else if((spaces[2] != ' ') && spaces[2] == spaces[5] && (spaces[5] == spaces[8])) {
        std::cout << (spaces[2] == player ? "YOU WIN!\n" : "YOU LOSE\n");
    }
    else if((spaces[0] != ' ') && spaces[0] == spaces[4] && (spaces[4] == spaces[8])) {
        std::cout << (spaces[0] == player ? "YOU WIN!\n" : "YOU LOSE\n");
    }
    else if((spaces[2] != ' ') && spaces[2] == spaces[4] && (spaces[4] == spaces[6])) {
        std::cout << (spaces[2] == player ? "YOU WIN!\n" : "YOU LOSE\n");
    }
    else {
        return false;
    }
    return true;
}

bool checkTie(char *spaces) {
    for(int i = 0; i < 9; i++) {
        if(spaces[i] == ' ') {
            return false;
            break;
        }
    }

    std::cout << "ITS A TIE\n";
}