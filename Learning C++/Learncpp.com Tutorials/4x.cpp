#include <iostream>


double getNum() {
    std:: cout << "Enter a double value: " << '\n';
    double out;
    std:: cin >> out;

    return out;
}

char getSymbol() {
    std:: cout << "Enter +, -, *, or /: " << '\n';
    char out;
    std:: cin >> out;

    return out;
}

double readHeight() {
    std:: cout << "Enter the height of the tower in meters: " << '\n';
    double height;
    std:: cin >> height;

    return height;
}
double getCurrHeight(double height, int t) {
    std::cout << "At " << t << " seconds, ";
    if(height - 4.9*t*t > 0) { 
        std:: cout << "the ball is at height: " << height - 4.9*t*t << " meters \n";
    }
    else {
        std:: cout << "the ball is on the ground"; 
    }
}

int main() {
    double n1 = getNum();
    double n2 = getNum();

    const char symbol = getSymbol();
    
    double out;
    if(symbol == '*') {
        out = n1 * n2;
    }
    else if(symbol == '+'){
        out = n1 + n2;
    }
    else if (symbol == '-'){
        out = n1 - n2;
    }
     else if (symbol == '/'){
        out = n1 / n2;
    }
    std:: cout << n1 << " " << symbol << " " << n2 << " == " << out << '\n';

    int height = readHeight();
    
    getCurrHeight(height, 4);
    getCurrHeight(height, 6);
}