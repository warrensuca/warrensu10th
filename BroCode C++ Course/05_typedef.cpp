#include <iostream>
#include <vector>

//alias for another data type/new identifier
//helps with readability

typedef std::vector<std::pair<std::string,int>> pairlist_t;

//typedef std::string text_t;
//typedef int number_t;
using text_t = std::string;
using number_t = int;
int main() {
    pairlist_t pairlist;
    number_t age = 21;


    text_t firstName = "Warren";

    std::cout << firstName << '\n';
    return 0;
}