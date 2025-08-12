#include <iostream>


int main() {
    std::string creditCardNumStr;
    

    std::cout << "What is your credit card #?: ";
    std::getline(std::cin, creditCardNumStr);
    int creditCardNum[creditCardNumStr.length()];
    for (int i = 0; i < creditCardNumStr.length(); i++) {
        
        creditCardNum[i] = (int)creditCardNumStr.at(i) - '0';
    }




    int total = 0;
    
    bool doubleDigit = false;
    for(int i = creditCardNumStr.length() - 1; i >= 0; i--) {
        int tempNum = creditCardNum[i]*2;
        std::cout << creditCardNum[i] << ' ' << i << ' ';
        if(doubleDigit){
            if(tempNum>9) {
                std::string tempStr = std::to_string(tempNum);
                total += (int)tempStr.at(0) - '0';
                total += (int)tempStr.at(1) - '0';
            }
            else {
                total += tempNum;	
            }
        }
        else {
            total += (int)creditCardNum[i];
        }
        doubleDigit = !doubleDigit;
        std:: cout << total  << '\n';
    }

    



    std:: cout << "The credit card is " << (total % 10 == 0 ? "valid" : "not valid");
    return 0;
}