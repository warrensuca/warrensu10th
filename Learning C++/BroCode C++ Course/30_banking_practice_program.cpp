#include <iostream>
#include <iomanip>






void showBalance(double balance) {
    std:: cout << "Your balance is $" << std::fixed << std::setprecision(2) << balance << "\n";
} 

double deposit(double balance) {
    int amount = 0;
    std::cout << "Enter amount to be deposited ";
    std:: cin >> amount;
    if(amount > 0) {
        return amount;
    }
    else {
        std::cout << "That's not a valid amount: \n";
        return 0;
    }
    
}

double withdraw(double balance) {
    int amount = 0;
    std::cout << "Enter amount to be withdrawn ";
    std:: cin >> amount;
    if(amount > balance) {
        std::cout << "Insufficient funds \n";
        return 0;
    }
    else if(amount < 0) {
        std::cout << "That's not a valid amount \n";
    }
    else {
        return amount;
    }
    
}

int main() {

    double balance = 100;
    
    int choice = 0;
    bool exit = false;
    do{
        std:: cout << "************\n";
        std:: cout << "Enter your choice: \n";
        std:: cout << "************\n";
        std:: cout << "1. Show Balance\n";
        std:: cout << "1. Deposit Money\n";
        std:: cout << "3. Withdraw Money\n";
        std:: cout << "4. Exit\n";

        std:: cin >> choice;

        std::cin.clear();
        fflush(stdin);
        
        switch(choice) {
            case 1:
                showBalance(balance);
                break;
            case 2:
                
                balance += deposit(balance);
                showBalance(balance);
                break;
            case 3:
                balance -= withdraw(balance);
                showBalance(balance);
                break;
            default:
                std::cout << "Invalid choice \n";
        }
    }while(choice != 4);


    return 0;
}
