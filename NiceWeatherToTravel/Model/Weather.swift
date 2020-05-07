//
//  Weather.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 2/28/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation
import ObjectMapper

class GeneralWeatherInfo: Decodable{
    var temperature: Double?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}

class ShortWeather: Decodable{
    var id: Int?
}

class OneTimespanForecast: Decodable{
    var generalInfo: GeneralWeatherInfo?
    var shortWeather: [ShortWeather]?
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
                if let id = sh[0].id{
                    return id
                }
            }
            return -1
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case generalInfo = "main"
        case shortWeather = "weather"
        case date = "dt_txt"
    }
}

class WeatherForecast: Decodable, Any{
    var fiveDayForecast: [OneTimespanForecast]?
    
    enum CodingKeys: String, CodingKey {
        case fiveDayForecast = "list"
    }
}


