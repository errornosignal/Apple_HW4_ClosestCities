//
//  main.swift
//  Apple_HW4_ClosestCities
//
//  Created by Reid Nolan on 10/3/17.
//  Copyright © 2017 Reid Nolan. All rights reserved.
//

import Foundation
import CoreLocation

//validate user input
func validateInput(prompt: String) -> String {
    while (true) {
        print(prompt)
        let userInput = readLine()!
        if(userInput.count > 0) {
            return userInput
        } else {
            print("Error! No Input.")
        }
    }
}

//match cities based on GCD
func matchCities(selection: City, cities: [City], near: Bool, numToMatch: Int) -> [City2] {
    var matchArray: [City2] = []
    let location1 = selection.location
    var distance: CLLocationDistance = 0
    
    //iterate through cities, cast to new struct with updated distance info, and append to new array
    for city in cities {
        let location2 = city.location
        distance = location1.distance(from: location2)
        matchArray.append(City2(name: city.name, country: city.country, location: city.location, distance: distance))
    }
    
    //sort cities in array by ascending distance from selected city
    matchArray.sort { $0.distance < $1.distance }
    //find nearest cities
    if (near == true) {
        //remove all but nearest cities from array
        matchArray.removeSubrange((numToMatch + 1)..<matchArray.count)
    //find farthest cities
    } else {
        //remove all but farthest cities from array
        matchArray.removeSubrange(1..<(matchArray.count-numToMatch))
    }
    return matchArray
}

//resolve city name to index number in array
func nameToIndex(cityName: String, cities: [City]) -> Int {
    for (index, city) in cities.enumerated() {
        if (city.name.lowercased() == cityName) {
            return index
        } else {/*doNothing()*/}
    }
    return -1
}

//gets latitude and longitude substring from location property of City
func getLatLong (city: City) -> String {
    let tmpStr = String(describing: city.location)
    let cutoff = tmpStr.index(of: " ")!
    let latLong = tmpStr.prefix(upTo: cutoff)
    return String(latLong)
}

//City struct
struct City {
    let name: String
    let country: String
    let location: CLLocation
}

//City2 struct
struct City2 {
    let name: String
    let country: String
    let location: CLLocation
    let distance: CLLocationDistance
}

//main
//print program header
print("Apple_HW4_ClosestCities")
print("Type 'quit' to exit.\n")

let file = "worldcities.csv" //data file
let qtyOfCities = 5 //qty of matches to return
var runCount = 0 //program iteration counter

while (true) {
    var cities: [City] = []
    var nearOrFar = false //boolean for searching near or far cities
    var index = 0
    
    //get path for data file, attempt to read, and start splitting rows into city properties
    if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fullPath = path.appendingPathComponent(file)
        do {
            let contents = try String(contentsOf: fullPath, encoding: .utf8)
            var rows = contents.components(separatedBy: "\r\n")
            
            //eliminate header row
            rows.remove(at: 0)
            rows.remove(at: rows.count - 1)
            
            //parse data in file
            for row in rows {
                var splitRow = row.components(separatedBy: ",")
                if (Double(splitRow[2]) != nil && Double(splitRow[3]) != nil) {
                    cities.append(City(name: splitRow[0].trimmingCharacters(in: .whitespaces),
                                       country: splitRow[1].trimmingCharacters(in: .whitespaces),
                                       location: CLLocation(latitude: Double(splitRow[2])!, longitude: Double(splitRow[3])!)))
                } else {
                    //display message on error
                    let msgStr1 = String(format:"Error processing ~/Documents/%@. Terminating...", file)
                    print(msgStr1)
                    exit(1)
                }
            }
        } catch {
            //display message on error
            let msgStr2 = String(format:"Failed to open ~/Documents/%@. Terminating...", file)
            print(msgStr2)
            exit(2)
        }
    }
    
    //print cities list w/data to console
    if (runCount == 0) {
        for (index, city) in cities.enumerated() {
            let latLong = getLatLong(city: city)
            //adjust formatting for list
            if index < 10 {
                print("  \(index)- \(city.name), \(city.country) - \(latLong)")
            } else if(index >= 10 && index < 100){
                print(" \(index)- \(city.name), \(city.country) - \(latLong)")
            } else {
                print("\(index)- \(city.name), \(city.country) - \(latLong)")
            }
        }
        runCount += 1 //counter-based 'if' condition keeps application from compounding city list on re-iteration
        print()
    } else {/*doNothing*/}

    //get user city selection
    var userInput1Good = false; //boolean for loop
    while (!userInput1Good) {
        let inStr1 = validateInput(prompt: "Enter the name or number of the city to search: ")
        let userInput1 = inStr1.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        //process selection
        if (userInput1 == "quit") {
            exit(3)
        } else if (Int(userInput1) != nil && cities.indices.contains(Int(userInput1)!)) {
            index = Int(userInput1)!
            userInput1Good = true
        } else if (nameToIndex(cityName: userInput1, cities: cities) != -1) {
            index = nameToIndex(cityName: userInput1, cities: cities);
            userInput1Good = true
        } else {
            print("Error! Invalid name or index.")
        }
    }

    //get user nearest or farthest selection
    var userInput2Good = false //boolean for loop
    while (!userInput2Good) {
        let inStr2 = validateInput(prompt: "Find nearest or farthest?(n/f):")
        let userInput2 = inStr2.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        //process selection
        if (userInput2 == "quit") {
            exit(4)
        } else if (userInput2 == "n") {
            nearOrFar = true
            userInput2Good = true;
        } else if (userInput2 == "f") {
            nearOrFar = false
            userInput2Good = true
        } else {
            print("Error! Invalid selection.")
        }
    }

    //print match results to console
    let selectedCity = cities[index]
    let matchedCities = matchCities(selection: selectedCity, cities: cities, near: nearOrFar, numToMatch: qtyOfCities)
    for city in matchedCities {
        let oneMile = 1609.344 //meters per mile
        let distanceInMeters = selectedCity.location.distance(from: city.location)
        //round up two decimal places
        let distanceInMiles = String(format: "%.2f", ceil((distanceInMeters / oneMile) * 100)/100)
        print("\(city.name),\(city.country) - \(distanceInMiles)mi")
    }
    print()
}
