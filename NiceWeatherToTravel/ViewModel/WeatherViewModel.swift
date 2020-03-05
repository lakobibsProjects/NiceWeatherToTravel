//
//  WeatherViewModel.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 2/27/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewModel{
    //private var provider: WeatherProvider
    private var forecast: WeatherForecast?
    var todayWeather: [OneTimeSpanWeather] = []
    var tomorrowWeather: [OneTimeSpanWeather] = []
    var actualForecast: [[OneTimeSpanWeather]] {
        get{
            return [todayWeather, tomorrowWeather]
        }
    }
    var today: Date
    var tomorrow: Date
    
    //TODO: too mach force execution
    //TODO: have not correction to timezone
    init(){
        today = Date()
        var tomorrowDateComponents = DateComponents()
        tomorrowDateComponents.day = +1
        tomorrow = Calendar.current.date(byAdding: tomorrowDateComponents, to: today)!

        let provider = WeatherProvider ()
            forecast = provider.weatherForecast ?? nil
        guard let fiveDayForecast = forecast?.fiveDayForecast else{return}
        
        var aftertomorrowDateComponents = DateComponents()
        aftertomorrowDateComponents.day = +2
        let aftertomorrow = Calendar.current.date(byAdding: aftertomorrowDateComponents, to: today)
        
        for wts in fiveDayForecast{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyy-mm-dd hh:mm:ss"
            let timeSpanDate = formatter.date(from: wts.date!)
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour], from: timeSpanDate!)
            let finalDate = calendar.date(from:components)
            if finalDate! >= aftertomorrow!{
                return
            }else if finalDate! < tomorrow {
                todayWeather.append(OneTimeSpanWeather(forecast: wts))
            }else if finalDate! < aftertomorrow!{
                tomorrowWeather.append(OneTimeSpanWeather(forecast: wts))
            }
            
            
        }
    }
}

class OneTimeSpanWeather{
    var date: String?
    var temperature: Double?
    var skyWeather: String?
    var weatherImage: UIImage?
    
    init(forecast: OneTimespanForecast){
        if let date = forecast.date{
            self.date = String(String(date.suffix(8)).prefix(5))
        }
        self.temperature = KelvinToCelsiusConverter (forecast.temp)
        let id =  forecast.weatherId
        if (id > 800){
            self.skyWeather = "Clouds"
            weatherImage = UIImage(contentsOfFile: "Few_Clouds")
        } else if (id == 800){
            self.skyWeather = "Clear sky"
            weatherImage = UIImage(contentsOfFile: "Clear_Sky")
        } else if (id > 700){
            self.skyWeather = "Mist"
            weatherImage = UIImage(contentsOfFile: "Mist")
        } else if (id > 600){
            self.skyWeather = "Snow"
            weatherImage = UIImage(contentsOfFile: "Snow")
        } else if (id > 500){
            self.skyWeather = "Rain"
            weatherImage = UIImage(contentsOfFile: "Rain")
        }  else if (id > 300){
            self.skyWeather = "Drizzle"
            weatherImage = UIImage(contentsOfFile: "Shower_Rain")
        } else if (id > 200){
            self.skyWeather = "Thunderstorm"
            weatherImage = UIImage(contentsOfFile: "Thunderstorm")
        }
        
        //self.skyWeather = forecast.shortWeather?.name
    }
    
    private func KelvinToCelsiusConverter(_ kelvinTemperature: Double?) -> Double{
        guard let temp = kelvinTemperature else {return 0}
        return  temp - 271.15
    }
}

