//
//  OneDayWeatherTableViewCell.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 3/4/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import UIKit

class OneDayWeatherTableViewCell: UITableViewCell {
    
    var vm: WeatherViewModel?
    var forecast: [OneTimeSpanWeather]?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension OneDayWeatherTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let forecast = forecast else { return 0 }
            return forecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: OneDayWeatherCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "oneTimeSpanWeather", for: indexPath) as? OneDayWeatherCollectionViewCell
        {
            guard let forecast = forecast else {return UICollectionViewCell() }
            //cell.weather = forecast[indexPath.row]
            if let t = forecast[indexPath.row].temperature{
                let temp = String(format:"%.1f", t)
                cell.temperatureLabel.text = temp + "ºC"
            }
            //cell.temperatureLabel.text = String("\(forecast[indexPath.row].temperature)")
            cell.timeLabel.text = forecast[indexPath.row].date
            cell.weatherImage.image = forecast[indexPath.row].weatherImage
            cell.weatherLabel.text = forecast[indexPath.row].skyWeather
            
            return cell
        }
            return UICollectionViewCell()
        }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
