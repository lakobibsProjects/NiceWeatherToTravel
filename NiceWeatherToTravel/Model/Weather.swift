//
//  Weather.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 2/28/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation
import ObjectMapper
/*
class Weather: Mappable{

    
    var date: String?
    var temperature: String?
    var description: String?
    
    required init?(map: Map) {
        <#code#>
    }
    
    func mapping(map: Map) {
        <#code#>
    }

    
    init(date: String, temperature: String, description: String){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:date)!
        self.date = date
        
        guard let temperature = Double(temperature) else { return }
        self.temperature = temperature
        
        self.description = WeatherDescription(rawValue: description) ?? WeatherDescription.Clear
    }
    
}

enum WeatherDescription: String{
    case Clear = "Clear"
    case Clouds = "Clouds"
    case Rain = "Rain"
    case Snow = "Snow"
    case Storm = "Storm"
}
*/

class GeneralWeatherInfo: Mappable{
    var temperature: Double?
    var feelsLikeTemperature: Double?
    var minTemperature: Double?
    var maxTemperature: Double?
    var pressure: Double?
    var humidity: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        temperature <- map["temp"]
        feelsLikeTemperature <- map["feels_like"]
        minTemperature <- map["temp_min"]
        maxTemperature <- map["temp_max"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
    }
}
class ShortWeather: Mappable{
    var name: String?
    var description: String?
        
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["main"]
        description <- map["description"]
    }
}
class Clouds: Mappable{
    var all: Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        all <- map["all"]

    }
}

class Wind: Mappable{
    var speed: Double?
    var deg: Int?
        
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        speed <- map["speed"]
        deg <- map["deg"]
    }
}

class Rain: Mappable{
    var threeH: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        threeH <- map["3h"]

    }
}


class OneTimespanForecast: Mappable{
    var dateTime: Int?
    var generalInfo: GeneralWeatherInfo?
    var shortWeather: ShortWeather?
    var clouds: Clouds?
    var wind: Wind?
    var rain: Rain?
    var date: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dateTime <- map["dt"]
        generalInfo <- map["main"]
        shortWeather <- map["weather"]
        date <- map["dt_txt"]
        clouds <- map["clouds"]
        rain <- map["rain"]
        wind <- map["wind"]
    }
}

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

class City: Mappable{
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
}


class WeatherForecast: Mappable, Any{
    var fiveDayForecast: [OneTimespanForecast]?
    var city: City?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        fiveDayForecast <- map["list"]
        city <- map["city"]
        
    }
    

}








































