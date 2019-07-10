#include <iostream>
#include <cmath>
#include <string>

#include "PayOffFactory.h"
#include "PayOffConstruct.h"
#include "payoffbridge.h"
#include "PayOff2.h"

using std::cout;
using std::cin;

int main(int argc, char const *argv[]) {
    double Strike, Spot;
    string name;
    
    cout << "strike= ";
    cin >> Strike;

    cout << "spot= ";
    cin >> Spot;

    cout << "payoff-category= ";
    cin >> name;

    PayOffFactory &factory=PayOffFactory::Instance();

    unique_ptr<PayOff> PayOffInstance = factory.CreatePayOff(name, Strike);

    if (PayOffInstance != NULL) {
        cout << "profit=" 
             << PayOffInstance->Calculate(Spot) 
             << "\n";
    }

    return 0;
}

