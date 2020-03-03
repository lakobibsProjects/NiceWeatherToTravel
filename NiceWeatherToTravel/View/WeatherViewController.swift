//
//  WeatherViewController.swift
//  NiceWhetherToTravel
//
//  Created by user166683 on 2/25/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import UIKit
import MapKit

class WeatherViewController: UIViewController {

    var city: ParsedCity?
    var provider: WeatherProvider?
    var vm: WeatherViewModel?
    var weatherForecast: WeatherForecast?
    var todayForecast: [OneTimeSpanWeather]?
    var tomorrowForecast: [OneTimeSpanWeather]?
    var location: CLLocation?
    let collectionViewToday = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let collectionViewTomorrow = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let collectionViewTodayIdentifier = "CollectionViewTodayCell"
    let collectionViewTomorrowIdentifier = "CollectionViewTomorrowCell"
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var tomorrowLabel: UILabel!
    @IBOutlet weak var sightsButton: UIButton!
    @IBOutlet weak var todayCollectionView: UICollectionView!
    @IBOutlet weak var tomorrowCollectionView: UICollectionView!
    
    
    
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = WeatherViewModel()
        
        todayCollectionView.dataSource = self
        todayCollectionView.delegate = self
        
        
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        collectionViewToday.setCollectionViewLayout(layout, animated: true)
        collectionViewToday.delegate = self
        collectionViewToday.dataSource = self
        collectionViewToday.backgroundColor = UIColor.clear
        
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        collectionViewTomorrow.setCollectionViewLayout(layout, animated: true)
        collectionViewTomorrow.delegate = self
        collectionViewTomorrow.dataSource = self
        collectionViewTomorrow.backgroundColor = UIColor.clear
        
        tomorrowCollectionView.dataSource = self
        tomorrowCollectionView.delegate = self
        
        self.view.addSubview(collectionViewToday)
        self.view.addSubview(collectionViewTomorrow)
        
        if let vm = vm  {
            let df = DateFormatter()
            df.dateFormat = "dd MMM yyyy"
            let today = df.string(from: vm.today)
            let tomorrow = df.string(from: vm.tomorrow)

            todayLabel.text = ("Today is \(today)")
            tomorrowLabel.text  = ("Tomorrow will be \(tomorrow)")
            todayForecast = vm.todayWeather
            tomorrowForecast = vm.tomorrowWeather
            
            
        }
        
        provider = WeatherProvider()
        weatherForecast = provider?.GetWeatherByCoordinates(lon: city!.lon!, lat: city!.lat!)
        if let city = city{
            if let lat = city.lat, let lon  = city.lon{
                location = CLLocation(latitude: lat, longitude: lon)
            }
        }
        if let loc = location{
            centerMapOnLocation(location: loc)
        }
        cityNameLabel.text = city?.name
        enableSightsButton()
        
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            map.setRegion(coordinateRegion, animated: true)
    }


    @IBAction func sightButtonPressed(_ sender: UIButton) {
        
    }
    
    private func enableSightsButton(){
        if city?.name == "Kaliningrad" ||
            city?.name == "Moscow" ||
            city?.name == "Paris" ||
            city?.name == "Rome" ||
            city?.name == "London" {
            sightsButton.isEnabled = true
        } else{
            sightsButton.isEnabled = false
        }
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSights"{
            let sightsVC = segue.destination as! SightsViewController
            switch city?.name {
            case "Kaliningrad":
                sightsVC.sityName = "Kalinigrad"
            case "Moscow":
                sightsVC.sityName = "Moscow"
            case "Paris":
                sightsVC.sityName = "Paris"
            case "Rome":
                sightsVC.sityName = "Rome"
            case "London":
                sightsVC.sityName = "London"
            default:
                return
            }            
        }
    }
    

}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if collectionView == self.todayCollectionView {
        return todayForecast?.count  ?? 0
        }

        return tomorrowForecast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if collectionView == self.todayCollectionView {
            let cellToday: TodayWeatherCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayWeatherCell", for: indexPath) as! TodayWeatherCollectionViewCell
            if let tdf = todayForecast {
                cellToday.weather = tdf[indexPath.row]
            }
            
               return cellToday
           }

           else  {
            let cellTomorrow: TomorrowWeatherCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tomorrowWeatherCell", for: indexPath) as! TomorrowWeatherCollectionViewCell

            if let tmf = tomorrowForecast {
                    cellTomorrow.weather = tmf[indexPath.row]
                }

               return cellTomorrow
           }
    }
    
    
}




