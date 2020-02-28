//
//  WeatherProvider.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 2/27/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation
import Alamofire

class WeatherProvider{
    
    let BASEURL = "api.openweathermap.org/data/2.5/weather?q="
    //string for determinate language of search
    var local: String = "uk"
    let APIKEY = "&appid=1c9567cd628a4dbe95f10c003ddb3c70"
    /*var weatherArray: [Weather]
    
    func GetWeatherBySityName(sityName: String) -> [Weather]{
        var result: [Weather]
        let url = URL(fileURLWithPath: "\(BASEURL)\(sityName),\(local),\(APIKEY)")
        /*
        AF.request(url).responseJSON { response in
            guard let data = response.data else {return}
            do{
                let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                result = weatherData
            }
            catch{
                print("Encoding error \(error)")
            }*/
           
        }
            
        return result
    }
    
    init(sityName: String) {
        
        
        weatherArray = []
    }*/
    
    private func KelvinToCelsiusConverter(_ kelvinTemperature: Double) -> Double{
        return kelvinTemperature - 271.15
    }

}
