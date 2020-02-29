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

    
    //var weatherArray: [Weather]
    
    func GetWeatherBySityName(sityName: String) -> WeatherForecast?{
        //var result: [Weather]
        let urlString = "\(BASEURL)\(sityName),\(local),\(APIKEY)"
        //let url = URL(fileURLWithPath: urlString)
        //var response: AFDataResponse<WeatherForecast?>?
        
       /* AF.request(urlString).responseJSON{ (response: AFDataResponse<WeatherForecast>)in
            let responseObject = response.result
            
        }*/
        
        AF.request(
            urlString,
            method: .get,
            headers: nil).responseJSON {
                response in
            let Forecast = Mapper<WeatherForecast>().map(JSONObject:response.value)
                self.weatherForecast = Forecast
        }
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
           return weatherForecast ?? nil
        }
            
        //return result
    
    
    init(sityName: String) {
        
        
        //weatherArray = []
    }
    
    private func KelvinToCelsiusConverter(_ kelvinTemperature: Double) -> Double{
        return kelvinTemperature - 271.15
    }

}
