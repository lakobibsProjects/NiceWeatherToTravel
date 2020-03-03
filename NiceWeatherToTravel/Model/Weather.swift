//
//  Weather.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 2/28/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation
import ObjectMapper

class GeneralWeatherInfo: Mappable{
    var temperature: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        temperature <- map["temp"]

    }
}

class ShortWeather: Mappable{
    var id: Int?
        
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
    }
}

class OneTimespanForecast: Mappable{
    var generalInfo: GeneralWeatherInfo?
    var shortWeather: ShortWeather?
    var date: String?
    
    var temp: Double {
        get{
            if let gi = generalInfo {
                if let temp = gi.temperature{
                    return temp
                }
            }
            return 0.0
        }
    }
    var weatherId: Int{
        get{
            if let sh = shortWeather{
                if let id = sh.id{
                    return id
                }
            }
            return -1
        }
    }
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        generalInfo <- map["main"]
        shortWeather <- map["weather"]
        date <- map["dt_txt"]
    }
}

class WeatherForecast: Mappable, Any{
    var fiveDayForecast: [OneTimespanForecast]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        fiveDayForecast <- map["list"]
    }
    

}

/*
class Coordinates: Mappable{
    var longatitude: Double?
    var latitude: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        longatitude <- map["lon"]
        latitude <- map["lat"]
    }
}

class WeatherCity: Mappable{
    var id: Int?
    var name: String?
    var coordinates: Coordinates?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        coordinates <- map["coord"]
    }
}*/

/*
class WeatherClouds: Mappable{
    var all: Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        all <- map["all"]

    }
}
 */
/*
class WeatherWind: Mappable{
    var speed: Double?
    var deg: Int?
        
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        speed <- map["speed"]
        deg <- map["deg"]
    }
}
*/
/*
class WeatherRain: Mappable{
    var threeH: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        threeH <- map["3h"]

    }
}
*/







































