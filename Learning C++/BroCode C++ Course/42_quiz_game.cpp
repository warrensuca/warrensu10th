#include <iostream>

int main() {
    std::string questions[] = {"1. What year was C++ created?: ",
                                "2. Who invented C++",
                                "3. What is the predecessor of C++",
                                "4. is the Earth Flat"};
    std::string options[][4] = {{"A. 1969", "B. 1975", "C. 1985", "D. 1989"}, 
                                {"A. Guido van Rossum", "B. Bjarne Stroustrup", "C. John Carmack", "D. Mark Zuckerberg"},
                                {"A. C", "B. C+", "C. C--", "D. B++"},
                                {"A. yes", "B. no"}};
    char answerKey[] = {'C', 'B', 'A', 'B'};

    int size = std::size(questions);
    char guess;
    int score = 0;

    for(int i = 0; i < size; i++) {
        std:: cout << "************************\n";
        std:: cout << questions[i] << "\n";
        std:: cout << "************************\n";
        for(int j = 0; j < std::size(options[i]); j++) {

            std::cout << options[i][j] << " ";
            
        }
        std::cin >> guess;
        guess = toupper(guess);
        if (answerKey[i] == guess) {
            std::cout << "Correct! \n";
            score++;
        }
        else {
            std::cout << "Wrong... \n";
            std::cout << "The answer was " << answerKey[i] << '\n';
        }
    }
    std::cout << "RESULTS" << '\n';
    std::cout << "CORRECT GUESSES: " << score << '\n';
    std::cout << "# OF QUESTIONS: " << size << '\n';
    std::cout << "Score: " << double(score)/size * 100 << "%";
    return 0;
}