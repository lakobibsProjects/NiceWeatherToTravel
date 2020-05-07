//
//  TodayWeatherCollectionViewCell.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 3/3/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import UIKit

class OneDayWeatherCollectionViewCell: UICollectionViewCell {
    
    var weather: OneTimeSpanWeather?
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
