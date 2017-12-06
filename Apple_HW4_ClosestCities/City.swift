//
//  City.swift
//  Apple_HW4_ClosestCities
//
//  Created by Reid Nolan on 10/8/17.
//  Copyright © 2017 Reid Nolan. All rights reserved.
//

//
import Foundation

//declare and init class constants
let EARTHRADIUS = 6371.0
let PI = 3.141592655358979323846

class City {
    //declare class vairables
    let cityNumber: String!
    let cityName: String!
    let country: String!
    let latitude: Double
    let longitude: Double
    let matchNumber: Int
    
    //init class variables
    init(cityNumber:String, cityName:String, country:String, latitude:Double, longitude:Double, matchNumber:Int){
        self.cityNumber = cityNumber
        self.cityName = cityName
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.matchNumber = matchNumber
        }

    func getCityNumber() -> String {
        return self.cityNumber
    }

    func getCityName() -> String {
        return self.cityName
    }
    
    func getCountry() -> String {
        return self.country
    }

    func getLatitude() -> Double {
        return self.latitude
    }
    
    func getLongitude() -> Double {
        return self.longitude
    }
    
    func getMatchNumber() -> Int {
        return self.matchNumber
    }
}
    
////    func setCityNumber() -> Void {
////
////        // add code
////    }
////
////    func setCityName() -> Void {
////        // add code
////    }
////
////    func setCountry() -> Void {
////        // add code
////    }
////
////    func setLatitude() -> Void {
////        // add code
////    }
////
////    func setLongitude() -> Void {
////        // add code
////    }
////
////    func setMatchNumber() -> Void {
////        // add code
////    }
//}
