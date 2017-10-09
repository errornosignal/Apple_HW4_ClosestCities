//
//  Validator.swift
//  Apple_HW4_ClosestCities
//
//  Created by Reid Nolan on 10/8/17.
//  Copyright © 2017 Reid Nolan. All rights reserved.
//

import Foundation

class Validator {
    
    func validateDoubleInput(prompt: String) -> Double {
        while(true) {
            print(prompt)
            let inputString = readLine()!
            
            if (NumberFormatter().number(from: inputString)?.doubleValue) != nil {
               let userInput = Double(inputString)!
                    return userInput;
            }
            else {
                print("Error! Input is not a valid double value.")
            }
        }
    }
    
    func validateIntInput(prompt: String) -> Int? {
        
        while(true) {
            print(prompt)
            let inputString = readLine()!
            
            if ((NumberFormatter().number(from: inputString)?.intValue) != nil){
                _ = Int(inputString)!
                
//                if (inputString is Int) {
//
//                    let minValue = 1
//                    let maxValue = 200
//
//                    if intInput >= minValue {
//                        if intInput <= maxValue {
//                            return intInput;
//                        }
//                        else {
//                            print("Error! Input is above '\(maxValue)' maximum value")
//                        }
//                    }
//                    else {
//                        print("Error! Input is below '\(minValue)' minimum value.")
//                    }
////                }
//            }
//
//            else {
//                print("Error! Input is not a valid integer value from 1-200.")
//            }
//
            }
    }
    
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }

}

}
