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
    
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var sightsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = WeatherViewModel(lon: city!.lon, lat: city!.lat)
        
        weatherTableView.rowHeight = 180
        
        if let vm = vm  {
            let df = DateFormatter()
            df.dateFormat = "dd MMM yyyy"
            
            todayForecast = vm.todayWeather
            tomorrowForecast = vm.tomorrowWeather
        }
        
        provider = WeatherProvider()
        weatherForecast = provider?.GetWeatherByCoordinates(lon: city!.lon, lat: city!.lat)
        if let city = city{
            centerMapOnLocation(location: CLLocation(latitude: city.lat, longitude: city.lon))
        }
        cityNameLabel.text = city?.name
        enableSightsButton()
    }
    
    let regionRadius: CLLocationDistance = 5000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    //TODO: remove hardcode
    private func enableSightsButton(){
        if city?.name == "Kaliningrad" ||
            city?.name == "Moscow" ||
            city?.name == "Paris" ||
            city?.name == "Rome" ||
            city?.name == "London" {
            sightsButton.isEnabled = true
            sightsButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        } else{
            sightsButton.isEnabled = false
            sightsButton.backgroundColor = #colorLiteral(red: 0, green: 0.3208971259, blue: 0.7602739726, alpha: 1)
            sightsButton.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .disabled)
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

    // MARK: - TableView setup
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "oneDayWeatherCell", for: indexPath) as? OneDayWeatherTableViewCell{
            cell.forecast = vm?.actualForecast[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        if let vm = vm{
            switch section {
            case 0:
                return String("Today: \(formatter.string(from:vm.today))")
            case 1:
                return String("Today: \(formatter.string(from:vm.tomorrow))")
            default:
                return ""
            }
        }else {return ""}
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}




