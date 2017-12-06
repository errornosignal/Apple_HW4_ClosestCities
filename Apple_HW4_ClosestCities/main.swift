//
//  main.swift
//  Apple_HW4_ClosestCities
//
//  Created by Reid Nolan on 10/3/17.
//  Copyright © 2017 Reid Nolan. All rights reserved.
//

import Foundation
import CoreLocation

func validateInput(prompt: String) -> String {
    while (true) {
        print(prompt)
        let userInput = readLine()!.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if(userInput.count > 0) {
            return userInput;
        }
        else {
            print("Error! Invalid input.")
        }
    }
}

func sortByLocation(base: City, nearest: Bool, amount: Int) -> [City] {
    var citiesCopy = cities;
    var results: [City] = [];
    
    while (results.count != amount) {
        var candidate: (index: Int, city: City) = (-1, base);
        
        for (index, city) in citiesCopy.enumerated() {
            if (candidate.city.name != city.name) {
                // This will initially be zero, so we need an edge case that checks for -1 index and OVERRIDES this value.
                if (candidate.index == -1) {
                    candidate = (index, city);
                } else {
                    let baseDistance = base.location.distance(from: candidate.city.location);
                    let candidateDistance = candidate.city.location.distance(from: city.location);
                    
                    if (nearest == true && baseDistance > candidateDistance) {
                        candidate = (index, city);
                    } else if (nearest == false && baseDistance < candidateDistance) {
                        candidate = (index, city);
                    }
                }
            } else {
                citiesCopy.remove(at: index);
            }
        }
        
        results.append(candidate.city);
        citiesCopy.remove(at: candidate.index);
    }
    
    return results;
}

func getIndexFromCityName(cityName: String) -> Int {
    for (index, city) in cities.enumerated() {
        if (city.name.lowercased() == cityName.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)) {
            return index;
        }
    }
    return -1;
}

struct City {
    let name: String
    let country: String
    let location: CLLocation;
}

var cities: [City] = [];

//main
while(true) {
    var index: Int = 0
    
    var nearestInput: Bool = false;
    
    if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let file = "worldcities.csv";
        let fileUrl = path.appendingPathComponent(file);
        
        do {
            let contents = try String(contentsOf: fileUrl, encoding: .utf8);
            var rows = contents.components(separatedBy: "\r\n");
            
            rows.remove(at: 0);
            rows.remove(at: rows.count - 1);
            
            
            for row in rows {
                var splitRow = row.components(separatedBy: ",");
                if (Double(splitRow[2]) != nil && Double(splitRow[3]) != nil) {
                    cities.append(City(name: splitRow[0].trimmingCharacters(in: .whitespaces),
                                       country: splitRow[1].trimmingCharacters(in: .whitespaces),
                                       location: CLLocation(latitude: Double(splitRow[2])!, longitude: Double(splitRow[3])!)));
                } else {
                    print("Failed to parse worldcities.csv, this is due to a bad Double conversion from latitude(s) and/or longitude(s) fields.");
                    exit(0);
                }
            }
        } catch {
            print("Failed to open ~/Documents/worldcities.csv");
            exit(0);
        }
    }

    print("Apple_HW4_ClosestCities")
    print("Type '0' to exit.")
    for (index, city) in cities.enumerated() {
        if index < 10 {
            print("  \(index)- \(city.name)");
        } else if(index >= 10 && index < 100){
            print(" \(index)- \(city.name)");
        } else {
            print("\(index)- \(city.name)");
        }
    }

    let userInput = validateInput(prompt: "Enter the number of the city to search: ")

    if(Int(userInput) == 0) {
        exit(1)
    } else if(Int(userInput) != nil && cities.indices.contains(Int(userInput)!)) {
        index = Int(userInput)!;
    } else if (getIndexFromCityName(cityName: userInput) != -1) {
        index = getIndexFromCityName(cityName: userInput);
    } else {
        print("Error! Invalid name or index.");
    }

    let userInput2 = validateInput(prompt: "Find five nearest or five farthest(n/f):")

    if (userInput2 == "n") {
        nearestInput = true;
    } else if (userInput2 == "f") {
        nearestInput = false;
    } else if (Int(userInput) == 0) {
        exit(2)
    } else {
        print("Error! Invalid response.");
    }

    let baseCity = cities[index];
    let nearestCities = sortByLocation(base: baseCity, nearest: nearestInput, amount: 5);

    for city in nearestCities {
        let distanceMeters = baseCity.location.distance(from: city.location);
        print("\(city.name),\(city.country)  GCD(meters) \(distanceMeters / 1609.344)");
    }
}
