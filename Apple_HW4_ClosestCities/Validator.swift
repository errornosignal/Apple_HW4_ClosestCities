//
//  Validator.swift
//  Apple_HW4_ClosestCities
//
//  Created by Reid Nolan on 10/8/17.
//  Copyright © 2017 Reid Nolan. All rights reserved.
//

//
import Foundation

class Validator {
    
    static func validateDoubleInput(prompt: String) -> Double {
        while(true) {
            print(prompt)
            let inputString = readLine()!
            
            if (NumberFormatter().number(from: inputString)?.doubleValue) != nil {
               let inputStringDouble = Double(inputString)!
                    return inputStringDouble;
            }
            else {
                print("Error! Invalid Input. Value must be a double.")
            }
        }
    }
    
    class func validateIntInput(prompt: String) -> Int {
        while (true) {
            print(prompt);
            let inputInt = Int(readLine()!)
            
            if (inputInt != nil ) {
                return inputInt!;
            }
            else {
                print("Error! Invalid input. Value must be an integer.");
            }
        }
    }
}
