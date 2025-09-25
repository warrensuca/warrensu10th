#include <iostream>
#undef NDEBUG

#include <cassert> // for assert


bool isPrime(int x)
{
    if (x <= 1) return false; 
    if (x == 2) return true;   
    if (x % 2 == 0) return false; 

    for (int i = 3; i * i <= x; i += 2) { 
        if (x % i == 0) {
            return false;
        }
    }
    return true;
}
    

// Gets tower height from user and returns it
double getTowerHeight()
{
	std::cout << "Enter the height of the tower in meters: ";
	double towerHeight;
	std::cin >> towerHeight;
	return towerHeight;
}

// Returns the current ball height after "seconds" seconds
double calculateBallHeight(double towerHeight, int seconds)
{
	const double gravity =  9.8 ;

	// Using formula: s = (u * t) + (a * t^2) / 2
	// here u (initial velocity) = 0, so (u * t) = 0
	const double fallDistance =  gravity * (seconds * seconds) / 2.0 ;
	const double ballHeight  =  towerHeight - fallDistance ;

	// If the ball would be under the ground, place it on the ground
	if (ballHeight < 0.0)
		return 0.0;

	return ballHeight;
}

// Prints ball height above ground
void printBallHeight(double ballHeight, int seconds)
{
	if (ballHeight > 0.0)
		std::cout << "At " << seconds << " seconds, the ball is at height: " << ballHeight << " meters\n";
	else
		std::cout << "At " << seconds << " seconds, the ball is on the ground.\n";
}

// Calculates the current ball height and then prints it
// This is a helper function to make it easier to do this
void calculateAndPrintBallHeight(double towerHeight, int seconds)
{
	const double ballHeight = calculateBallHeight(towerHeight, seconds) ;
	printBallHeight(ballHeight, seconds);
}



int main()
{
    assert(!isPrime(0)); // terminate program if isPrime(0) is true
    assert(!isPrime(1));
    assert(isPrime(2));  // terminate program if isPrime(2) is false
    assert(isPrime(3));
    assert(!isPrime(4));
    assert(isPrime(5));
    assert(isPrime(7));
    assert(!isPrime(9));
    assert(isPrime(11));
    assert(isPrime(13));
    assert(!isPrime(15));
    assert(!isPrime(16));
    assert(isPrime(17));
    assert(isPrime(19));
    assert(isPrime(97));
    assert(!isPrime(99));
    assert(isPrime(13417));

    std::cout << "Success!\n";

    return 0;
	const double towerHeight = getTowerHeight();
    int t = 0;
    while(calculateBallHeight(towerHeight, t) > 0) {
        calculateAndPrintBallHeight(towerHeight, t);
        t++;
    }


	return 0;
    // Make sure that assert triggers even if we compile in release mode
}