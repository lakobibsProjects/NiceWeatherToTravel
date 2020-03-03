//
//  TodayWeatherCollectionViewCell.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 3/3/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import UIKit

class TodayWeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet var weatherImage : UIImageView?
    @IBOutlet var weatherLable: UILabel?
    @IBOutlet var timeLable: UILabel?
    @IBOutlet var temperatureLable: UILabel?
    
    var weather: OneTimeSpanWeather?{
        didSet{
            guard let weather = weather else {return}
            weatherLable?.text = weather.skyWeather
            timeLable?.text =  weather.date!
            temperatureLable?.text = "\(String(describing: weather.temperature))ºC"
            weatherImage?.image = weather.weatherImage            
        }
    }
}
