#include <iostream>

int main() {

    char x = 100;
    int correct = 8;

    int questions = 10;

    //double score = corrects/questions * 100;  will return 0
    double score = correct/(double)questions * 100;

    std:: cout << score << '%';

    return 0;
}