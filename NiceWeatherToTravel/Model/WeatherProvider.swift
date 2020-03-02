//
//  WeatherProvider.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 2/27/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class WeatherProvider{
    
    let BASEURL = "api.openweathermap.org/data/2.5/weather?q="
    //string for determinate language of search
    var local: String = "uk"
    let APIKEY = "&appid=1c9567cd628a4dbe95f10c003ddb3c70"
    var weatherForecast: WeatherForecast?

    func GetWeatherBySityName(sityName: String) -> WeatherForecast?{

        let urlString = "\(BASEURL)\(sityName),\(local),\(APIKEY)"

        AF.request(
            urlString,
            method: .get,
            headers: nil).responseJSON {
                response in
            let Forecast = Mapper<WeatherForecast>().map(JSONObject:response.value)
                self.weatherForecast = Forecast
        }

           return weatherForecast ?? nil
        }
            

    
    
    init(sityName: String) {

    }
    
    private func KelvinToCelsiusConverter(_ kelvinTemperature: Double) -> Double{
        return kelvinTemperature - 271.15
    }

}
