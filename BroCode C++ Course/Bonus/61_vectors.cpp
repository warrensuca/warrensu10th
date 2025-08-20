#include <iostream>
#include <vector>

int main() {
    std::vector<int> v1 = {1,2,3,4};

    std::cout << v1[1] << '\n';

    v1.push_back(9);
    v1.push_back(9);
    v1.push_back(9);
    v1.push_back(9);
    v1.push_back(9);
    std::cout << v1.capacity() << '\n';
    std::cout << v1.size() << '\n';
    v1.pop_back();
    v1.pop_back();
    v1.pop_back();
    v1.pop_back();
    v1.pop_back();
    std::cout << v1.front() << '\n';
    std::cout << v1.capacity() << '\n';
    v1.shrink_to_fit();
    std::cout << v1.front() << '\n';
    std::cout << v1.capacity() << '\n';
    std::cout << v1.size() << '\n';


    v1.insert(v1.begin(), 5);
    std::cout << v1[0] << '\n';

    v1.insert(v1.begin() + 3, 5);
    std::cout << v1[3];


    v1.erase(v1.begin() + 3);
    std::cout << v1[3];
    for (int i = 0; i < v1.size(); i++) {
        std::cout << v1[i] << '\n';
    }

    for (auto itr = v1.begin(); itr != v1.end(); itr++) {
        std::cout << *itr << '\n';
    }
}