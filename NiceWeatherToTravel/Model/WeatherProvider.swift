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
    let APIKEY = "9c463500bb9746657580857a9929be10"
    var weatherForecast: WeatherForecast?
    //var weather: Welcome?

    func GetWeatherBySityName(sityName: String) -> WeatherForecast?{
        let urlString = "\(BASEURL)\(sityName),\(local),\(APIKEY)"
        
        getRequest(urlString: urlString)
        
        return weatherForecast ?? nil
    }
    
    func GetWeatherByCoordinates(lon: Double, lat: Double) -> WeatherForecast?{

        let urlString = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(APIKEY)"
        

        getRequest(urlString: urlString)
        
        
        return weatherForecast ?? nil
    }

    private func getRequest(urlString: String){
        AF.request(urlString).responseJSON {
                response in              
            let Forecast = Mapper<WeatherForecast>().map(JSONObject:response.value)
                self.weatherForecast = Forecast
        }
        

    }
    
    init() {

    }
    


}
