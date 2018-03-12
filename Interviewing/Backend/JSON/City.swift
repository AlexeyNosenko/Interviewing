//
//  City.swift
//  Interviewing
//
//  Created by Алексей on 25.12.2017.
//  Copyright © 2017 Алексей. All rights reserved.
//

import Foundation

class City: Codable{
    class Coord: Codable{
        let lon: Double
        let lat: Double
    }
    
    class Weather: Codable{
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    class Main: Codable{
        let temp: Double
        let pressure: Int
        let humidity: Int
        let tempMin: Double
        let tempMax: Double
        
        enum CodingKeys: String, CodingKey{
            case temp
            case pressure
            case humidity
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    class Wind: Codable{
        let speed: Double
        let deg: Int
    }
    
    class Sys: Codable {
        let type: Int
        let id: Int
        let message: Double
        let country: String
        let sunrise: Double
        let sunset: Double
    }
   
    var coord: Coord
    let weather: [Weather]
    var base: String
    var main: Main
    var visibility: Double
    var wind: Wind
    //var clouds: Clouds
    var dt: Double
    var sys: Sys
    var id: Double
    var name: String
    var cod: Int?
}
