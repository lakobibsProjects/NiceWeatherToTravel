//
//  WeatherViewModel.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 2/27/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation

class WeatherViewModel{
    //private var provider: WeatherProvider
    private var forecast: WeatherForecast?
    var todayWeather: [OneTimeSpanWeather] = []
    var tomorrowWeather: [OneTimeSpanWeather] = []
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
    
    init(forecast: OneTimespanForecast){
        self.date = forecast.date
        self.temperature = forecast.generalInfo?.temperature
        self.skyWeather = forecast.shortWeather?.name
    }
}

