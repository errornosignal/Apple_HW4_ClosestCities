//
//  City.swift
//  Apple_HW4_ClosestCities
//
//  Created by Reid Nolan on 10/8/17.
//  Copyright © 2017 Reid Nolan. All rights reserved.
//

import Foundation

//declare and init class constants
let EARTHRADIUS = 6371.0
let PI = 3.141592655358979323846

class City {
    //declare class vairables
    var cityNumber: String!
    var cityName: String!
    var country: String!
    var latitude: String!
    var longitude: String!
    var matchNumber: String!
    
    //init class variables
    init(cityNumber:String, cityName:String, country:String, latitude:String, longitude:String, matchNumber:String){
        self.cityNumber = cityNumber
        self.cityName = cityName
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.matchNumber = matchNumber
        }
    // set/get cityNumber
    func setCityNumber() -> Void {
        // add code
    }
    func getCityNumber() -> String {
        return cityNumber
    }
    
    // set/get cityName
    func setCityName() -> Void {
        // add code
    }
    func getCityName() -> String {
        return cityName
    }
    
    // set/get country
    func setCountry() -> Void {
        // add code
    }
    func getCountry() -> String {
        return country
    }
    
    // set/get latitude
    func setLatitude() -> Void {
        // add code
    }
    func getLatitude() -> String {
        return latitude
    }
    
    // set/get longitude
    func setLongitude() -> Void {
        // add code
    }
    func getLongitude() -> String {
        return longitude
    }
    
    // set/get matchNumber
    func setMatchNumber() -> Void {
        // add code
    }
    func getMatchNumber() -> String {
        return matchNumber
    }
    
    
    
}
